# 🧰 DEV_SETUP – Encodage UTF‑8 & GitIngest (Windows)

Ce guide est destiné aux mainteneurs et utilisateurs avancés **PowerShell 5.1** qui analysent le dépôt via **GitIngest** ou des outils LLM.

---

## 🔤 Problème rencontré (PowerShell 5.1)

- Encodage par défaut **CP1252** → mojibake (`documentÃ©` au lieu de `documenté`)
- Les caractères Unicode box‑drawing (`│ └ ─`) cassent l’arborescence ASCII
- Certains dumps deviennent illisibles pour les LLM

---

## ✅ Solution recommandée

Le projet fournit un mini‑script prêt à l’emploi :
