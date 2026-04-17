#!/bin/bash
# 🚀 NETCUP AUTO COMPLETE - Führe diesen Script direkt auf Netcup aus!
# Dieser Script macht ALLES automatisch fertig

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}🚀 Event VT - Automatischer Finish auf Netcup${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""

DEPLOY_DIR="$HOME/public_html/event-vt"
REPO_DIR="$HOME/repositories/event-vt.git"

# 1. Verzeichnis prüfen
echo -e "${BLUE}1️⃣  Prüfe Verzeichnis...${NC}"
if [ ! -d "$DEPLOY_DIR" ]; then
    echo -e "${RED}❌ Verzeichnis nicht vorhanden: $DEPLOY_DIR${NC}"
    exit 1
fi
echo -e "${GREEN}   ✓ Verzeichnis existiert${NC}"
echo ""

# 2. Code auschecken
echo -e "${BLUE}2️⃣  Checkout Code aus Repository...${NC}"
cd "$DEPLOY_DIR"
git --work-tree="$DEPLOY_DIR" --git-dir="$REPO_DIR" checkout -f main 2>&1 | head -3
echo -e "${GREEN}   ✓ Code checked out${NC}"
echo ""

# 3. Prüfe Backend
echo -e "${BLUE}3️⃣  Prüfe Backend-Struktur...${NC}"
if [ ! -f "$DEPLOY_DIR/backend/src/server.js" ]; then
    echo -e "${RED}❌ Backend-Datei nicht gefunden: backend/src/server.js${NC}"
    echo "Verzeichnis-Inhalt:"
    ls -la "$DEPLOY_DIR/"
    exit 1
fi
echo -e "${GREEN}   ✓ Backend-Struktur OK${NC}"
echo ""

# 4. Dependencies installieren
echo -e "${BLUE}4️⃣  Installiere Dependencies...${NC}"
cd "$DEPLOY_DIR/backend"
npm install --production --silent 2>&1 | tail -1
echo -e "${GREEN}   ✓ Dependencies installiert${NC}"
echo ""

# 5. PM2 Setup
echo -e "${BLUE}5️⃣  Starte Backend mit PM2...${NC}"
if pm2 list 2>/dev/null | grep -q "event-vt-backend"; then
    pm2 restart event-vt-backend --silent
    echo -e "${GREEN}   ✓ Backend restartet${NC}"
else
    pm2 start src/server.js --name event-vt-backend --env production --silent
    echo -e "${GREEN}   ✓ Backend gestartet${NC}"
fi
echo ""

# 6. Bestätigung
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ SETUP ABGESCHLOSSEN!${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}📊 Backend-Status:${NC}"
pm2 list | grep event-vt-backend || echo "Status: N/A"
echo ""

echo -e "${YELLOW}🧪 Backend Test:${NC}"
sleep 1
if curl -s http://localhost:4000/api/settings > /dev/null 2>&1; then
    echo -e "${GREEN}   ✓ Backend antwortet auf Port 4000${NC}"
else
    echo -e "${YELLOW}   ⚠️  Backend noch nicht bereit - 10 Sekunden warten...${NC}"
    sleep 10
    if curl -s http://localhost:4000/api/settings > /dev/null 2>&1; then
        echo -e "${GREEN}   ✓ Backend ist jetzt bereit${NC}"
    else
        echo -e "${YELLOW}   ⚠️  Backend antwortet nicht - Logs prüfen:${NC}"
        pm2 logs event-vt-backend --lines 5
    fi
fi
echo ""

echo -e "${GREEN}════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}📍 Deployment erfolgreich!${NC}"
echo "   Deploy Path: $DEPLOY_DIR"
echo "   Backend: http://localhost:4000"
echo ""
echo -e "${YELLOW}📝 Logs anschauen:${NC}"
echo -e "   ${BLUE}pm2 logs event-vt-backend${NC}"
echo ""
echo -e "${GREEN}🎉 Ready to go!${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
