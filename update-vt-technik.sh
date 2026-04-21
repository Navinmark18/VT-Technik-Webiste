#!/bin/bash
# 🔄 VT-Technik-Webiste - Lokales Update + GitHub + Netcup Deploy

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${BLUE}🚀 VT-Technik-Webiste Update${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""

# Check ob wir im richtigen Verzeichnis sind
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Fehler: Nicht im Git-Repository!${NC}"
    echo "Bitte führe das im /workspaces/codespaces-blank aus"
    exit 1
fi

# 1. Status anzeigen
echo -e "${YELLOW}1️⃣  Git Status:${NC}"
git status --short
echo ""

# 2. Adden
echo -e "${YELLOW}2️⃣  Alle Dateien adden...${NC}"
git add .
echo -e "${GREEN}   ✓ Dateien staged${NC}"
echo ""

# 3. Commiten
read -p "Commit-Nachricht eingeben: " commit_msg
if [ -z "$commit_msg" ]; then
    commit_msg="Update: VT-Technik-Webiste"
fi

echo -e "${YELLOW}3️⃣  Committe änderungen...${NC}"
git commit -m "$commit_msg" || echo -e "${YELLOW}   (Keine Änderungen zu committen)${NC}"
echo ""

# 4. Zu GitHub pushen
echo -e "${YELLOW}4️⃣  Push zu GitHub (origin/main)...${NC}"
git push origin main
echo -e "${GREEN}   ✓ GitHub updated${NC}"
echo ""

# 5. Zu Netcup pushen (falls Remote existiert)
if git remote | grep -q netcup; then
    echo -e "${YELLOW}5️⃣  Push zu Netcup...${NC}"
    git push netcup main
    echo -e "${GREEN}   ✓ Netcup Auto-Deploy gestartet${NC}"
else
    echo -e "${YELLOW}5️⃣  Netcup Remote nicht gefunden - skipped${NC}"
    echo "   (Um Netcup hinzuzufügen: git remote add netcup ssh://root@159.195.144.255/root/repositories/vt-technik-webiste.git)"
fi

echo ""
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Update fertig!${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
