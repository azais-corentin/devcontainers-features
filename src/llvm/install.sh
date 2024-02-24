#!/bin/bash
set -e

echo "Activating feature 'llvm'"

LLVM_VERSION=${VERSION:-undefined}

# Install LLVM
apt-get -qq update
apt-get -qqy install lsb-release wget software-properties-common gnupg
mkdir -p /tmp
wget https://apt.llvm.org/llvm.sh -O /tmp/llvm.sh
chmod +x /tmp/llvm.sh

if [[ "${LLVM_VERSION}" == "latest" ]]; then
    /tmp/llvm.sh all
else
    /tmp/llvm.sh ${LLVM_VERSION} all
fi

# Cleanup
apt-get -qqy autoclean
apt-get -qqy autoremove
apt-get -qqy clean
rm -rf /var/lib/apt/lists/*
rm /tmp/llvm.sh