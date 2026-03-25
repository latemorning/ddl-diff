import sys
from ddl_diff.parser import read_file, parse_ddl
from ddl_diff.mapper import build_snapshot
from ddl_diff.comparator import compare
from ddl_diff.generator import generate_all


def main():
    if len(sys.argv) != 3:
        print("Usage: python main.py <source.sql> <target.sql>")
        sys.exit(1)

    src_path, tgt_path = sys.argv[1], sys.argv[2]
    print(f"Source: {src_path}")
    print(f"Target: {tgt_path}")

    print("Parsing source DDL...")
    src_text = read_file(src_path)
    src_accepted, src_failed = parse_ddl(src_text)
    print(f"  Accepted: {len(src_accepted)}, Failed: {len(src_failed)}")

    print("Parsing target DDL...")
    tgt_text = read_file(tgt_path)
    tgt_accepted, tgt_failed = parse_ddl(tgt_text)
    print(f"  Accepted: {len(tgt_accepted)}, Failed: {len(tgt_failed)}")

    print("Building source snapshot...")
    source_snap = build_snapshot(src_accepted, src_failed)
    print(f"  Tables: {len(source_snap.tables)}, Sequences: {len(source_snap.sequences)}, "
          f"Functions: {len(source_snap.functions)}, Indexes: {len(source_snap.indexes)}")

    print("Building target snapshot...")
    target_snap = build_snapshot(tgt_accepted, tgt_failed)
    print(f"  Tables: {len(target_snap.tables)}, Sequences: {len(target_snap.sequences)}, "
          f"Functions: {len(target_snap.functions)}, Indexes: {len(target_snap.indexes)}")

    print("Comparing snapshots...")
    commands = compare(source_snap, target_snap)
    safe = sum(1 for c in commands if not c.is_dangerous)
    dangerous = sum(1 for c in commands if c.is_dangerous)
    print(f"  Commands: {len(commands)} total ({safe} safe, {dangerous} dangerous/DROP)")

    print("Generating output files...")
    generate_all(source_snap, target_snap, commands)
    print("Done. Output written to script/")


if __name__ == "__main__":
    main()
