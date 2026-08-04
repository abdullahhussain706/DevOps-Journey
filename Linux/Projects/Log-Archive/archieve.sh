#!/bin/bash


log_dir="$1"


if [ $# -eq 0 ]
then
    echo "Usage: ./archive.sh ${log_dir}"
    exit 1
else
    if [ ! -d "$log_dir" ]
    then
        echo "ERROR: Directory '$log_dir' does not exist."
        exit 1
    fi
fi

timestamp="$(date +%Y%m%d_%H%M%S)"
file_name="archives/logs_archive_${timestamp}.tar.gz"

mkdir -p "archives"

tar -czf "$file_name" "$log_dir"

if [ "$?" -eq 0 ]
then
    echo "Archived Successfully: ${file_name}"
    echo "$timestamp | Source: $log_dir | Archive: $file_name" >> archive_history.log
    exit 0
else
    echo "ERROR: Failed to create archive."
    exit 1
fi