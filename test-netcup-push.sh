#!/bin/bash
# Event VT - SSH & Push Test

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

NETCUP_IP="159.195.144.255"
NETCUP_USER="root"

echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}🧪 Event VT - Netcup Push Test${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""

# Test 1: SSH-Verbindung
echo -e "${BLUE}Test 1: SSH-Verbindung...${NC}"
if ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=accept-new -i ~/.ssh/id_ed25519 "${NETCUP_USER}@${NETCUP_IP}" "echo OK" 2>/dev/null; then
    echo -e "${GREEN}✓ SSH-Verbindung erfolgreich${NC}"
    SSH_OK=1
else
    echo -e "${YELLOW}⚠️  SSH-Key nicht akzeptiert. Passwort erforderlich.${NC}"
    SSH_OK=0
fi

echo ""

# Test 2: Repository existiert
echo -e "${BLUE}Test 2: Repository auf Netcup...${NC}"
if ssh -o ConnectTimeout=5 "${NETCUP_USER}@${NETCUP_IP}" "test -d ~/repositories/event-vt.git" 2>/dev/null; then
    echo -e "${GREEN}✓ Repository existiert${NC}"
    REPO_OK=1
else
    echo -e "${RED}❌ Repository nicht gefunden!${NC}"
    REPO_OK=0
fi

echo ""

# Test 3: Hook existiert
echo -e "${BLUE}Test 3: Post-Receive Hook...${NC}"
if ssh -o ConnectTimeout=5 "${NETCUP_USER}@${NETCUP_IP}" "test -x ~/repositories/event-vt.git/hooks/post-receive" 2>/dev/null; then
    echo -e "${GREEN}✓ Hook existiert und ist ausführbar${NC}"
    HOOK_OK=1
else
    echo -e "${RED}❌ Hook nicht gefunden oder nicht ausführbar!${NC}"
    HOOK_OK=0
fi

echo ""
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"

# Zusammenfassung
READY=1
if [ $SSH_OK -eq 0 ] || [ $REPO_OK -eq 0 ] || [ $HOOK_OK -eq 0 ]; then
    READY=0
fi

if [ $READY -eq 1 ]; then
    echo -e "${GREEN}✅ Alles bereit zum Push!${NC}"
    echo ""
    read -p "Jetzt 'git push netcup main' ausführen? (j/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Jj]$ ]]; then
        cd /workspaces/codespaces-blank
        git push netcup main
        echo ""
        echo -e "${GREEN}✅ Push abgeschlossen!${NC}"
        echo ""
        echo "Backend-Status prüfen:"
        echo -e "${BLUE}  ssh ${NETCUP_USER}@${NETCUP_IP} pm2 list${NC}"
    fi
else
    echo -e "${RED}❌ Setup nicht vollständig!${NC}"
    echo ""
    echo "Fehlende Konfigurationen:"
    [ $SSH_OK -eq 0 ] && echo "  • SSH-Key nicht konfiguriert"
    [ $REPO_OK -eq 0 ] && echo "  • Repository nicht auf Server"
    [ $HOOK_OK -eq 0 ] && echo "  • Hook nicht ausführbar"
fi

echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
