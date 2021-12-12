#!/usr/bin/bash
set -e
mpr_fingerprint='SHA256:TQtnFwjBwpDOHnHTaANeudpXVmomlYo6Td/8T51FA/w'

SSH_HOST="${mpr_url}" \
SSH_EXPECTED_FINGERPRINT="${mpr_fingerprint}" \
SET_PERMS="true" \
get-ssh-key

echo "${ssh_key}" > "${HOME}/.ssh/ssh_key"
echo "Host ${mpr_url}" > "/${HOME}/.ssh/config"
echo "  Hostname ${mpr_url}" > "/${HOME}/.ssh/config"
echo "  IdentityFile /${HOME}/.ssh/ssh_key" | tee -a "/${HOME}/.ssh/config"

git clone "ssh://mpr@${mpr_url}/python3-hmac-http"
cp makedeb/PKGBUILD python3-hmac-http/PKGBUILD
cd python3-hmac-http/
makedeb --print-srcinfo > .SRCINFO

source PKGBUILD
git add PKGBUILD .SRCINFO
git commit -m "Updated version to ${pkgver}-${pkgrel}"
git push
