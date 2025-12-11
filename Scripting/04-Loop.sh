#!/bin/bash

Log_Dir="/home/muhammad-abdullah/Bash"

ERROR_PATTERN=("ERROR" "FATAL" "CRITICAL")

echo "analyzing log files"
echo "_______________"

echo -e "\nfound files that are modified in last 24 hours"
LOG_FILES=$(find $Log_Dir -name "*.log")
echo "$LOG_FILES"

for LOG_FILE in $LOG_FILES; do

    echo -e  "\nsearching ${ERROR_PATTERN[0]} in $LOG_FILE file"
    grep "${ERROR_PATTERN[0]}" "$LOG_FILE"

    echo -e  "\nNumber of ${ERROR_PATTERN[0]} found in $LOG_FILE file"
    grep -c "${ERROR_PATTERN[0]}" "$$LOG_FILE"

    echo -e  "\nNumber of ${ERROR_PATTERN[1]} found in $LOG_FILE file"
    grep -c "${ERROR_PATTERN[1]}" "$LOG_FILE"

    echo -e  "\nNumber of ${ERROR_PATTERN[1]} found in s$LOG_FILE file"
    grep -c "${ERROR_PATTERN[1]}" "$LOG_FILE"

    echo -e  "\nsearching ${ERROR_PATTERN[2]} in $LOG_FILE file"
    grep "${ERROR_PATTERN[2]}" "$LOG_FILE"

    echo -e  "\nNumber of ${ERROR_PATTERN[2]} found in $LOG_FILE file"
    grep -c "${ERROR_PATTERN[2]}" "$LOG_FILE"
done

