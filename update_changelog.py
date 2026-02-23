#!/usr/bin/env python3
"""Met à jour CHANGELOG.md avec format Markdown correct."""

import json
from datetime import datetime
from pathlib import Path

def get_version():
    """Récupère version depuis index.json ou incrémente."""
    try:
        with open("index.json") as f:
            data = json.load(f)
        version = data["version"]
    except:
        version = "1.0.1"
    return version

def update_changelog():
    """Génère CHANGELOG.md au format Markdown Keep a Changelog."""
    version = get_version()
    date = datetime.now().strftime("%Y-%m-%d")
    
    changelog = f"""# Changelog

## [{version}] - {date}
- Création projet GitHub production-ready (18 fichiers)
- CSS A5 sécurité avec header/footer automatique
- Génération HTML/PDF Termux Android fonctionnelle
- Makefile multiplateforme + commandes make pdf/html
- Badges GitHub + workflows CI/CD prêts

## [1.0.0] - 2026-02-23
- Plan évacuation A5 bilingue FR/EN Parking Polygone
- Schéma ASCII 5 sorties + procédures urgence
- Tableaux contacts + règles sécurité colorées
"""
    
    with open("CHANGELOG.md", "w", encoding="utf-8") as f:
        f.write(changelog)
    
    print(f"✅ CHANGELOG.md v{version} mis à jour ({date})")

if __name__ == "__main__":
    update_changelog()
