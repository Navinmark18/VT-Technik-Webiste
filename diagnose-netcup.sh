#!/bin/bash
# Diagnoseskript - auf Netcup ausführen

echo "🔍 Event VT - Netcup Diagnosis"
echo "=============================="
echo ""

echo "1️⃣  Repository Status:"
ls -lah /root/repositories/event-vt.git/
echo ""
echo "2️⃣  Repository Objects:"
ls -lah /root/repositories/event-vt.git/objects/ | head -20
echo ""
echo "3️⃣  Git Log im Repository:"
cd /root/repositories/event-vt.git
git log --oneline | head -5
echo ""
echo "4️⃣  Branches:"
git branch -a
echo ""
echo "5️⃣  Deploy Verzeichnis:"
ls -lah /root/public_html/event-vt/
echo ""
echo "=============================="
echo "Gib die Ausgabe oben an!"
