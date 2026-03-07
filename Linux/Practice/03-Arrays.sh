#!/bin/bash

Log_Dir="/home/muhammad-abdullah/Bash"
APP_LOG_FILE="application.log"
SYS_LOG_FILE="system.log"
ERROR_PATTERN=("ERROR" "FATAL" "CRITICAL")

echo "analyzing log files"
echo "_______________"

echo -e "\nfound files that are modified in last 24 hours"
LOG_FILES=$(find $Log_Dir -name "*.log" -mtime -1)
echo "$LOG_FILES"

echo -e  "\nsearching errors in application.log file"
grep "${ERROR_PATTERN[0]}" "$Log_Dir/$APP_LOG_FILE"

echo -e  "\nNumber of errors found in application.log file"
grep -c "${ERROR_PATTERN[0]}" "$Log_Dir/$APP_LOG_FILE"

echo -e  "\nNumber of fatal found in application.log file"
grep -c "${ERROR_PATTERN[1]}" "$Log_Dir/$APP_LOG_FILE"

echo -e  "\nNumber of fatal found in system.log"
grep -c "${ERROR_PATTERN[1]}" "$Log_Dir/$SYS_LOG_FILE"

echo -e  "\nsearching critical in system.log"
grep "${ERROR_PATTERN[2]}" "$Log_Dir/$SYS_LOG_FILE"

echo -e  "\nNumber of critical found in system.log"
grep -c "${ERROR_PATTERN[2]}" "$Log_Dir/$SYS_LOG_FILE"


