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

# Utilities
updaterc() {
    if [ "${UPDATE_RC}" = "true" ]; then
        echo "Updating /etc/bash.bashrc and /etc/zsh/zshrc..."
        if [[ "$(cat /etc/bash.bashrc)" != *"$1"* ]]; then
            echo -e "$1" >> /etc/bash.bashrc
        fi
        if [ -f "/etc/zsh/zshrc" ] && [[ "$(cat /etc/zsh/zshrc)" != *"$1"* ]]; then
            echo -e "$1" >> /etc/zsh/zshrc
        fi
    fi
}

# Install cmake
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-${ARCH}.sh -O /tmp/cmake-install.sh
chmod u+x /tmp/cmake-install.sh
mkdir -p /opt/cmake
/tmp/cmake-install.sh --skip-license --prefix=/opt/cmake

# Add to bashrc/zshrc files
updaterc "$(cat << EOF
export CMAKE_HOME="/opt/cmake"
if [[ "\${PATH}" != *"\${CMAKE_HOME}/bin"* ]]; then export PATH="\${CMAKE_HOME}/bin:\${PATH}"; fi
EOF
)"

# Cleanup
rm /tmp/cmake-install.sh
