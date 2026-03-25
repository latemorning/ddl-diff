from __future__ import annotations
import re
from pglast.ast import (
    CreateStmt, IndexStmt, CreateFunctionStmt, CreateSeqStmt,
    AlterTableStmt, ColumnDef, Constraint, TypeName, A_Const,
    Integer, Float, String,
)
from pglast.enums import ConstrType, AlterTableType
from .models import (
    ColumnMeta, ConstraintMeta, IndexMeta,
    TableMeta, FunctionMeta, SequenceMeta, SchemaSnapshot,
)

# Internal PostgreSQL type name → SQL name mapping
_TYPE_MAP = {
    "int4": "integer",
    "int8": "bigint",
    "int2": "smallint",
    "float4": "real",
    "float8": "double precision",
    "bool": "boolean",
    "bpchar": "char",
    "varchar": "varchar",
    "text": "text",
    "timestamptz": "timestamp with time zone",
    "timetz": "time with time zone",
    "numeric": "numeric",
    "date": "date",
    "time": "time",
    "timestamp": "timestamp",
    "bytea": "bytea",
    "json": "json",
    "jsonb": "jsonb",
    "uuid": "uuid",
    "oid": "oid",
    "name": "name",
    "xml": "xml",
    "int4range": "int4range",
    "int8range": "int8range",
    "numrange": "numrange",
    "tsrange": "tsrange",
    "tstzrange": "tstzrange",
    "daterange": "daterange",
}


def build_snapshot(
    accepted: list[tuple[object, str]],
    failed: list[tuple[str, str]],
) -> SchemaSnapshot:
    snap = SchemaSnapshot(failed_statements=list(failed))

    # Pass 1: tables, indexes, functions, sequences
    alter_table_items: list[tuple[object, str]] = []

    for stmt, raw_sql in accepted:
        try:
            if isinstance(stmt, CreateStmt):
                table = _map_table(stmt, raw_sql)
                snap.tables[table.name] = table
            elif isinstance(stmt, IndexStmt):
                idx = _map_index(stmt, raw_sql)
                snap.indexes[idx.name] = idx
            elif isinstance(stmt, CreateFunctionStmt):
                fn = _map_function(stmt, raw_sql)
                snap.functions[fn.name] = fn
            elif isinstance(stmt, CreateSeqStmt):
                seq = _map_sequence(stmt, raw_sql)
                snap.sequences[seq.name] = seq
            elif isinstance(stmt, AlterTableStmt):
                alter_table_items.append((stmt, raw_sql))
        except Exception as e:
            tag = type(stmt).__name__
            snap.failed_statements.append((_hint_type(tag), f"mapping error: {e}"))

    # Pass 2: AlterTableStmt — attach constraints to existing tables
    for stmt, raw_sql in alter_table_items:
        try:
            _map_alter_table(stmt, snap)
        except Exception as e:
            try:
                tname = stmt.relation.relname
            except Exception:
                tname = "unknown"
            snap.failed_statements.append(("ALTER_TABLE", f"{tname}: {e}"))

    # Remove orphan indexes (those belonging to excluded partition tables)
    orphan = [
        name for name, idx in snap.indexes.items()
        if idx.table_name not in snap.tables
    ]
    for name in orphan:
        del snap.indexes[name]

    return snap


def _hint_type(tag: str) -> str:
    return {
        "CreateStmt": "TABLE",
        "IndexStmt": "INDEX",
        "CreateFunctionStmt": "FUNCTION",
        "CreateSeqStmt": "SEQUENCE",
        "AlterTableStmt": "ALTER_TABLE",
    }.get(tag, tag)


def _map_table(stmt: CreateStmt, raw_sql: str) -> TableMeta:
    name = stmt.relation.relname
    columns: list[ColumnMeta] = []
    constraints: list[ConstraintMeta] = []

    if stmt.tableElts:
        for elt in stmt.tableElts:
            if isinstance(elt, ColumnDef):
                try:
                    columns.append(_map_column(elt))
                except Exception:
                    pass
            elif isinstance(elt, Constraint):
                try:
                    con = _map_constraint(elt)
                    if con:
                        constraints.append(con)
                except Exception:
                    pass

    return TableMeta(name=name, columns=columns, constraints=constraints, raw_sql=raw_sql)


def _map_column(col: ColumnDef) -> ColumnMeta:
    name = col.colname
    type_str = "unknown"
    if col.typeName:
        try:
            type_str = _extract_type_str(col.typeName)
        except Exception:
            pass

    not_null = bool(col.is_not_null)
    default = None
    is_pk = False
    is_fk = False
    is_uk = False

    if col.constraints:
        for con in col.constraints:
            ct = con.contype
            if ct == ConstrType.CONSTR_NOTNULL:
                not_null = True
            elif ct == ConstrType.CONSTR_DEFAULT:
                try:
                    default = _extract_default_expr(con)
                except Exception:
                    default = "expression"
            elif ct == ConstrType.CONSTR_PRIMARY:
                is_pk = True
                not_null = True
            elif ct == ConstrType.CONSTR_FOREIGN:
                is_fk = True
            elif ct == ConstrType.CONSTR_UNIQUE:
                is_uk = True

    return ColumnMeta(
        name=name, type_str=type_str, not_null=not_null,
        default=default, is_pk=is_pk, is_fk=is_fk, is_uk=is_uk,
    )


def _extract_type_str(tn: TypeName) -> str:
    # Get base type name (last String, skip pg_catalog)
    base = None
    if tn.names:
        for n in reversed(tn.names):
            if isinstance(n, String) and n.sval != "pg_catalog":
                base = n.sval
                break
    if base is None:
        base = "unknown"

    base = _TYPE_MAP.get(base, base)

    # Type modifiers
    mods = []
    if tn.typmods:
        for tm in tn.typmods:
            if isinstance(tm, A_Const):
                v = tm.val
                if isinstance(v, Integer):
                    mods.append(v.ival)
                elif isinstance(v, Float):
                    try:
                        mods.append(int(float(v.fval)))
                    except Exception:
                        pass
            elif isinstance(tm, Integer):
                mods.append(tm.ival)

    if mods:
        if base in ("varchar", "char"):
            base = f"{base}({mods[0]})"
        elif base == "numeric":
            if len(mods) >= 2:
                base = f"numeric({mods[0]},{mods[1]})"
            else:
                base = f"numeric({mods[0]})"
        elif base in ("timestamp", "time", "timestamp with time zone", "time with time zone"):
            if mods[0] != -1:
                base = f"{base}({mods[0]})"

    # Array type
    if tn.arrayBounds:
        base = base + "[]"

    return base


def _extract_default_expr(con: Constraint) -> str | None:
    """Extract a readable default value from a DEFAULT constraint."""
    expr = con.raw_expr
    if expr is None:
        return None

    from pglast.ast import A_Const, FuncCall, TypeCast, ColumnRef, A_Expr
    if isinstance(expr, A_Const):
        v = expr.val
        if isinstance(v, Integer):
            return str(v.ival)
        if isinstance(v, Float):
            return str(v.fval)
        if isinstance(v, String):
            return f"'{v.sval}'"
        if hasattr(v, "isnull") or expr.isnull:
            return "NULL"
        return "expression"
    if isinstance(expr, FuncCall):
        parts = [n.sval for n in expr.funcname if isinstance(n, String)]
        fn = ".".join(parts)
        return f"{fn}()"
    if isinstance(expr, TypeCast):
        return "expression"
    if isinstance(expr, ColumnRef):
        return "expression"
    return "expression"


def _map_constraint(con: Constraint) -> ConstraintMeta | None:
    ct = con.contype
    if ct == ConstrType.CONSTR_PRIMARY:
        contype = "PK"
    elif ct == ConstrType.CONSTR_UNIQUE:
        contype = "UK"
    elif ct == ConstrType.CONSTR_FOREIGN:
        contype = "FK"
    elif ct == ConstrType.CONSTR_CHECK:
        contype = "CHECK"
    else:
        return None

    name = con.conname or None

    columns: list[str] = []
    if con.keys:
        columns = [k.sval for k in con.keys if isinstance(k, String)]

    ref_table = None
    ref_columns: list[str] = []
    if contype == "FK":
        if con.pktable:
            ref_table = con.pktable.relname
        if con.pk_attrs:
            ref_columns = [a.sval for a in con.pk_attrs if isinstance(a, String)]

    return ConstraintMeta(
        name=name, contype=contype, columns=columns,
        ref_table=ref_table, ref_columns=ref_columns,
        check_expr="check_expression" if contype == "CHECK" else None,
    )


def _map_index(stmt: IndexStmt, raw_sql: str) -> IndexMeta:
    name = stmt.idxname or "unnamed_index"
    table_name = stmt.relation.relname

    columns: list[str] = []
    if stmt.indexParams:
        for p in stmt.indexParams:
            if p.name:
                columns.append(p.name)

    unique = bool(stmt.unique)

    return IndexMeta(name=name, table_name=table_name, columns=columns, unique=unique, raw_sql=raw_sql)


def _map_function(stmt: CreateFunctionStmt, raw_sql: str) -> FunctionMeta:
    name_parts = [n.sval for n in stmt.funcname if isinstance(n, String)]
    name = name_parts[-1] if name_parts else "unknown_function"
    return FunctionMeta(name=name, normalized_body=_normalize_whitespace(raw_sql))


def _map_sequence(stmt: CreateSeqStmt, raw_sql: str) -> SequenceMeta:
    name = stmt.sequence.relname
    options = _parse_seq_options(stmt)
    return SequenceMeta(name=name, normalized_body=_normalize_whitespace(raw_sql), options=options)


def _parse_seq_options(stmt: CreateSeqStmt) -> dict:
    """Extract sequence options from CreateSeqStmt.options (list of DefElem).

    pglast stores values as:
    - Small integers  → Integer (access .ival)
    - Large integers  → Float   (access .fval, convert to int)
    - Booleans (cycle)→ Boolean (access .boolval)
    - NO MAXVALUE etc → None arg
    """
    from pglast.ast import DefElem, Float, Boolean
    opts: dict = {}
    if not stmt.options:
        return opts
    for opt in stmt.options:
        if not isinstance(opt, DefElem):
            continue
        key = opt.defname
        arg = opt.arg
        if arg is None:
            opts[key] = None  # NO MAXVALUE / NO MINVALUE etc.
        elif isinstance(arg, Integer):
            opts[key] = arg.ival
        elif isinstance(arg, Float):
            # Large numbers (e.g. maxvalue 99999999999999) come as Float
            try:
                opts[key] = int(arg.fval)
            except (ValueError, TypeError):
                opts[key] = arg.fval
        elif isinstance(arg, Boolean):
            opts[key] = arg.boolval
        else:
            # Fallback
            try:
                opts[key] = arg.ival
            except Exception:
                opts[key] = None
    return opts


def _map_alter_table(stmt: AlterTableStmt, snap: SchemaSnapshot) -> None:
    table_name = stmt.relation.relname
    table = snap.tables.get(table_name)
    if table is None or not stmt.cmds:
        return

    for cmd in stmt.cmds:
        if cmd.subtype == AlterTableType.AT_AddConstraint:
            try:
                con = _map_constraint(cmd.def_)
                if con:
                    table.constraints.append(con)
            except Exception:
                pass
        elif cmd.subtype == AlterTableType.AT_AddColumn:
            try:
                col = _map_column(cmd.def_)
                table.columns.append(col)
            except Exception:
                pass


def _normalize_whitespace(text: str) -> str:
    text = re.sub(r"\s+", " ", text).strip()
    # Remove trailing semicolon for consistent comparison
    text = text.rstrip(";").strip()
    text = re.sub(r"\bSET DEFAULT now\b(?!\s*\()", "SET DEFAULT now()", text)
    return text
