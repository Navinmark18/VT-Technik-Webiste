# 🗑️ NETCUP COMPLETE RESET - Alles neu anfangen

## Schritt 1: Auf Netcup-Server alles löschen

**Kopiere & paste auf Netcup:**

```bash
# Alles löschen
rm -rf /root/public_html/event-vt/*
rm -rf /root/repositories/event-vt.git

# PM2 Prozesse stoppen
pm2 stop event-vt-backend 2>/dev/null || true
pm2 stop event-vt-website 2>/dev/null || true
pm2 delete event-vt-backend 2>/dev/null || true
pm2 delete event-vt-website 2>/dev/null || true

# Verzeichnisse neu erstellen
mkdir -p /root/repositories/event-vt.git
mkdir -p /root/public_html/event-vt

# Git initialisieren
cd /root/repositories/event-vt.git
git init --bare

# Post-Receive Hook erstellen
cat > hooks/post-receive << 'EOF'
#!/bin/bash
DEPLOY_DIR="$HOME/public_html/event-vt"
REPO_DIR="$HOME/repositories/event-vt.git"
git --work-tree=$DEPLOY_DIR --git-dir=$REPO_DIR checkout -f main
cd $DEPLOY_DIR/backend && npm install --production
pm2 restart event-vt-backend || pm2 start src/server.js --name event-vt-backend
EOF

chmod +x hooks/post-receive

echo "✅ Complete Reset fertig!"
```

---

## Schritt 2: Lokal neu pushen

**Auf deinem PC/Codespace:**

```bash
cd /workspaces/codespaces-blank
git push netcup main --force
```

---

## Schritt 3: Code auschecken auf Netcup

**Zurück auf Netcup-Server:**

```bash
cd /root/public_html/event-vt
git clone /root/repositories/event-vt.git . --branch main
```

---

## Schritt 4: Backend starten

**Auf Netcup:**

```bash
cd /root/public_html/event-vt/backend
npm install --production
pm2 start src/server.js --name event-vt-backend
```

---

## Schritt 5: Frontend starten

**Auf Netcup:**

```bash
npm install -g http-server
cd /root/public_html/event-vt/Website\ VT
pm2 start "http-server -p 8080 -c-1" --name event-vt-website
```

---

## ✅ Fertig!

```bash
pm2 list

# Teste
curl http://localhost:4000/api/settings
curl http://localhost:8080/index.html
```

URLs:
- Frontend: http://159.195.144.255:8080
- Backend: http://159.195.144.255:4000

---

**Das ist der komplette Neustart von Grund auf!** 🚀
