#!/bin/bash
# 🔄 Event VT - Quick Update auf Netcup

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🔄 Event VT Update${NC}"
echo "════════════════════════════════════════"
echo ""

# 1. Update Code
echo -e "${YELLOW}1️⃣  Hole neueste Änderungen...${NC}"
cd /root/public_html/event-vt
git --work-tree=. --git-dir=/root/repositories/event-vt.git checkout -f main
echo -e "${GREEN}   ✓ Code aktualisiert${NC}"
echo ""

# 2. Backend Update
echo -e "${YELLOW}2️⃣  Update Backend...${NC}"
cd backend
npm install --production --silent
echo -e "${GREEN}   ✓ Dependencies installiert${NC}"
echo ""

# 3. Restart
echo -e "${YELLOW}3️⃣  Restart Backend...${NC}"
pm2 restart event-vt-backend
echo -e "${GREEN}   ✓ Backend restartet${NC}"
echo ""

# 4. Status
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${YELLOW}Status:${NC}"
pm2 list

echo ""
echo -e "${GREEN}✅ Update fertig!${NC}"
