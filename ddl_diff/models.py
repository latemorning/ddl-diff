from __future__ import annotations
from dataclasses import dataclass, field


@dataclass
class ColumnMeta:
    name: str
    type_str: str
    not_null: bool = False
    default: str | None = None
    is_pk: bool = False
    is_fk: bool = False
    is_uk: bool = False


@dataclass
class ConstraintMeta:
    name: str | None
    contype: str  # "PK", "FK", "UK", "CHECK"
    columns: list[str] = field(default_factory=list)
    ref_table: str | None = None
    ref_columns: list[str] = field(default_factory=list)
    check_expr: str | None = None


@dataclass
class IndexMeta:
    name: str
    table_name: str
    columns: list[str]
    unique: bool
    raw_sql: str


@dataclass
class TableMeta:
    name: str
    columns: list[ColumnMeta] = field(default_factory=list)
    constraints: list[ConstraintMeta] = field(default_factory=list)
    raw_sql: str = ""


@dataclass
class FunctionMeta:
    name: str
    normalized_body: str


@dataclass
class SequenceMeta:
    name: str
    normalized_body: str
    options: dict = field(default_factory=dict)
    # options keys: "start", "increment", "minvalue", "maxvalue", "cache", "cycle"
    # value=None means the option was explicitly set to NO (e.g. NO MAXVALUE)


@dataclass
class SchemaSnapshot:
    tables: dict[str, TableMeta] = field(default_factory=dict)
    indexes: dict[str, IndexMeta] = field(default_factory=dict)
    functions: dict[str, FunctionMeta] = field(default_factory=dict)
    sequences: dict[str, SequenceMeta] = field(default_factory=dict)
    failed_statements: list[tuple[str, str]] = field(default_factory=list)


@dataclass
class SyncCommand:
    operation: str      # "ADD", "DROP", "MODIFY"
    object_type: str    # "TABLE", "COLUMN", "CONSTRAINT", "INDEX", "FUNCTION", "SEQUENCE", "FK"
    object_name: str
    sql: str
    previous: str | None = None
    new: str | None = None
    is_dangerous: bool = False
