#!/bin/bash
set -e

source dev-container-features-test-lib

# Feature-specific tests
check "mold available" bash -c "mold --version"
check "mold version" bash -c "mold --version | grep 'mold 2.3.1'"

# Report results
reportResults