#!/bin/bash
set -e

echo "Activating feature 'vcpkg'"

VCPKG_VERSION=${VERSION:-undefined}
VCPKG_PACKAGES=${PACKAGES:-""}

# Check version
if [[ "${VCPKG_VERSION}" == undefined ]]; then
    echo "No vcpkg version specified!"
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

# Install vcpkg
git clone https://github.com/Microsoft/vcpkg.git /workspaces/vcpkg
cd /workspaces/vcpkg
if [[ "${VCPKG_VERSION}" != "latest" ]]; then
    git -C /workspaces/vcpkg checkout ${VCPKG_VERSION}
fi
/workspaces/vcpkg/bootstrap-vcpkg.sh -disableMetrics

# Install packages
if [[ "${VCPKG_PACKAGES}" != "" ]]; then
    /workspaces/vcpkg/vcpkg install ${VCPKG_PACKAGES}
fi
