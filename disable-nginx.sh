#!/bin/bash

# Stop Nginx service
sudo systemctl stop nginx

# Disable Nginx service
sudo systemctl disable nginx

# Confirm that Nginx is disabled
if ! systemctl is-enabled --quiet nginx ; then
    echo "Nginx disabled successfully."
else
    echo "Failed to disable Nginx."
fi
