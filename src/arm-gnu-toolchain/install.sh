#!/bin/bash
set -e

echo "Activating feature 'arm-gnu-toolchain'"

ARM_GNU_TOOLCHAIN_VERSION=${VERSION:-undefined}

# Check version
if [[ "${ARM_GNU_TOOLCHAIN_VERSION}" == undefined ]]; then
    echo "No Arm GNU Toolchain version specified!"
    exit 1
fi

# Check architecture
architecture=$(dpkg --print-architecture)
case "${architecture}" in
    amd64)
        ARCH=x86_64 ;;
    *)
        echo "Unsupported architecture ${architecture}."
        exit 1
        ;;
esac

# Install Arm GNU Toolchain
mkdir -p /tmp/arm-gnu-toolchain
apt-get -qq update
apt -qqy --no-install-recommends install python3 python3-pip libncursesw5
wget -qP /tmp/arm-gnu-toolchain --show-progress "https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_GNU_TOOLCHAIN_VERSION}/binrel/arm-gnu-toolchain-${ARM_GNU_TOOLCHAIN_VERSION}-x86_64-arm-none-eabi.tar.xz"
wget -qO /tmp/arm-gnu-toolchain/archive.md5 --show-progress "https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_GNU_TOOLCHAIN_VERSION}/binrel/arm-gnu-toolchain-${ARM_GNU_TOOLCHAIN_VERSION}-x86_64-arm-none-eabi.tar.xz.asc"
md5sum -c /tmp/arm-gnu-toolchain/archive.md5
tar xf /tmp/arm-gnu-toolchain/*.xz -C /opt

# Cleanup
apt-get -qqy autoclean
apt-get -qqy autoremove
apt-get -qqy clean
rm -rf /tmp/arm-gnu-toolchain