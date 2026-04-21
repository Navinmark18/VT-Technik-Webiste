# 🚀 VT-Technik-Webiste auf Netcup deployen

**Repository:** https://github.com/Navinmark18/VT-Technik-Webiste.git
**Ziel:** Auf Netcup (159.195.144.255) deployen mit Auto-Update

---

## 📋 **Schritt 1: Auf Netcup - Bare-Repository erstellen**

```bash
ssh root@159.195.144.255

mkdir -p /root/repositories/vt-technik-webiste.git
cd /root/repositories/vt-technik-webiste.git
git init --bare
```

**Status:** ✅ Bare-Repository erstellt

---

## 📋 **Schritt 2: Auf Netcup - Deployment-Verzeichnis**

```bash
mkdir -p /root/public_html/vt-technik-webiste
```

**Status:** ✅ Verzeichnis erstellt

---

## 📋 **Schritt 3: Auf Netcup - Post-Receive Hook (Auto-Deploy)**

```bash
cat > /root/repositories/vt-technik-webiste.git/hooks/post-receive << 'EOF'
#!/bin/bash
git --work-tree=/root/public_html/vt-technik-webiste --git-dir=/root/repositories/vt-technik-webiste.git checkout -f main
cd /root/public_html/vt-technik-webiste
npm install --production 2>&1 | tail -5
echo "✅ VT-Technik-Webiste updated successfully!"
EOF

chmod +x /root/repositories/vt-technik-webiste.git/hooks/post-receive
```

**Was passiert:** Hook wird automatisch nach jedem Push ausgelöst → Code wird autom. deployed + npm install

---

## 📋 **Schritt 4: Lokal (VS Code) - Remote hinzufügen**

Im lokalen Terminal in `/workspaces/codespaces-blank`:

```bash
git remote add netcup ssh://root@159.195.144.255/root/repositories/vt-technik-webiste.git
```

**Status:** ✅ Remote hinzugefügt (kannst mit `git remote -v` checken)

---

## 📋 **Schritt 5: Lokal - Code zu Netcup pushen**

```bash
git push netcup main
```

**Was passiert:** 
1. Code wird zu Netcup gepusht
2. Post-Receive Hook triggert
3. Code wird automatisch in `/root/public_html/vt-technik-webiste` deployed
4. `npm install --production` läuft

---

## 🧪 **Schritt 6: Auf Netcup - Überprüfen**

```bash
ls -la /root/public_html/vt-technik-webiste
```

Du solltest alle deine Dateien sehen (admin.html, etc.)

---

## 🚀 **Schritt 7: Starten (Optional)**

Falls du einen Server starten willst:

```bash
cd /root/public_html/vt-technik-webiste

# Für statische Website:
npx http-server -p 8081 &

# Oder mit PM2:
# pm2 start "http-server -p 8081" --name vt-technik
# pm2 save
```

---

## 📍 **Wichtige Pfade**

- **Bare-Repo:** `/root/repositories/vt-technik-webiste.git`
- **Deployed:** `/root/public_html/vt-technik-webiste`
- **Hook:** `/root/repositories/vt-technik-webiste.git/hooks/post-receive`
- **Server IP:** 159.195.144.255

---

## 🔄 **Zukünftige Updates**

Wenn du Code änderst und pushen möchtest:

```bash
git add .
git commit -m "Deine Änderung"
git push netcup main
```

Fertig! Hook macht den Rest. 🎉
