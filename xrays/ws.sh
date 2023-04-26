#!/bin/bash

# Check if xray is installed
if ! [ -x "$(command -v xray)" ]; then
    print_ok "Installing Xray"
    curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh | bash -s -- install
    echo "Xray Installation"

    groupadd nobody
    gpasswd -a nobody nobody
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
