#!/bin/bash
set -e

echo "Activating feature 'pico-sdk'"

PICO_SDK_VERSION=${VERSION:-undefined}

# Check version
if [[ "${PICO_SDK_VERSION}" == undefined ]]; then
    echo "No Raspberry Pi Pico SDK version specified!"
    exit 1
fi

cd /opt
git clone --recursive https://github.com/raspberrypi/pico-sdk.git
cd /opt/pico-sdk
git checkout ${PICO_SDK_VERSION} --recurse-submodules