# 🔄 Event VT - Netcup Update Anleitung

**Status:** Du bist im Netcup Terminal und hast Code gepusht. Jetzt deployen wir die Änderungen.

---

## ✅ Schnell-Update (Copy & Paste)

Führe im Netcup-Terminal aus:

```bash
# In deployed directory gehen
cd /root/public_html/event-vt

# Neueste Version checkout
git --work-tree=. --git-dir=/root/repositories/event-vt.git checkout -f main

# Zu Backend gehen
cd backend

# Dependencies neu installieren
npm install --production

# Zum root zurück
cd ..

# Backend mit PM2 restartet
pm2 restart event-vt-backend

# Status checken
pm2 list

# (Optional) Logs anschauen
pm2 logs event-vt-backend
```

---

## 🧪 Nach dem Update - Tests

```bash
# Backend läuft?
curl http://localhost:4000/api/settings

# Frontend erreichbar?
curl http://localhost:8080

# Alle Prozesse ok?
pm2 status
```

---

## 🐛 Falls was schiefgeht

```bash
# PM2 Logs anschauen
pm2 logs event-vt-backend

# Manuell starten (für Fehler)
cd /root/public_html/event-vt/backend && node src/server.js

# Git Status checken
cd /root/public_html/event-vt && git status
```

---

## 📍 Wichtige Pfade

- **Code-Verzeichnis:** `/root/public_html/event-vt`
- **Bare Repository:** `/root/repositories/event-vt.git`
- **Backend Entry:** `/root/public_html/event-vt/backend/src/server.js`
- **Frontend Serv:** `/root/public_html/event-vt/Website\ VT` (http-server port 8080)

