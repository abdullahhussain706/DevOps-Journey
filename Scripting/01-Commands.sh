#!/bin/bash


echo "analyzing log files"
echo "_______________"

echo -e "\nfound files that are modified in last 24 hours"
find . -name "*.log" -mtime -1 

echo -e  "\nsearching errors in application.log file"
grep "ERROR" application.log

echo -e  "\nNumber of errors found in application.log file"
grep -c "ERROR" application.log

echo -e  "\nNumber of fatal found in application.log file"
grep -c "FATAL" application.log

echo -e  "\nNumber of fatal found in system.log"
grep -c "FATAL" system.log

echo -e  "\nsearching critical in system.log"
grep "CRITICAL" system.log

echo -e  "\nNumber of critical found in system.log"
grep -c "CRITICAL" system.log

