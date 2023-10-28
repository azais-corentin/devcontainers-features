#!/bin/sh
set -e

echo "Activating feature 'llvm'"

LLVM_VERSION=${VERSION:-undefined}

# Install dependencies
apt-get -qq update
apt-get -qqy install lsb-release wget software-properties-common gnupg

# Install LLVM
wget -O /tmp/llvm.sh "https://apt.llvm.org/llvm.sh"
chmod +x /tmp/llvm.sh
/tmp/llvm.sh ${LLVM_VERSION}

# Cleanup
apt-get -qqy autoremove
apt-get -qqy clean
rm -rf /var/lib/apt/lists/*
rm /tmp/llvm.sh