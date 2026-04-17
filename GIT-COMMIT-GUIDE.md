# 📝 GIT COMMIT MESSAGE GUIDE

## Was ist eine Commit-Nachricht?

Eine Nachricht, die **was du geändert hast** beschreibt.

---

## ✅ GUTE Commit-Nachrichten

```
Netcup Deployment eingerichtet
```

```
Add Git hooks für automatisches Deployment
```

```
Setup Backend & Frontend auf Netcup Server
```

```
Configure repository with Post-Receive Hook
```

---

## ❌ SCHLECHTE Commit-Nachrichten

```
fix
update
stuff
asdf
changes
```

---

## 📋 STRUKTUR (optional, besser)

**Erste Zeile:** Kurze Zusammenfassung (max 50 Zeichen)
**Leerzeile**
**Dann:** Detaillierte Erklärung (optional)

Beispiel:

```
Netcup deployment konfiguriert

- Git Bare Repository eingerichtet
- Post-Receive Hook für Auto-Deploy
- Backend auf Port 4000
- Frontend auf Port 8080
```

---

## 🎯 FÜR DEIN PROJEKT

Du kannst einfach schreiben:

```
Netcup Deployment Setup - Backend & Frontend ready
```

Oder ausführlicher:

```
Setup Netcup Deployment

- Git repository auf Netcup
- Post-Receive Hook konfiguriert  
- Backend & Frontend vorbereitet
- Ready for production
```

---

**Jetzt:**
1. Öffne die COMMIT_EDITMSG Datei
2. Schreibe eine Nachricht (z.B. "Netcup Deployment Setup")
3. Speichern & Exit (Vim: Esc + :wq)
4. Dann: `git push origin main && git push netcup main`

Done! 🚀
