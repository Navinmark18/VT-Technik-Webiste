#!/bin/bash
# 🚀 VT-Technik-Webiste - Vite Dev-Server Starter

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${BLUE}🚀 Starte Vite Dev-Server${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""

# Check ob wir im richtigen Verzeichnis sind
if [ ! -f "package.json" ]; then
    echo -e "${YELLOW}Wechsle zum Website VT-T Verzeichnis...${NC}"
    cd "Website VT-T" || exit 1
fi

# Check ob node_modules existieren
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}📦 Installiere Dependencies...${NC}"
    npm install
    echo ""
fi

# Starte Vite
echo -e "${YELLOW}🔥 Starte Dev-Server...${NC}"
echo ""
npm run dev
