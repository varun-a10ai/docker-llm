#!/bin/bash

# Define Node.js version to be installed
NODE_VERSION="18.17.1"

# Download the Node.js binary tarball
curl -O "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz"

# Extract the binary tarball
tar -xf "node-v$NODE_VERSION-linux-x64.tar.xz"

# Optionally, move the extracted files to /usr/local
sudo mv "node-v$NODE_VERSION-linux-x64" /usr/local

# Set up symlinks to node and npm binaries to be accessible system-wide
sudo ln -s "/usr/local/node-v$NODE_VERSION-linux-x64/bin/node" /usr/local/bin/
sudo ln -s "/usr/local/node-v$NODE_VERSION-linux-x64/bin/npm" /usr/local/bin/
sudo ln -s "/usr/local/node-v$NODE_VERSION-linux-x64/bin/npx" /usr/local/bin/

# Check Node.js version
node -v

# Check npm version
npm -v

echo "Node.js and npm have been installed successfully!"


