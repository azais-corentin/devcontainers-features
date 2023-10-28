#!/bin/bash
set -e

echo "Activating feature 'mold'"

MOLD_VERSION=${VERSION:-undefined}

# Check version
if [[ "${MOLD_VERSION}" == undefined ]]; then
    echo "No Mold version specified!"
    exit 1
fi

# Install mold
git clone https://github.com/rui314/mold.git /tmp/mold
mkdir /tmp/mold/build
cd /tmp/mold/build/
git checkout v${MOLD_VERSION}
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=c++ ..
cmake --build . -j $(nproc)
cmake --build . --target install

# Cleanup
rm -rf /tmp/mold
