# 🔄 VT-Technik-Webiste - Schnell Update

Du bist auf Netcup und möchtest deine Ordner mit Git aktualisieren.

---

## 🚀 **Schnellste Lösung - Lokal + GitHub + Netcup**

### Im VS Code Terminal (in /workspaces/codespaces-blank):

```bash
# Alles ändern adden
git add .

# Commiten
git commit -m "Update: VT-Technik-Webiste Ordner"

# Zu GitHub pushen
git push origin main

# Zu Netcup pushen (Auto-Deploy)
git push netcup main
```

**Fertig!** Der Code ist jetzt auf GitHub + Auto-deployed auf Netcup.

---

## 📍 **Oder einzeln auf Netcup (falls nur dort update nötig):**

Im Netcup-Terminal:

```bash
cd /root/public_html/vt-technik-webiste

# Vom Bare-Repo checkout (neueste Version)
git --work-tree=. --git-dir=/root/repositories/vt-technik-webiste.git checkout -f main

# Oder von GitHub pullen
git pull origin main

# Dependencies aktualisieren
npm install --production
```

---

## ⚡ **Automatisiert (Skript verwenden):**

Falls Scripts aktiviert sind:

```bash
bash update-vt-technik.sh
```

Das Skript fragt nach einer Commit-Nachricht und macht alles automatisch.

---

**Was aktualisierst du?** Nur Frontend-Dateien oder auch Backend?
