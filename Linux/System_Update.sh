#!/bin/bash

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

# Remove unnecessary packages
echo "Removing unused packages..." >> "$LOG_FILE"
sudo apt autoremove -y >> "$LOG_FILE" 2>&1

# Clean package cache
echo "Cleaning package cache..." >> "$LOG_FILE"
sudo apt autoclean >> "$LOG_FILE" 2>&1

# Check if everything succeeded
if [ $? -eq 0 ]; then
    echo "Maintenance completed successfully at $(date)" >> "$LOG_FILE"
else
    echo "Maintenance encountered errors at $(date)" >> "$LOG_FILE"
fi

echo "----------------------------------------" >> "$LOG_FILE"