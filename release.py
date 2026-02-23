#!/usr/bin/env python3
"""Gestionnaire de versions sémantiques."""

import json
from pathlib import Path

def bump_version(version, level="patch"):
    """Incrémente version (major.minor.patch)."""
    major, minor, patch = map(int, version.split("."))
    if level == "major":
        major += 1
    elif level == "minor":
        minor += 1
    else:
        patch += 1
    return f"{major}.{minor}.{patch}"

def update_version(level="patch"):
    """Met à jour version dans index.json."""
    index = Path("index.json")
    data = json.loads(index.read_text())
    old_version = data["version"]
    data["version"] = bump_version(old_version, level)
    data["date"] = "2026-02-23"
    index.write_text(json.dumps(data, indent=2))
    print(f"📦 Version: {old_version} → {data['version']}")

if __name__ == "__main__":
    import sys
    level = sys.argv[1] if len(sys.argv) > 1 else "patch"
    update_version(level)
