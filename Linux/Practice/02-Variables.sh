#!/bin/bash

Log_Dir="/home/muhammad-abdullah/Bash"
APP_LOG_FILE="application.log"
SYS_LOG_FILE="system.log"

echo "analyzing log files"
echo "_______________"

echo -e "\nfound files that are modified in last 24 hours"
find $Log_Dir -name "*.log" -mtime -1 

echo -e  "\nsearching errors in application.log file"
grep "ERROR" "$Log_Dir/$APP_LOG_FILE"

echo -e  "\nNumber of errors found in application.log file"
grep -c "ERROR" "$Log_Dir/$APP_LOG_FILE"

echo -e  "\nNumber of fatal found in application.log file"
grep -c "FATAL" "$Log_Dir/$APP_LOG_FILE"

echo -e  "\nNumber of fatal found in system.log"
grep -c "FATAL" "$Log_Dir/$SYS_LOG_FILE"

echo -e  "\nsearching critical in system.log"
grep "CRITICAL" "$Log_Dir/$SYS_LOG_FILE"

echo -e  "\nNumber of critical found in system.log"
grep -c "CRITICAL" "$Log_Dir/$SYS_LOG_FILE"


