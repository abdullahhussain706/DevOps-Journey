#!/bin/bash

set -e

LOG_FILE="./update.log"

echo "Update started at $(date)" >> "$LOG_FILE"


echo "----------------------------------------" >> "$LOG_FILE"
echo "Maintenance started at $(date)" >> "$LOG_FILE"

# Update package list
echo "Updating package lists..." >> "$LOG_FILE"
sudo apt update >> "$LOG_FILE" 2>&1

# Upgrade packages
echo "Upgrading packages..." >> "$LOG_FILE"
sudo apt upgrade -y >> "$LOG_FILE" 2>&1

echo "Upgrading packages..." >> "$LOG_FILE"
sudo apt full-upgrade -y >> "$LOG_FILE" 2>&1

# Remove unnecessary packages
echo "Removing unused packages..." >> "$LOG_FILE"
sudo apt autoremove -y >> "$LOG_FILE" 2>&1

# Clean package cache
echo "Cleaning package cache..." >> "$LOG_FILE"
sudo apt autoclean >> "$LOG_FILE" 2>&1


if [ -f /var/run/reboot-required ]; then
    echo "System Reboot required"
else
    echo "No reboot required."
fi

echo "Maintenance completed successfully: $(date)"
echo "======================================"