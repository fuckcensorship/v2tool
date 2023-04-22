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
    curl -LJO https://github.com/fuckcensorship/v2tool/raw/main/xray/ws.json
    mkdir -p /usr/local/etc/xray/
    cp -i ./config.json /usr/local/etc/xray/
    echo "config.json copied successfully!"
fi

# Restart Xray service
echo "Restarting Xray service..."
systemctl restart xray

echo "Xray started successfully!"
