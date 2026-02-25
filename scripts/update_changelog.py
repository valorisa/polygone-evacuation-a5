#!/usr/bin/env python3
"""Met à jour CHANGELOG.md avec format Markdown correct."""
import json
from datetime import datetime
from pathlib import Path


def get_version() -> str:
    """
    Récupère la version depuis index.json.
    
    Returns:
        Version du projet ou '1.0.1' par défaut
    """
    try:
        with open("index.json", encoding="utf-8") as f:
            data = json.load(f)
            return data["version"]
    except (FileNotFoundError, json.JSONDecodeError, KeyError) as e:
        print(f"⚠️ Impossible de lire index.json: {e}")
        return "1.0.1"


def update_changelog() -> None:
    """Génère CHANGELOG.md au format Keep a Changelog."""
    version = get_version()
    date_str = datetime.now().strftime("%Y-%m-%d")
    
    changelog = f"""# Changelog

Tous les changements notables de ce projet seront documentés dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

## [{version}] - {date_str}

### Ajouté
- Support Windows PowerShell 5.1 (tasks.ps1, auto-release.ps1)
- Projet GitHub production-ready (18 fichiers)
- CSS A5 sécurité avec header/footer automatique
- Génération PDF multiplateforme
- Makefile + PowerShell + commandes make/tasks

### Modifié
- README avec documentation Windows et Linux/macOS

## [1.0.0] - 2026-02-23

### Ajouté
- Plan évacuation A5 bilingue FR/EN Parking Polygone
- Schéma ASCII 5 sorties + procédures urgence
- Tableaux contacts + règles sécurité colorées
"""
    
    changelog_path = Path("CHANGELOG.md")
    changelog_path.write_text(changelog, encoding="utf-8")
    
    print(f"✅ CHANGELOG.md v{version} mis à jour ({date_str})")


if __name__ == "__main__":
    update_changelog()
