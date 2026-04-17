#!/bin/bash
# 🗑️ NETCUP COMPLETE RESET - Alles löschen und neu anfangen

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${RED}🗑️  Event VT - Complete Reset auf Netcup${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""

# 1. Dateien löschen
echo -e "${YELLOW}1️⃣  Lösche Dateien...${NC}"
rm -rf /root/public_html/event-vt/*
rm -rf /root/repositories/event-vt.git
echo -e "${GREEN}   ✓ Dateien gelöscht${NC}"
echo ""

# 2. PM2 Prozesse stoppen
echo -e "${YELLOW}2️⃣  Stoppe PM2 Prozesse...${NC}"
pm2 stop event-vt-backend 2>/dev/null || true
pm2 stop event-vt-website 2>/dev/null || true
pm2 delete event-vt-backend 2>/dev/null || true
pm2 delete event-vt-website 2>/dev/null || true
echo -e "${GREEN}   ✓ PM2 Prozesse gelöscht${NC}"
echo ""

# 3. Verzeichnisse neu erstellen
echo -e "${YELLOW}3️⃣  Erstelle Verzeichnisse neu...${NC}"
mkdir -p /root/repositories/event-vt.git
mkdir -p /root/public_html/event-vt
echo -e "${GREEN}   ✓ Verzeichnisse erstellt${NC}"
echo ""

# 4. Bare Repository initialisieren
echo -e "${YELLOW}4️⃣  Initialisiere Git Repository...${NC}"
cd /root/repositories/event-vt.git
git init --bare
echo -e "${GREEN}   ✓ Repository initialisiert${NC}"
echo ""

# 5. Post-Receive Hook erstellen
echo -e "${YELLOW}5️⃣  Erstelle Post-Receive Hook...${NC}"
cat > /root/repositories/event-vt.git/hooks/post-receive << 'HOOK'
#!/bin/bash
DEPLOY_DIR="$HOME/public_html/event-vt"
REPO_DIR="$HOME/repositories/event-vt.git"
git --work-tree=$DEPLOY_DIR --git-dir=$REPO_DIR checkout -f main
cd $DEPLOY_DIR/backend && npm install --production
pm2 restart event-vt-backend || pm2 start src/server.js --name event-vt-backend
HOOK

chmod +x /root/repositories/event-vt.git/hooks/post-receive
echo -e "${GREEN}   ✓ Hook erstellt${NC}"
echo ""

# 6. Bestätigung
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ COMPLETE RESET ABGESCHLOSSEN!${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Status:${NC}"
echo "   Git Repository: $(ls -lad /root/repositories/event-vt.git)"
echo ""
echo -e "${YELLOW}Nächste Schritte:${NC}"
echo -e "   ${BLUE}1. Lokal: git push netcup main${NC}"
echo -e "   ${BLUE}2. Dann hier: git clone /root/repositories/event-vt.git . --branch main${NC}"
echo ""
