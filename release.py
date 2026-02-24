#!/usr/bin/env python3
"""Gestionnaire de versions sémantiques."""
import json
from datetime import date
from pathlib import Path


def bump_version(version: str, level: str = "patch") -> str:
    """
    Incrémente la version selon le niveau spécifié.
    
    Args:
        version: Version actuelle (format major.minor.patch)
        level: Niveau d'incrémentation ('major', 'minor', 'patch')
    
    Returns:
        Nouvelle version incrémentée
    """
    major, minor, patch = map(int, version.split("."))
    
    if level == "major":
        major += 1
        minor = 0
        patch = 0
    elif level == "minor":
        minor += 1
        patch = 0
    else:  # patch
        patch += 1
    
    return f"{major}.{minor}.{patch}"


def update_version(level: str = "patch") -> None:
    """
    Met à jour la version dans index.json.
    
    Args:
        level: Niveau d'incrémentation ('major', 'minor', 'patch')
    """
    index_path = Path("index.json")
    
    if not index_path.exists():
        print("❌ Fichier index.json introuvable")
        return
    
    data = json.loads(index_path.read_text(encoding="utf-8"))
    old_version = data["version"]
    new_version = bump_version(old_version, level)
    
    data["version"] = new_version
    data["date"] = date.today().isoformat()  # Date dynamique
    
    index_path.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")
    
    print(f"✅ Version: {old_version} → {new_version}")
    print(f"📅 Date: {data['date']}")


if __name__ == "__main__":
    import sys
    level = sys.argv[1] if len(sys.argv) > 1 else "patch"
    
    if level not in ("major", "minor", "patch"):
        print(f"⚠️ Niveau invalide: {level}")
        print("   Utilisez: major, minor, ou patch")
        sys.exit(1)
    
    update_version(level)
