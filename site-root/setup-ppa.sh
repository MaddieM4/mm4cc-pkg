#!/bin/sh
set -e

PPA_URL="${MM4CC_PPA_URL:-https://ppa.maddiem4.cc}"
PPA_SUITE="${MM4CC_PPA_SUITE:-stable}"

HUMAN="$(whoami)"
SUDO="sudo"
if [ "$HUMAN" = "root" ]; then
  SUDO=''
fi

KEYRING_PATH=/usr/share/keyrings/mm4cc.gpg

# Install GPG key
curl "${PPA_URL}/mm4cc.gpg" | $SUDO tee "$KEYRING_PATH" > /dev/null

# Create source file
$SUDO tee /etc/apt/sources.list.d/mm4cc.sources <<EOF
Types: deb
Architectures: $(dpkg --print-architecture)
Signed-By: $KEYRING_PATH
URIs: $PPA_URL/debian
Suites: $PPA_SUITE
Components: main
EOF

# Install base and download all indexes
$SUDO apt update
$SUDO apt install -y mm4cc-base
$SUDO apt update
