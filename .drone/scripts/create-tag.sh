#!/usr/bin/bash
set -e
current_fingerprint="$(curl -s "https://api.${github_url}/meta" | jq -r '.ssh_key_fingerprints.SHA256_ED25519')"
echo "${ssh_key}" | tee "/${HOME}/.ssh/ssh_key"

SSH_HOST="${github_url}" \
SSH_EXPECTED_FINGERPRINT="SHA256:${current_fingerprint}" \
SET_PERMS="true" \
get-ssh-key

echo "Host ${github_url}" | tee "/${HOME}/.ssh/config"
echo "  Hostname ${github_url}" | tee -a "/${HOME}/.ssh/config"
echo "  IdentityFile /${HOME}/.ssh/ssh_key" | tee -a "/${HOME}/.ssh/config"

source makedeb/PKGBUILD
git tag "v${pkgver}-${pkgrel}"
git push "ssh://git@${github_url}/hwittenborn/hmac-http" "v${pkgver}-${pkgrel}"
