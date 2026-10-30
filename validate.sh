#!/bin/bash

# Exit immediately if any command fails during test execution
set -e

echo "=== Running Pre-flight Validations ==="

# 1. Check whether package.json exists
if [[ -f "package.json" ]]; then
    echo "✔ package.json is present."
else
    echo "❌ Error: package.json is missing!" >&2
    exit 1
fi

# 2. Check whether node_modules exists
if [[ -d "node_modules" ]]; then
    echo "✔ node_modules directory is present."
else
    echo "❌ Error: node_modules is missing! Run 'npm install' first." >&2
    exit 1
fi

# 3. Check whether index.js exists and port 4005 is configured inside it
if [[ -f "index.js" ]]; then
    if grep -q "4010" index.js; then
        echo "✔ Port 4005 configuration found in index.js."
    else
        echo "❌ Error: Port 4005 is not configured in index.js!" >&2
        exit 1
    fi
else
    echo "❌ Error: Entry file 'index.js' is missing!" >&2
    exit 1
fi

echo "=== Validations Passed. Running Tests ==="


