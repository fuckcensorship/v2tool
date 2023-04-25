#!/bin/bash

# Check if xray is installed
if ! [ -x "$(command -v xray)" ]; then
    echo "Xray is not installed. Installing..."
    curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-$(arch).zip -o xray.zip
    unzip xray.zip && rm xray.zip
    chmod +x xray
    mv xray /usr/local/bin/
    echo "Xray installed successfully!"
fi

# Copy config.json
if ! [ -f "/usr/local/etc/xray/config.json" ]; then
    echo "Copying config.json to /usr/local/etc/xray/..."
    mkdir -p /usr/local/etc/xray/
    cp -i ~/v2tool/xrays/ws.json /usr/local/etc/xray/config.json
    echo "config.json copied successfully!"
fi

# Restart Xray service
echo "Restarting Xray service..."
systemctl restart xray

echo "Xray started successfully!"
