# 🚀 NETCUP DEPLOYMENT - SOFORT STARTEN

## Deine Netcup-IP: 159.195.144.255

Du hast 2 Optionen:

---

## ✅ OPTION 1: Mit SSH-Key (Empfohlen - kein Passwort nötig)

### Schritt 1: SSH-Key zu Netcup hinzufügen (via SSH)

Verbinde dich auf Netcup und führe aus:

```bash
mkdir -p ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAW2qWneyWF12gpNnZ1MSpbkhQIprEx+CkeU+czOE4pd codespace" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
echo "✅ SSH-Key hinzugefügt!"
```

### Schritt 2: Lokal testen

```bash
ssh -i ~/.ssh/id_ed25519 root@159.195.144.255 "ls ~/repositories/event-vt.git"
```

sollte das Repository zeigen ohne Passwort abzufragen.

### Schritt 3: Push zu Netcup

```bash
cd /workspaces/codespaces-blank
git push netcup main
```

---

## 🔐 OPTION 2: Mit Passwort (wenn SSH-Key nicht möglich)

Falls SSH-Key nicht geht, verwende ein Passwort-gestütztes Setup:

```bash
cd /workspaces/codespaces-blank

# Git mit SSH-Passwort-Prompt konfigurieren
GIT_SSH_COMMAND="ssh -o PubkeyAuthentication=no -o StrictHostKeyChecking=accept-new" git push netcup main
```

---

## 🔧 Setup-Fehlerbehandlung

**Falls Push fehlschlägt:**

```bash
# 1. Teste SSH-Verbindung
ssh -v root@159.195.144.255 "echo OK"

# 2. Prüfe dass Repository auf Server existiert
ssh root@159.195.144.255 "ls -la ~/repositories/event-vt.git/hooks/"

# 3. Teste Git-Push mit Verbose
GIT_TRACE=1 git push netcup main
```

---

## 📊 Nach dem Push

Prüfe auf Netcup-Server:

```bash
ssh root@159.195.144.255
pm2 list                        # Backend-Status
pm2 logs event-vt-backend       # Backend-Logs
ls -la ~/public_html/event-vt   # Deployed Code
```

---

## ⚡ SOFORT-COMMANDS

**Für schnellen Durchblick - kopiere diese Befehle nacheinander:**

```bash
# Test 1: SSH-Verbindung
ssh root@159.195.144.255 whoami

# Test 2: Push mit Passwort
cd /workspaces/codespaces-blank && git push netcup main
```

---

## 🎯 WAS PASSIERT BEI ERFOLGREICH PUSH

1. Git pushed Code zu Netcup
2. Post-Receive Hook wird ausgelöst
3. Code wird zu ~/public_html/event-vt deployed
4. npm install --production läuft
5. Backend wird mit pm2 (re)started
6. App läuft auf Port 4000!

---

💡 **Nächster Schritt:** 
1. SSH-Key hinzufügen ODER
2. `git push netcup main` mit Passwort versuchen
