#!/bin/bash
set -e

echo "Activating feature 'jlink'"

JLINK_VERSION=${VERSION:-undefined}

# Check version
if [[ "${JLINK_VERSION}" == undefined ]]; then
    echo "No JLink version specified!"
    exit 1
fi

if [[ "${JLINK_VERSION}" == "latest" ]]; then
    # Latest version mean no version
    JLINK_VERSION_STRING=""
else
    # Remove any character that's not a 0-9 or a-z
    JLINK_VERSION_STRING="_V${JLINK_VERSION//[^0-9a-z]}"
fi

# Install JLink
echo "Installing JLink version ${JLINK_VERSION_STRING}"
mkdir -p /tmp/jlink
wget --show-progress -qO /tmp/jlink/JLink_Linux_x86_64.tgz "https://www.segger.com/downloads/jlink/JLink_Linux${JLINK_VERSION_STRING}_x86_64.tgz" \
     --post-data "accept_license_agreement=accepted&submit=Download+software"
tar -xvzf *.tgz -C /opt

# Cleanup
rm -rf /tmp/jlink