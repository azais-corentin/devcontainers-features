#!/bin/bash
set -e

source dev-container-features-test-lib

# Feature-specific tests
check "cmake available" bash -c "cmake --version | grep 'cmake version 3.27.7'"

# Report results
reportResults