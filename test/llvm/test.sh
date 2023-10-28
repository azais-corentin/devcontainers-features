#!/bin/bash
set -e

source dev-container-features-test-lib

# Feature-specific tests
check "clang-17 available" bash -c "clang-17 --version | grep 'clang version 17'"

# Report results
reportResults