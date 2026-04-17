# ✅ EVENT VT - NETCUP DEPLOYMENT - FINISH

## 🎉 Gute Nachrichten!

Dein Code-Push war **ERFOLGREICH**! 

```
* [new branch]      main -> main
```

---

## 🔧 Jetzt: Finish auf Netcup ausführen

**SSH zu deinem Netcup-Server:**
```bash
ssh root@159.195.144.255
```

**Dann diesen Befehl eingeben (kopieren & einfügen):**
```bash
cd /root && bash -c '
set -e
DEPLOY_DIR="$HOME/public_html/event-vt"
REPO_DIR="$HOME/repositories/event-vt.git"

echo "📥 Checking out code..."
cd "$DEPLOY_DIR"
git --work-tree="$DEPLOY_DIR" --git-dir="$REPO_DIR" checkout -f main

echo "📦 Installing dependencies..."
cd "$DEPLOY_DIR/backend"
npm install --production --silent

echo "🚀 Starting backend..."
if pm2 list | grep -q "event-vt-backend"; then
    pm2 restart event-vt-backend
else
    pm2 start src/server.js --name event-vt-backend
fi

echo "✅ Setup complete!"
pm2 list
'
```

---

## 🧪 Prüfen ob es läuft

**Auf Netcup-Server im Terminal:**

```bash
# Status
pm2 list

# Sollte zeigen:
# id │ name              │ mode │ ↺ │ status  │ ↻ │ cpu │ memory
# 0  │ event-vt-backend  │ fork │ 0 │ online  │ 0 │ ...

# Live-Logs
pm2 logs event-vt-backend

# Test Backend
curl http://localhost:4000/api/settings
```

---

## 📊 Fehlerbehandlung

**Wenn "npm: command not found":**
```bash
apt-get update && apt-get install -y nodejs npm
npm install -g pm2
```

**Wenn Backend-Dateistruktur falsch:**
```bash
ls -la ~/public_html/event-vt/
# sollte zeigen: backend, Website VT, etc.
```

**Wenn Backend-Port 4000 in Benutzung:**
```bash
lsof -i :4000
kill -9 PID
pm2 start src/server.js --name event-vt-backend
```

---

## 🎯 Danach - Standard Workflow

Jedes Mal wenn du Code änderst:

```bash
# Lokal (Codespace)
git add .
git commit -m "Beschreibung"
git push netcup main

# Das's! Backend deployed sich automatisch
```

Prüfe Logs mit:
```bash
ssh root@159.195.144.255 "pm2 logs event-vt-backend"
```

---

## 📋 ABSCHLIESSENDE CHECKLIST

- [ ] SSH mit Passwort zu Netcup verbunden
- [ ] finish-setup.sh ausgeführt ODER Befehle manuell eingegeben
- [ ] `pm2 list` zeigt "event-vt-backend" als "online"
- [ ] `curl http://localhost:4000/api/settings` liefert JSON Response
- [ ] Logs zeigen keine Errors: `pm2 logs event-vt-backend`

---

## 🚀 DU BIST FERTIG!

Dein Event VT Backend läuft jetzt auf:
📍 **159.195.144.255:4000**

Viel Erfolg! 🎉
