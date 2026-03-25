from __future__ import annotations
import re
import pglast
from pglast import parse_sql
from pglast.ast import (
    CreateStmt, ViewStmt, CreateTrigStmt, CommentStmt,
    AlterSeqStmt, AlterTableStmt,
)
from pglast.enums import AlterTableType


def read_file(path: str) -> str:
    with open(path, encoding="utf-8") as f:
        return f.read()


def parse_ddl(sql_text: str) -> tuple[list[tuple[object, str]], list[tuple[str, str]]]:
    """
    Parse DDL with pglast. Returns:
      accepted: list of (stmt_node, raw_sql_text)
      failed:   list of (object_type_hint, name_hint)
    """
    accepted: list[tuple[object, str]] = []
    failed: list[tuple[str, str]] = []

    # Try whole-file parse first (most accurate)
    try:
        raw_stmts = parse_sql(sql_text)
        for raw in raw_stmts:
            try:
                # stmt_location and stmt_len are CHARACTER offsets (not byte offsets)
                start = raw.stmt_location or 0
                length = raw.stmt_len or 0
                end = start + length if length else len(sql_text)
                raw_text = sql_text[start:end].strip()

                stmt = raw.stmt
                if _should_exclude(stmt):
                    continue
                accepted.append((stmt, raw_text))
            except Exception as e:
                failed.append(("UNKNOWN", f"stmt processing error: {e}"))
        return accepted, failed
    except pglast.Error:
        pass  # Fall through to statement-by-statement parsing

    # Fallback: split statements manually (handles files with invalid individual statements)
    for raw_text in _split_statements(sql_text):
        raw_text = raw_text.strip()
        if not raw_text:
            continue
        try:
            stmts = parse_sql(raw_text)
            if not stmts:
                continue
            stmt = stmts[0].stmt
            if _should_exclude(stmt):
                continue
            accepted.append((stmt, raw_text))
        except pglast.Error:
            # Record the failed statement with a type hint
            obj_type, obj_name = _guess_object_type(raw_text)
            failed.append((obj_type, obj_name))
        except Exception as e:
            failed.append(("UNKNOWN", f"error: {e}"))

    return accepted, failed


def _split_statements(sql_text: str) -> list[str]:
    """
    Split SQL text into individual statements, respecting dollar-quoted strings.
    A semicolon followed by a newline (outside dollar quotes) marks statement boundaries.
    """
    statements = []
    current: list[str] = []
    i = 0
    in_dollar_quote = False
    dollar_tag = ""
    n = len(sql_text)

    while i < n:
        # Check for dollar-quote start/end
        if sql_text[i] == "$":
            # Find the matching closing $
            j = sql_text.find("$", i + 1)
            if j != -1:
                tag = sql_text[i:j + 1]
                if not in_dollar_quote:
                    in_dollar_quote = True
                    dollar_tag = tag
                    current.append(sql_text[i:j + 1])
                    i = j + 1
                    continue
                elif tag == dollar_tag:
                    in_dollar_quote = False
                    dollar_tag = ""
                    current.append(sql_text[i:j + 1])
                    i = j + 1
                    continue

        if not in_dollar_quote and sql_text[i] == ";":
            # Statement boundary
            current.append(";")
            stmt = "".join(current).strip()
            if stmt and stmt != ";":
                statements.append(stmt)
            current = []
            i += 1
            continue

        current.append(sql_text[i])
        i += 1

    # Remaining text
    leftover = "".join(current).strip()
    if leftover:
        statements.append(leftover)

    return statements


def _guess_object_type(sql: str) -> tuple[str, str]:
    """Guess the object type and name from a SQL statement for error reporting."""
    sql_upper = sql.strip().upper()
    patterns = [
        (r"CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?(\S+)", "TABLE"),
        (r"CREATE\s+(?:UNIQUE\s+)?INDEX\s+(?:IF\s+NOT\s+EXISTS\s+)?(\S+)", "INDEX"),
        (r"CREATE\s+(?:OR\s+REPLACE\s+)?FUNCTION\s+(\S+)", "FUNCTION"),
        (r"CREATE\s+SEQUENCE\s+(?:IF\s+NOT\s+EXISTS\s+)?(\S+)", "SEQUENCE"),
    ]
    for pattern, obj_type in patterns:
        m = re.search(pattern, sql_upper)
        if m:
            # Extract name from original sql (preserve case)
            m2 = re.search(pattern, sql, re.IGNORECASE)
            name = m2.group(1) if m2 else m.group(1)
            return obj_type, name.strip("(").rstrip(";")
    return "UNKNOWN", sql[:60].replace("\n", " ")


def _should_exclude(stmt) -> bool:
    """Return True for nodes that must be skipped."""
    if isinstance(stmt, ViewStmt):
        return True
    if isinstance(stmt, CreateTrigStmt):
        return True
    if isinstance(stmt, CommentStmt):
        return True
    if isinstance(stmt, AlterSeqStmt):
        # Skip all ALTER SEQUENCE (owner changes, etc.)
        return True

    if isinstance(stmt, CreateStmt):
        # PARTITION OF table
        if stmt.partbound is not None:
            return True
        # INHERITS table (old-style partitioning)
        if stmt.inhRelations:
            return True
        return False

    if isinstance(stmt, AlterTableStmt):
        # Skip if all commands are ownership/storage changes
        if stmt.cmds:
            _SKIP_SUBTYPES = {
                AlterTableType.AT_ChangeOwner,
                AlterTableType.AT_SetStatistics,
                AlterTableType.AT_SetRelOptions,
                AlterTableType.AT_ResetRelOptions,
                AlterTableType.AT_ClusterOn,
                AlterTableType.AT_DropCluster,
                AlterTableType.AT_SetLogged,
                AlterTableType.AT_SetUnLogged,
            }
            if all(cmd.subtype in _SKIP_SUBTYPES for cmd in stmt.cmds):
                return True
        return False

    return False
