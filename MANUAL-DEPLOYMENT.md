# 🎯 NETCUP DEPLOYMENT - MANUELLE ANLEITUNG (KEINE INTERAKTIVITÄT)

## Deine Infos:
- **Netcup-IP:** 159.195.144.255
- **Netcup-User:** root
- **Repository:** ~/repositories/event-vt.git
- **Deploy-Path:** ~/public_html/event-vt

---

## ⚡ SCHRITT 1: SSH-Key zu Netcup hinzufügen

**Du brauchst:**
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAW2qWneyWF12gpNnZ1MSpbkhQIprEx+CkeU+czOE4pd codespace
```

**Auf Netcup-Server (via SSH) eingeben:**
```bash
mkdir -p ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAW2qWneyWF12gpNnZ1MSpbkhQIprEx+CkeU+czOE4pd codespace" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
echo "✅ SSH-Key hinzugefügt!"
```

---

## ⚡ SCHRITT 2: SSH-Verbindung testen

**Lokal im Terminal eingeben (ohne Passwort):**
```bash
ssh -i ~/.ssh/id_ed25519 root@159.195.144.255 "ls ~/repositories/event-vt.git"
```

**Sollte antworten:**
```
HEAD  config  description  hooks  objects  refs
```

Falls "Permission denied" → SSH-Key nicht richtig hinzugefügt.

---

## ⚡ SCHRITT 3: Git-Push zu Netcup

**Lokal eingeben:**
```bash
cd /workspaces/codespaces-blank
git push netcup main
```

**Sollte anzeigen:**
```
Enumerating objects: ...
Counting objects: ...
Compressing objects: ...
...
remote: 📦 Deploying Event VT...
remote: 📥 Checking out code...
remote: 📦 Installing backend dependencies...
remote: ...
remote: ✅ Deployment complete!
To ssh://root@159.195.144.255/root/repositories/event-vt.git
 * [new branch]      main -> main
```

---

## 🔍 SCHRITT 4: Backend-Status auf Netcup prüfen

**SSH zum Server:**
```bash
ssh root@159.195.144.255
```

**Dann im Server-Terminal:**
```bash
# Status alle Prozesse
pm2 list

# Backend-Logs live
pm2 logs event-vt-backend

# Prüfe ob Code deployed
ls -la ~/public_html/event-vt/

# Prüfe Backend
curl http://localhost:4000/api/settings
```

---

## 💾 VON NUN AN - WORKFLOW

Jedes Mal wenn du Code änderst:

```bash
git add .
git commit -m "Deine Änderung"
git push netcup main

# Das's! Backend updated sich automatisch via Hook
```

---

## ❌ FEHLERBEHANDLUNG

### "Permission denied (publickey)"
→ SSH-Key nicht zu authorized_keys hinzugefügt
→ Wiederhole Schritt 1

### "Connection refused"
→ SSH-Server nicht erreichbar
→ Prüfe Netcup-Firewall (Port 22)
→ Prüfe IP: `ssh -v root@159.195.144.255`

### "Remote Hook fehlgeschlagen"
→ Backend-abhängigkeiten fehlen
→ SSH zu Server: `cd ~/public_html/event-vt/backend && npm install --production`

### "npm: command not found nach Deploy"
→ Node.js nicht auf Server installiert
→ SSH zu Server: `apt-get update && apt-get install -y nodejs npm`

---

## 📋 FERTIG-CHECKLIST

- [ ] SSH-Key zu Netcup authorized_keys hinzugefügt
- [ ] SSH Test erfolgreich: `ssh root@159.195.144.255 whoami`
- [ ] Git-Push erfolgreich: `git push netcup main`
- [ ] Backend läuft: `pm2 list` zeigt "online"
- [ ] Code deployed: `ls ~/public_html/event-vt/` zeigt Dateien

🎉 **FERTIG!**

---

## 🚀 BONUS

**Schnelle Befehle speichern:**

```bash
# In ~/.bash_profile oder ~/.bashrc:
alias netcup-logs="ssh root@159.195.144.255 'pm2 logs event-vt-backend'"
alias netcup-ssh="ssh root@159.195.144.255"
alias netcup-push="cd /workspaces/codespaces-blank && git push netcup main"

# Dann nutzen:
netcup-push
netcup-logs
netcup-ssh
```
