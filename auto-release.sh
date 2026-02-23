#!/bin/bash
set -e

echo "🚀 AUTO-RELEASE GitHub"
make test-all
make pdf
git add .
git commit -m "Release v$(python3 -c 'import json;print(json.load(open(\"index.json\"))[\"version\"])')"
git push
gh release create v$(python3 -c 'import json;print(json.load(open(\"index.json\"))[\"version\"])') \
  --title "Plan Évacuation A5 v$(python3 -c 'import json;print(json.load(open(\"index.json\"))[\"version\"])')" \
  --notes "PDF A5 sécurité Parking Polygone" \
  plan-evacuation.pdf
echo "🎉 Release publiée !"
