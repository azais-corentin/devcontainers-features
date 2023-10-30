#!/bin/bash
set -e

echo "Activating feature 'ninja'"

NINJA_VERSION=${VERSION:-undefined}

# Handle version
if [[ "${NINJA_VERSION}" == undefined ]]; then
    echo "No Ninja version specified!"
    exit 1
fi

if [[ "${NINJA_VERSION}" == "latest" ]]; then
    NINJA_DOWNLOAD_LINK="https://github.com/ninja-build/ninja/releases/latest/download/ninja-linux.zip"
else
    # Remove any character that's not a 0-9 or a '.'
    NINJA_VERSION_STRING="${NINJA_VERSION//[^0-9\.]}"
    NINJA_DOWNLOAD_LINK="https://github.com/ninja-build/ninja/releases/download/v${NINJA_VERSION_STRING}/ninja-linux.zip"
fi

# Install Ninja
mkdir -p /tmp/ninja
wget --show-progress -qO /tmp/ninja/ninja.zip "${NINJA_DOWNLOAD_LINK}"
unzip /tmp/ninja/ninja.zip -d /usr/local/bin

# Cleanup
rm -rf /tmp/ninja
