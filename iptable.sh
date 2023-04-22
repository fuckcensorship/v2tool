#!/bin/bash

# Check if the rules already exist
if iptables -L | grep -q "ACCEPT+s*alls*--s*anywheres*anywheres*states*RELATED,ESTABLISHED"; then
  echo "IPtables rules already exist."
else
  # Set the INPUT policy to ACCEPT
  iptables -P INPUT ACCEPT
  # Set the OUTPUT policy to ACCEPT
  iptables -P OUTPUT ACCEPT
  # Set the FORWARD policy to ACCEPT
  iptables -P FORWARD ACCEPT
  # Flush all existing rules
  iptables -F
  echo "IPtables rules added successfully."
fi
