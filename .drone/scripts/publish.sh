#!/usr/bin/bash
set -ex

apt-get update
apt-get install curl jq -y

pkgver="$(cat .data.json | jq -r '.version')"

pip install build
python -m build

curl "https://${proget_server}/pypi/python/upload/hmac-http-${pkgver}.tar.gz" \
     --user "api:${proget_api_key}" \
     --upload-file "./dist/hmac-http-${pkgver}.tar.gz"
