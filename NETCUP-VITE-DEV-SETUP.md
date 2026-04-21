# 🚀 VT-Technik-Webiste Vite Dev-Server - Netcup Setup

**Problem:** `vite: not found` - Dependencies sind nicht installiert

**Lösung:** npm install auf Netcup ausführen

---

## 📋 Schritt-für-Schritt auf Netcup

### Schritt 1: Ins Verzeichnis gehen

```bash
cd ~/VT-Technik-Webiste/'Website VT-T'
```

Oder (ohne Leerzeichen-Problem):

```bash
cd /root/public_html/vt-technik-webiste/Website\ VT-T
```

---

### Schritt 2: Dependencies installieren

```bash
npm install
```

**Was passiert:** Installiert alle Pakete aus `package.json` inklusive Vite

**Wartet bis fertig (sollte ~10-30 Sekunden dauern)**

---

### Schritt 3: Dev-Server starten

```bash
npm run dev
```

**Output sollte so aussehen:**

```
  VITE v5.x.x  ready in XXX ms

  ➜  Local:   http://localhost:5173/
  ➜  Press h to show help
```

---

### Schritt 4: Im Browser öffnen

Wenn du lokal browsest:

```bash
ssh -L 5173:localhost:5173 root@159.195.144.255
```

Dann: `http://localhost:5173` im Browser

---

## 🔧 Wenn Fehler auftauchen:

```bash
# package-lock.json löschen und neu installieren
rm package-lock.json
npm install

# Oder Cache clearnen
npm cache clean --force
npm install
```

---

## 📍 Wichtig:

- **Node.js Version:** Check mit `node --version` (sollte v16+ sein)
- **npm Version:** Check mit `npm --version`
- **Port 5173:** Muss freigeschossen sein auf Netcup

---

Viel Erfolg! 🎉
