#!/bin/bash

# Check if vnstat is installed
if ! [ -x "$(command -v vnstat)" ]; then
  echo 'vnstat is not installed. Installing...' >&2
  sudo apt-get update
  sudo apt-get install vnstat
fi

# Check if nload is installed
if ! [ -x "$(command -v nload)" ]; then
  echo 'nload is not installed. Installing...' >&2
  sudo apt-get update
  sudo apt-get install nload
fi
