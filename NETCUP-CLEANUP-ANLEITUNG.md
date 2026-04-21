# 🧹 Netcup - Nur Website VT-T Cleanup

Du bist auf Netcup im `~/VT-Technik-Webiste` Verzeichnis und möchtest nur **Website VT-T** behalten.

---

## 🚀 Schnelle Lösung - Direkt im Terminal:

```bash
# Im Verzeichnis sein
cd ~/VT-Technik-Webiste

# Alles außer Website VT-T löschen
rm -rf "Website VT" Projekt_Spiel/ *.md *.sh *.json

# Überprüfen was bleibt
ls -la
```

Fertig! 🎉 Nur noch `Website VT-T` ist da.

---

## 🔧 Wenn du umbenennnen möchtest (Website VT-T → Website VT):

```bash
mv "Website VT-T" "Website VT"
```

Dann ist es wie eine normale Website-Struktur.

---

## 📍 Falls du es in den Webroot verschieben möchtest:

```bash
# Zu /root/public_html verschieben
mv "Website VT-T" /root/public_html/vt-technik
cd /root/public_html/vt-technik

# Starten
npm run dev
```

---

**Was willst du machen?**
1. Nur löschen (bleib im ~/VT-Technik-Webiste)?
2. Umbenennen zu Website VT?
3. In /root/public_html verschieben?

