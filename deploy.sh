#!/bin/bash

echo "====check package.json==="

if [[ ! -f package.json ]]; then

    echo "Package.json not found"

    exit 0
elif [[ ! -d node_modules ]]; then
    echo "node_modules not found"

    exit 0

else 
    echo "Correct everyhting..."

fi






