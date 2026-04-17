#!/bin/bash
# Event VT - Automatisches Finish Setup auf Netcup
# Führe diesen Script NACH dem git push netcup main auf dem Netcup-Server aus

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}🚀 Event VT - Netcup Finish Setup${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""

DEPLOY_DIR="$HOME/public_html/event-vt"
REPO_DIR="$HOME/repositories/event-vt.git"

# 1. Code checken
echo -e "${BLUE}1️⃣  Checkout Code...${NC}"
cd "$DEPLOY_DIR"
git --work-tree="$DEPLOY_DIR" --git-dir="$REPO_DIR" checkout -f main
echo -e "${GREEN}✓ Code checked out${NC}"
echo ""

# 2. Backend Setup
echo -e "${BLUE}2️⃣  Setup Backend...${NC}"
if [ ! -d "$DEPLOY_DIR/backend" ]; then
    echo -e "${RED}❌ Backend-Verzeichnis nicht gefunden!${NC}"
    echo "Verzeichnis: $DEPLOY_DIR/backend"
    ls -la "$DEPLOY_DIR/"
    exit 1
fi

cd "$DEPLOY_DIR/backend"
echo "   Installing dependencies..."
npm install --production --silent
echo -e "${GREEN}✓ Dependencies installed${NC}"
echo ""

# 3. PM2 Setup
echo -e "${BLUE}3️⃣  Start Backend mit PM2...${NC}"

# Prüfe ob process existiert
if pm2 list | grep -q "event-vt-backend"; then
    echo "   Restarting existing process..."
    pm2 restart event-vt-backend
else
    echo "   Starting new process..."
    pm2 start src/server.js --name event-vt-backend --env production
fi

echo -e "${GREEN}✓ Backend started${NC}"
echo ""

# 4. Bestätigung
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Setup abgeschlossen!${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}📊 Status:${NC}"
pm2 list

echo ""
echo -e "${YELLOW}📍 Deployment:${NC}"
echo "   Deploy Dir: $DEPLOY_DIR"
echo "   Repository: $REPO_DIR"
echo ""

echo -e "${YELLOW}🔍 Logs:${NC}"
echo -e "   ${BLUE}pm2 logs event-vt-backend${NC}"
echo ""

echo -e "${YELLOW}🧪 Test Backend:${NC}"
echo -e "   ${BLUE}curl http://localhost:4000/api/settings${NC}"
echo ""

echo -e "${GREEN}🎉 Ready!${NC}"
echo ""
