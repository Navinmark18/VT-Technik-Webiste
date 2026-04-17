#!/bin/bash
# 🚀 Starte BEIDES auf einmal - Backend + Frontend auf Netcup

set -e

echo "🚀 Event VT - Full Startup auf Netcup"
echo "===================================="
echo ""

# 1. Backend
echo "1️⃣  Starting Backend..."
cd /root/public_html/event-vt/backend
npm install --production --silent
pm2 start src/server.js --name event-vt-backend --env production
echo "✓ Backend started"
echo ""

# 2. Frontend
echo "2️⃣  Starting Frontend..."
npm install -g http-server --silent 2>/dev/null || true
cd /root/public_html/event-vt/Website\ VT
npm install --production --silent 2>/dev/null || true
pm2 start "http-server -p 8080 -c-1" --name event-vt-website
echo "✓ Frontend started on port 8080"
echo ""

# 3. Status
sleep 2
echo "3️⃣  Status:"
pm2 list
echo ""

# 4. URLs
echo "4️⃣  URLs:"
echo "   Frontend:  http://159.195.144.255:8080"
echo "   Backend:   http://159.195.144.255:4000"
echo ""

echo "✅ Alles läuft!"
echo "===================================="
