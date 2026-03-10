#!/bin/bash

LOG_FILE="./update.log"

echo "Update started at $(date)" >> "$LOG_FILE"

sudo apt update

sudo apt upgrade -y


if [ $? -eq 0 ]; then
    echo "System updated successfully at $(date)" >> "$LOG_FILE"
else
    echo "Update failed at $(date)" >> "$LOG_FILE"
fi