#!/bin/bash

# Check if BBR is already enabled
if [[ "$(sysctl net.ipv4.tcp_congestion_control)" =~ "bbr" ]]; then
  echo "BBR is already enabled"
else
  # Enable BBR
  echo "Enabling BBR..."
  echo "net.core.default_qdisc=fq" | sudo tee -a /etc/sysctl.conf
  echo "net.ipv4.tcp_congestion_control=bbr" | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p
  echo "BBR has been enabled"
fi
