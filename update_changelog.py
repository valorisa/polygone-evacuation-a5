#!/usr/bin/env python3
"""Met à jour CHANGELOG.md."""

VERSION = "1.0.1"
DATE = "2026-02-23"

changelog = f"""# Changelog

## [{VERSION}] - {DATE}
Création projet GitHub complet

CSS A5 header/footer automatique

Manifeste validation 100%

"""
with open("CHANGELOG.md", "w") as f:
    f.write(changelog)
print("✅ CHANGELOG.md mis à jour")
