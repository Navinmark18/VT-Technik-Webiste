#!/bin/bash
# 🔑 SSH-Key zum Netcup-Server hinzufügen

# Dein SSH-Public-Key (vom Codespace):
PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAW2qWneyWF12gpNnZ1MSpbkhQIprEx+CkeU+czOE4pd codespace"

# Auf dem Netcup-Server ausführen:
mkdir -p ~/.ssh
echo "$PUBLIC_KEY" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh

echo "✅ SSH-Key hinzugefügt!"
echo "Teste: ssh -i ~/.ssh/id_ed25519 root@159.195.144.255"
