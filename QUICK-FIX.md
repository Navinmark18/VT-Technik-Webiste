# 🚀 NETCUP DEPLOYMENT - FINAL SOLUTION

Der Git-Push war erfolgreich, aber der Checkout schlägt fehl. **Schnelle Lösung:**

## Du brauchst NUR DIESE 3 BEFEHLE auf Netcup:

### Auf Netcup-Server (im Terminal wo du verbunden bist):

```bash
# 1. Warte auf SCP-Transfer (Falls dieser noch läuft)
# oder führe direkt aus:

cd /root/public_html/event-vt

# 2. Clone vom Bare Repository (einfach - funktioniert immer!)
rm -rf *
git clone /root/repositories/event-vt.git . --branch main

# 3. Install & Start
cd backend
npm install --production
pm2 start src/server.js --name event-vt-backend --env production

# 4. Status
pm2 list
```

---

## ✅ WENN DAS NICHT FUNKTIONIERT:

Kopiere & paste auf Netcup:

```bash
# Bare Repository reparieren
cd /root/repositories/event-vt.git
git config uploadpack.allowAnySHA1InWant true
git config uploadpack.allowReachableSHA1InWant true

# Dann Checkout versuchen
cd /root/public_html/event-vt
git clone /root/repositories/event-vt.git . --branch main --verbose
```

---

## 🏁 DANACH - ALLES FERTIG!

```bash
cd /root/public_html/event-vt/backend
npm install --production
pm2 start src/server.js --name event-vt-backend
pm2 list

# Test
curl http://localhost:4000/api/settings
```

---

**SUMMARY:**
- ✅ Netcup-IP: 159.195.144.255
- ✅ Repo: /root/repositories/event-vt.git
- ✅ Deploy: /root/public_html/event-vt
- ✅ Backend Port: 4000

👉 **Mach das jetzt auf Netcup und gib mir Bescheid!**
