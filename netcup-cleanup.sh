#!/bin/bash
# 🧹 Netcup VT-Technik-Webiste Cleanup - Nur Website VT-T behalten

cd ~/VT-Technik-Webiste

echo "📁 Aktuelle Struktur:"
ls -la

echo ""
echo "🧹 Lösche alles außer Website VT-T..."

# Lösche alte Website VT
rm -rf "Website VT"

# Lösche Projekt_Spiel
rm -rf "Projekt_Spiel"

# Lösche alle .md Dateien
rm -f *.md

# Lösche alle .sh Skripte
rm -f *.sh

# Lösche config Dateien
rm -f *.json

echo ""
echo "✅ Cleanup fertig! Was bleibt:"
ls -la

echo ""
echo "📝 Verzeichnisstruktur:"
tree -L 2 "Website VT-T" 2>/dev/null || find "Website VT-T" -type d | head -20
