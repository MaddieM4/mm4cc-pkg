#!/bin/sh
set -e

# TODO: Make dynamic
# TODO: Proper architecture list
PPA_SITE=http://ppa-host

HUMAN="$(whoami)"
SUDO="sudo"
if [ "$HUMAN" = "root" ]; then
  SUDO=''
fi

KEYRING_PATH=/usr/share/keyrings/mm4cc.gpg

# Install GPG key
curl "${PPA_SITE}/mm4cc.gpg" | $SUDO tee "$KEYRING_PATH" > /dev/null

# Create source file
$SUDO tee /etc/apt/sources.list.d/mm4cc.sources <<EOF
Types: deb
Architectures: amd64
Signed-By: $KEYRING_PATH
URIs: $PPA_SITE/debian
Suites: stable
Components: main
EOF

# Update local package index
$SUDO apt update

# Attempt to install a package
$SUDO apt install -y obsidian
