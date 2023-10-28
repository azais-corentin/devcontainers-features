#!/bin/bash
echo "Activating feature 'llvm'"

LLVM_VERSION=${VERSION:-undefined}

# Install LLVM
echo "deb https://apt.llvm.org/bookworm llvm-toolchain-bookworm-${LLVM_VERSION} main" > /etc/apt/sources.list.d/llvm.list
wget https://apt.llvm.org/llvm-snapshot.gpg.key -qO /etc/apt/trusted.gpg.d/llvm.asc
apt-get -qq update
apt-get -qqy install -t llvm-toolchain-bookworm-${LLVM_VERSION} clang-${LLVM_VERSION} clangd-${LLVM_VERSION} clang-tidy-${LLVM_VERSION} clang-format-${LLVM_VERSION} lld-${LLVM_VERSION}

# Cleanup
apt-get -qqy autoclean
apt-get -qqy autoremove
apt-get -qqy clean
rm -rf /var/lib/apt/lists/*