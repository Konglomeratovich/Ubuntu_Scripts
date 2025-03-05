#!/bin/bash
# Cleaning the system

echo "We begin cleaning the system..."

# Removing old packages
sudo apt-get autoremove -y >> cleanup.log 2>&1

# Deleting the package cache
sudo apt-get clean >> cleanup.log 2>&1

# Deleting temporary files
sudo rm -rf /tmp/* >> cleanup.log 2>&1

echo "The cleaning is complete. The log is located in cleanup.log"