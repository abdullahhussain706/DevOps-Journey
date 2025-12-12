#!/bin/bash

Log_Dir="/home/muhammad-abdullah/Bash"

ERROR_PATTERN=("ERROR" "FATAL" "CRITICAL")
REPORT_FILE="/home/muhammad-abdullah/Report.txt"

echo "analyzing log files" > "$REPORT_FILE"
echo "_______________" >> "$REPORT_FILE"

echo -e "\nfound log files " >> "$REPORT_FILE"
LOG_FILES=$(find $Log_Dir -name "*.log")
echo "$LOG_FILES" >> "$REPORT_FILE"

for LOG_FILE in $LOG_FILES; do

    echo -e "\n" >> "$REPORT_FILE"
    echo "============================" >> "$REPORT_FILE"
    echo "========$LOG_FILE===========" >> "$REPORT_FILE"
    echo "============================" >> "$REPORT_FILE"

    for PATTERN in ${ERROR_PATTERN[@]}; do
        echo -e  "\nsearching $PATTERN in $LOG_FILE file" >> "$REPORT_FILE"
        grep "$PATTERN" "$LOG_FILE" >> "$REPORT_FILE"

        echo -e  "\nNumber of $PATTERN found in $LOG_FILE file" >> "$REPORT_FILE"
        grep -c "$PATTERN" "$LOG_FILE" >> "$REPORT_FILE"
    done
done

echo -e "\nLog Analysis Completed and Saved in: $REPORT_FILE"