from __future__ import annotations
from .models import (
    SchemaSnapshot, TableMeta, ColumnMeta, ConstraintMeta,
    IndexMeta, FunctionMeta, SequenceMeta, SyncCommand,
)


def compare(source: SchemaSnapshot, target: SchemaSnapshot) -> list[SyncCommand]:
    commands: list[SyncCommand] = []
    commands.extend(_compare_sequences(source, target))
    commands.extend(_compare_tables(source, target))
    commands.extend(_compare_indexes(source, target))
    commands.extend(_compare_functions(source, target))
    return commands


# ─── Sequences ───────────────────────────────────────────────────────────────

def _compare_sequences(src: SchemaSnapshot, tgt: SchemaSnapshot) -> list[SyncCommand]:
    cmds = []
    src_names = set(src.sequences)
    tgt_names = set(tgt.sequences)

    for name in sorted(src_names - tgt_names):
        seq = src.sequences[name]
        cmds.append(SyncCommand(
            operation="ADD", object_type="SEQUENCE", object_name=name,
            sql=_seq_create_sql(seq.normalized_body),
        ))

    for name in sorted(tgt_names - src_names):
        cmds.append(SyncCommand(
            operation="DROP", object_type="SEQUENCE", object_name=name,
            sql=f"DROP SEQUENCE IF EXISTS {name};",
            is_dangerous=True,
        ))

    for name in sorted(src_names & tgt_names):
        if src.sequences[name].normalized_body != tgt.sequences[name].normalized_body:
            diff_note = _diff_seq_options(
                src.sequences[name].options,
                tgt.sequences[name].options,
            )
            cmds.append(SyncCommand(
                operation="MODIFY", object_type="SEQUENCE", object_name=name,
                sql=_seq_alter_sql(name, src.sequences[name].options),
                previous=diff_note,
            ))

    return cmds


def _diff_seq_options(src_opts: dict, tgt_opts: dict) -> str:
    """Return human-readable list of changed sequence properties (target → source)."""
    all_keys = sorted(set(src_opts) | set(tgt_opts))
    diffs = []

    for key in all_keys:
        src_val = src_opts.get(key, "(not set)")
        tgt_val = tgt_opts.get(key, "(not set)")
        if src_val == tgt_val:
            continue

        def fmt(v, k=key):
            if v == "(not set)":
                return "(not set)"
            if v is None:
                return f"NO {k.upper()}"
            if k == "cycle":
                return "CYCLE" if v else "NO CYCLE"
            return str(v)

        diffs.append(f"{key}: {fmt(tgt_val)} → {fmt(src_val)}")

    return ", ".join(diffs) if diffs else "whitespace/formatting only"


def _seq_create_sql(body: str) -> str:
    body = body.rstrip(";").strip()
    return body + ";"


def _seq_alter_sql(name: str, options: dict) -> str:
    """Generate ALTER SEQUENCE with all properties explicitly set from source options.
    Options not present in source are reset to PostgreSQL defaults.
    """
    parts = []

    increment = options.get("increment")
    parts.append(f"INCREMENT BY {increment}" if increment is not None else "INCREMENT BY 1")

    # minvalue: None key means NO MINVALUE was explicit; missing key also means default
    if "minvalue" in options and options["minvalue"] is not None:
        parts.append(f"MINVALUE {options['minvalue']}")
    else:
        parts.append("NO MINVALUE")

    if "maxvalue" in options and options["maxvalue"] is not None:
        parts.append(f"MAXVALUE {options['maxvalue']}")
    else:
        parts.append("NO MAXVALUE")

    start = options.get("start")
    parts.append(f"START WITH {start}" if start is not None else "START WITH 1")

    cache = options.get("cache")
    parts.append(f"CACHE {cache}" if cache is not None else "CACHE 1")

    # cycle: pglast stores as Integer(1) for CYCLE, Integer(0) for NO CYCLE
    cycle = options.get("cycle")
    parts.append("CYCLE" if cycle else "NO CYCLE")

    return f"ALTER SEQUENCE IF EXISTS {name}\n    " + "\n    ".join(parts) + ";"


# ─── Tables ──────────────────────────────────────────────────────────────────

def _compare_tables(src: SchemaSnapshot, tgt: SchemaSnapshot) -> list[SyncCommand]:
    cmds = []
    src_names = set(src.tables)
    tgt_names = set(tgt.tables)

    for name in sorted(src_names - tgt_names):
        tbl = src.tables[name]
        cmds.append(SyncCommand(
            operation="ADD", object_type="TABLE", object_name=name,
            sql=tbl.raw_sql.rstrip(";") + ";",
        ))

    for name in sorted(tgt_names - src_names):
        cmds.append(SyncCommand(
            operation="DROP", object_type="TABLE", object_name=name,
            sql=f"DROP TABLE IF EXISTS {name};",
            is_dangerous=True,
        ))

    for name in sorted(src_names & tgt_names):
        detail_cmds = _compare_table_detail(src.tables[name], tgt.tables[name])
        cmds.extend(detail_cmds)

    return cmds


def _compare_table_detail(src: TableMeta, tgt: TableMeta) -> list[SyncCommand]:
    cmds: list[SyncCommand] = []
    name = src.name

    # ── Columns ──
    src_cols = {c.name: c for c in src.columns}
    tgt_cols = {c.name: c for c in tgt.columns}

    for col_name in sorted(set(src_cols) - set(tgt_cols)):
        col = src_cols[col_name]
        col_def = _column_def_sql(col)
        cmds.append(SyncCommand(
            operation="ADD", object_type="COLUMN",
            object_name=f"{name}.{col_name}",
            sql=f"ALTER TABLE {name} ADD COLUMN {col_def};",
        ))

    for col_name in sorted(set(tgt_cols) - set(src_cols)):
        cmds.append(SyncCommand(
            operation="DROP", object_type="COLUMN",
            object_name=f"{name}.{col_name}",
            sql=f"ALTER TABLE {name} DROP COLUMN {col_name};",
            is_dangerous=True,
        ))

    for col_name in sorted(set(src_cols) & set(tgt_cols)):
        sc = src_cols[col_name]
        tc = tgt_cols[col_name]
        col_cmds = _compare_column(name, sc, tc)
        cmds.extend(col_cmds)

    # ── Constraints ──
    con_cmds = _compare_constraints(name, src.constraints, tgt.constraints)
    cmds.extend(con_cmds)

    return cmds


def _compare_column(table_name: str, src: ColumnMeta, tgt: ColumnMeta) -> list[SyncCommand]:
    cmds = []
    col = src.name

    if src.type_str != tgt.type_str:
        cmds.append(SyncCommand(
            operation="MODIFY", object_type="COLUMN",
            object_name=f"{table_name}.{col}",
            sql=f"ALTER TABLE {table_name} ALTER COLUMN {col} TYPE {src.type_str};",
            previous=f"type: {tgt.type_str} → {src.type_str}",
        ))

    if src.not_null != tgt.not_null:
        if src.not_null:
            cmds.append(SyncCommand(
                operation="MODIFY", object_type="COLUMN",
                object_name=f"{table_name}.{col} (NOT NULL)",
                sql=f"ALTER TABLE {table_name} ALTER COLUMN {col} SET NOT NULL;",
                previous=f"NOT NULL: nullable → NOT NULL",
            ))
        else:
            cmds.append(SyncCommand(
                operation="MODIFY", object_type="COLUMN",
                object_name=f"{table_name}.{col} (NOT NULL)",
                sql=f"ALTER TABLE {table_name} ALTER COLUMN {col} DROP NOT NULL;",
                previous=f"NOT NULL: NOT NULL → nullable",
            ))

    if src.default != tgt.default:
        if src.default is not None:
            cmds.append(SyncCommand(
                operation="MODIFY", object_type="COLUMN",
                object_name=f"{table_name}.{col} (DEFAULT)",
                sql=f"ALTER TABLE {table_name} ALTER COLUMN {col} SET DEFAULT {src.default};",
                previous=f"default: {tgt.default} → {src.default}",
            ))
        else:
            cmds.append(SyncCommand(
                operation="MODIFY", object_type="COLUMN",
                object_name=f"{table_name}.{col} (DEFAULT)",
                sql=f"ALTER TABLE {table_name} ALTER COLUMN {col} DROP DEFAULT;",
                previous=f"default: {tgt.default} → (none)",
            ))

    return cmds


def _column_def_sql(col: ColumnMeta) -> str:
    parts = [col.name, col.type_str]
    if col.not_null:
        parts.append("NOT NULL")
    if col.default is not None:
        parts.append(f"DEFAULT {col.default}")
    return " ".join(parts)


def _constraint_key(con: ConstraintMeta) -> tuple:
    return (con.contype, frozenset(con.columns))


def _compare_constraints(
    table_name: str,
    src_cons: list[ConstraintMeta],
    tgt_cons: list[ConstraintMeta],
) -> list[SyncCommand]:
    cmds = []

    src_map = {_constraint_key(c): c for c in src_cons}
    tgt_map = {_constraint_key(c): c for c in tgt_cons}

    for key in sorted(set(src_map) - set(tgt_map), key=lambda k: (k[0], sorted(k[1]))):
        con = src_map[key]
        sql = _add_constraint_sql(table_name, con)
        obj_type = "FK" if con.contype == "FK" else "CONSTRAINT"
        cmds.append(SyncCommand(
            operation="ADD", object_type=obj_type,
            object_name=f"{table_name} ({con.contype}:{','.join(sorted(con.columns))})",
            sql=sql,
        ))

    for key in sorted(set(tgt_map) - set(src_map), key=lambda k: (k[0], sorted(k[1]))):
        con = tgt_map[key]
        obj_type = "FK" if con.contype == "FK" else "CONSTRAINT"
        if con.name:
            drop_sql = f"ALTER TABLE {table_name} DROP CONSTRAINT {con.name};"
        else:
            drop_sql = f"-- No name available for constraint on {table_name} ({con.contype})"
        cmds.append(SyncCommand(
            operation="DROP", object_type=obj_type,
            object_name=f"{table_name} ({con.contype}:{','.join(sorted(con.columns))})",
            sql=drop_sql,
            is_dangerous=True,
        ))

    for key in sorted(set(src_map) & set(tgt_map), key=lambda k: (k[0], sorted(k[1]))):
        sc = src_map[key]
        tc = tgt_map[key]
        if sc.name != tc.name and sc.name and tc.name:
            obj_type = "FK" if sc.contype == "FK" else "CONSTRAINT"
            drop_sql = f"ALTER TABLE {table_name} DROP CONSTRAINT {tc.name};"
            add_sql = _add_constraint_sql(table_name, sc)
            cmds.append(SyncCommand(
                operation="MODIFY", object_type=obj_type,
                object_name=f"{table_name}.{tc.name} → {sc.name}",
                sql=f"{drop_sql}\n{add_sql}",
                previous=f"constraint name: {tc.name} → {sc.name}",
            ))

    return cmds


def _add_constraint_sql(table_name: str, con: ConstraintMeta) -> str:
    name_part = f"CONSTRAINT {con.name} " if con.name else ""
    cols = ", ".join(con.columns)

    if con.contype == "PK":
        return f"ALTER TABLE {table_name} ADD {name_part}PRIMARY KEY ({cols});"
    elif con.contype == "UK":
        return f"ALTER TABLE {table_name} ADD {name_part}UNIQUE ({cols});"
    elif con.contype == "FK":
        ref = con.ref_table or "?"
        ref_cols = ", ".join(con.ref_columns) if con.ref_columns else cols
        return f"ALTER TABLE {table_name} ADD {name_part}FOREIGN KEY ({cols}) REFERENCES {ref} ({ref_cols});"
    elif con.contype == "CHECK":
        expr = con.check_expr or "TRUE"
        return f"ALTER TABLE {table_name} ADD {name_part}CHECK ({expr});"
    return f"-- Unknown constraint type {con.contype}"


# ─── Indexes ─────────────────────────────────────────────────────────────────

def _compare_indexes(src: SchemaSnapshot, tgt: SchemaSnapshot) -> list[SyncCommand]:
    cmds = []
    src_names = set(src.indexes)
    tgt_names = set(tgt.indexes)

    for name in sorted(src_names - tgt_names):
        idx = src.indexes[name]
        cmds.append(SyncCommand(
            operation="ADD", object_type="INDEX", object_name=name,
            sql=idx.raw_sql.rstrip(";") + ";",
        ))

    for name in sorted(tgt_names - src_names):
        cmds.append(SyncCommand(
            operation="DROP", object_type="INDEX", object_name=name,
            sql=f"DROP INDEX IF EXISTS {name};",
            is_dangerous=True,
        ))

    for name in sorted(src_names & tgt_names):
        si = src.indexes[name]
        ti = tgt.indexes[name]
        # Compare by normalized raw SQL (ignore trailing semicolon differences)
        s_sql = si.raw_sql.rstrip(";").strip()
        t_sql = ti.raw_sql.rstrip(";").strip()
        if s_sql != t_sql:
            drop_sql = f"DROP INDEX IF EXISTS {name};"
            create_sql = si.raw_sql.rstrip(";") + ";"
            cmds.append(SyncCommand(
                operation="MODIFY", object_type="INDEX", object_name=name,
                sql=f"{drop_sql}\n{create_sql}",
                previous=f"definition changed:\n  was: {t_sql}\n  now: {s_sql}",
            ))

    return cmds


# ─── Functions ───────────────────────────────────────────────────────────────

def _compare_functions(src: SchemaSnapshot, tgt: SchemaSnapshot) -> list[SyncCommand]:
    cmds = []
    src_names = set(src.functions)
    tgt_names = set(tgt.functions)

    for name in sorted(src_names - tgt_names):
        fn = src.functions[name]
        cmds.append(SyncCommand(
            operation="ADD", object_type="FUNCTION", object_name=name,
            sql=fn.normalized_body.rstrip(";") + ";",
        ))

    for name in sorted(tgt_names - src_names):
        cmds.append(SyncCommand(
            operation="DROP", object_type="FUNCTION", object_name=name,
            sql=f"DROP FUNCTION IF EXISTS {name};",
            is_dangerous=True,
        ))

    for name in sorted(src_names & tgt_names):
        sf = src.functions[name]
        tf = tgt.functions[name]
        if sf.normalized_body != tf.normalized_body:
            cmds.append(SyncCommand(
                operation="MODIFY", object_type="FUNCTION", object_name=name,
                sql=sf.normalized_body.rstrip(";") + ";",
                previous=f"(see target snapshot)",
                new=f"(see source snapshot)",
            ))

    return cmds
