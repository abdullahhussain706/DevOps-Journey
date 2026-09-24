#!/bin/bash

set -e

LOG_FILE="./update.log"

echo "Update started at $(date)" >> "$LOG_FILE"

echo "----------------------------------------" >> "$LOG_FILE"
echo "Maintenance started at $(date)" >> "$LOG_FILE"

# Update package list
echo "Updating package lists..." >> "$LOG_FILE"
sudo apt-get update >> "$LOG_FILE" 2>&1

# Upgrade packages
echo "Upgrading packages..." >> "$LOG_FILE"
sudo apt-get upgrade -y >> "$LOG_FILE" 2>&1

echo "Dist-upgrading packages..." >> "$LOG_FILE"
sudo apt-get dist-upgrade -y >> "$LOG_FILE" 2>&1

# Remove unnecessary packages
echo "Removing unused packages..." >> "$LOG_FILE"
sudo apt-get autoremove -y >> "$LOG_FILE" 2>&1

# Clean package cache
echo "Cleaning package cache..." >> "$LOG_FILE"
sudo apt-get autoclean >> "$LOG_FILE" 2>&1

echo "Cleaning all cache..." >> "$LOG_FILE"
sudo apt-get clean >> "$LOG_FILE" 2>&1

# Check for reboot
if [ -f /var/run/reboot-required ]; then
    echo "System Reboot required"
    echo "System Reboot required" >> "$LOG_FILE"
else
    echo "No reboot required."
    echo "No reboot required." >> "$LOG_FILE"
fi

echo "Maintenance completed successfully: $(date)"
echo "Maintenance completed successfully: $(date)" >> "$LOG_FILE"
echo "======================================" >> "$LOG_FILE"