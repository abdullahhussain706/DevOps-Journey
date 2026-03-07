#!/bin/bash

Log_Dir="/home/muhammad-abdullah/Bash"

ERROR_PATTERN=("ERROR" "FATAL" "CRITICAL")

echo "analyzing log files"
echo "_______________"

echo -e "\nfound files that are modified in last 24 hours"
LOG_FILES=$(find $Log_Dir -name "*.log")
echo "$LOG_FILES"

for LOG_FILE in $LOG_FILES; do

    echo -e "\n"
    echo "============================"
    echo "========$LOG_FILE==========="
    echo "============================"

    for PATTERN in ${ERROR_PATTERN[@]}; do
        echo -e  "\nsearching $PATTERN in $LOG_FILE file"
        grep "$PATTERN" "$LOG_FILE"

        echo -e  "\nNumber of $PATTERN found in $LOG_FILE file"
        grep -c "$PATTERN" "$LOG_FILE"
    done
done

