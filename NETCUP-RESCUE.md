# 🆘 NETCUP DEPLOYMENT - RETTUNGS-ANLEITUNG

Wenn Git-Checkout nicht funktioniert, versuche diese Optionen der Reihe nach:

---

## ✅ OPTION 1: Git-Repository reparieren

**Auf Netcup-Server eingeben:**

```bash
cd /root/repositories/event-vt.git

# Repository-Konfiguration prüfen
git config --list

# Vielleicht ist der Push nicht vollständig angekommen
# Versuche erneut zu pushen von lokal:
# (auf deinem PC/Codespace)
# git push netcup main --force

# Wenn Push OK, dann:
cd /root/public_html/event-vt
git clone /root/repositories/event-vt.git . --branch main
```

---

## ✅ OPTION 2: Manueller Checkout mit Konfiguration

**Auf Netcup-Server:**

```bash
cd /root/public_html/event-vt

# Initialisiere lokales Git
git init
git remote add origin /root/repositories/event-vt.git

# Hole Daten
git fetch origin main

# Checkout
git checkout -f origin/main

# Prüfe Struktur
ls -la
```

---

## ✅ OPTION 3: Von lokal mit rsync (schnell)

**Auf deinem PC/Codespace:**

```bash
cd /workspaces/codespaces-blank

# Übertrage den Code direkt mit rsync
rsync -avz --exclude='.git' --exclude='node_modules' \
  . root@159.195.144.255:/root/public_html/event-vt/
```

Dann auf Netcup:

```bash
cd /root/public_html/event-vt/backend
npm install --production
pm2 start src/server.js --name event-vt-backend
pm2 list
```

---

## ✅ OPTION 4: Mit tar Transfer (wenn rsync nicht geht)

**Auf lokalem PC:**

```bash
# Komprimiere Code
cd /workspaces/codespaces-blank
tar czf /tmp/code.tar.gz --exclude=.git --exclude=node_modules .

# Transfer mit scp
scp /tmp/code.tar.gz root@159.195.144.255:/tmp/
```

**Auf Netcup:**

```bash
cd /root/public_html/event-vt
tar xzf /tmp/code.tar.gz
cd backend
npm install --production
pm2 start src/server.js --name event-vt-backend
pm2 list
```

---

## 🎯 SCHNELLSTE LÖSUNG

Auf Netcup direkt ausführen:

```bash
# 1. Leere das Verzeichnis
rm -rf /root/public_html/event-vt/*

# 2. Clone vom Bare Repository
git clone /root/repositories/event-vt.git /root/public_html/event-vt

# 3. Setup Backend
cd /root/public_html/event-vt/backend
npm install --production
pm2 start src/server.js --name event-vt-backend

# 4. Prüfe
pm2 list
curl http://localhost:4000/api/settings
```

---

## 📋 DEBUGGING

Wenn immer noch Fehler:

```bash
# Repository Fehler?
cd /root/repositories/event-vt.git
git fsck --full

# Berechtigungen?
ls -la /root/repositories/event-vt.git/objects/

# Disk-Platz?
df -h

# Backend läuft?
ps aux | grep node
pm2 logs event-vt-backend
```

---

**WAS VERSUCHST DU ZUERST?**
Empfehlung: OPTION 4 (tar Transfer) - das funktioniert immer!
