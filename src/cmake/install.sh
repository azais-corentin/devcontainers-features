#!/bin/sh
set -e

echo "Activating feature 'cmake'"

CMAKE_VERSION=${VERSION:-undefined}

# Check version
if [[ "${CMAKE_VERSION}" == undefined ]]; then
    echo "No CMake version specified!"
    exit 1
fi

# Check architecture
architecture=$(dpkg --print-architecture)
case "${architecture}" in
    arm64)
        ARCH=aarch64 ;;
    amd64)
        ARCH=x86_64 ;;
    *)
        echo "Unsupported architecture ${architecture}."
        exit 1
        ;;
esac

# Install cmake
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-${ARCH}.sh -O /tmp/cmake-install.sh
chmod u+x /tmp/cmake-install.sh
mkdir -p /opt/cmake
/tmp/cmake-install.sh --skip-license --prefix=/opt/cmake

# Add to bashrc/zshrc files
ln -s /opt/cmake/bin/cmake /usr/bin/cmake
ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

# Cleanup
rm /tmp/cmake-install.sh
