# 🌐 NETCUP FRONTEND - STARTUP GUIDE

## Gib diese Befehle nacheinander auf Netcup ein:

### OPTION 1: Mit npm start (einfach)

```bash
# 1. Gehe zum Website-Verzeichnis
cd /root/public_html/event-vt/Website\ VT

# 2. Installiere Dependencies
npm install --production

# 3. Starte mit npm
npm start
```

### OPTION 2: Mit PM2 im Hintergrund (besser)

```bash
# 1. Installiere http-server (statischer Server)
npm install -g http-server

# 2. Starte Frontend auf Port 8080
cd /root/public_html/event-vt/Website\ VT
pm2 start "http-server -p 8080 -c-1" --name event-vt-website

# 3. Prüfe Status
pm2 list

# 4. Logs (falls Fehler)
pm2 logs event-vt-website
```

### OPTION 3: Mit Express Server (wenn package.json das unterstützt)

```bash
cd /root/public_html/event-vt/Website\ VT
npm install --production
pm2 start "npm start" --name event-vt-website

pm2 list
```

---

## ✅ Nach dem Start:

**Prüfe ob Frontend läuft:**
```bash
curl http://localhost:8080
# oder
curl http://localhost:5173  (falls Vite nutzt)
# oder
curl http://localhost:3000  (falls Express)
```

**Öffne im Browser:**
- Frontend: `http://159.195.144.255:8080` (oder welcher Port)
- Backend: `http://159.195.144.255:4000`

---

## 📋 Vollständiger Workflow

```bash
# SSH zu Netcup
ssh root@159.195.144.255

# Backend starten (falls noch nicht)
cd /root/public_html/event-vt/backend
npm install --production
pm2 start src/server.js --name event-vt-backend

# Frontend starten
npm install -g http-server
cd /root/public_html/event-vt/Website\ VT
pm2 start "http-server -p 8080 -c-1" --name event-vt-website

# Alle Prozesse prüfen
pm2 list

# Status
pm2 monit
```

---

## 🔗 Finale URLs

Nach dem Setup erreichbar unter:

- **Frontend:** http://159.195.144.255:8080
- **Backend API:** http://159.195.144.255:4000
- **Admin Panel:** http://159.195.144.255:8080/admin.html (falls existiert)

---

## ⚠️ Wenn Fehler auftreten:

```bash
# Logs prüfen
pm2 logs event-vt-website --lines 20

# Port belegt?
lsof -i :8080

# Dependencies vergessen?
cd /root/public_html/event-vt/Website\ VT
npm install --production

# Neustart
pm2 restart event-vt-website
```

---

🚀 **Los geht's! Versuch OPTION 2 - das ist am zuverlässigsten!**
