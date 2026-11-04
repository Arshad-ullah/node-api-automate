#!/bin/bash

echo "====Check project files==="

if [[ ! -f package.json ]]; then

    echo "Package.json not found"

    exit 0
elif [[ ! -d node_modules ]]; then
    echo "node_modules not found"

    exit 0

else 
    echo "Correct everyhting..."

fi




echo "==== Check Node.js and npm ===="

npmDir=$(which npm)
nodeDir=$(which node)

echo "npm path: $npmDir"
echo "node path: $nodeDir"

if [[ ! -f "$npmDir" ]]; then
    echo "Not found npm"
    exit 1

elif [[ ! -f "$nodeDir" ]]; then
    echo "Not found node"
    exit 1

else
    echo "Node version: $(node --version)"
    echo "npm version: $(npm --version)"
fi




echo "==== Check PORT in .env ===="

if [[ ! -f ".env" ]]; then
    echo ".env file not found"
    exit 1
fi

if grep -qE '^PORT=' .env; then
    echo "PORT is configured in .env"
    
else
    echo "PORT is not configured in .env"
    exit 1
fi




npm install

node index.js


