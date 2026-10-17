#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
INFO_FILE="$PROJECT_DIR/Toktobaev_Nooruzbek_info.txt"

STUDENT_NAME="${STUDENT_NAME:-Nooruzbek}"
STUDENT_SURNAME="${STUDENT_SURNAME:-Toktobaev}"
STUDENT_GROUP="${STUDENT_GROUP:-IT-2 2313}"
STUDENT_ID="${STUDENT_ID:-38422}"

LINE="=============================="

echo "$LINE"
echo "Student Information"
echo "$LINE"
echo "Name: $STUDENT_NAME"
echo "Surname: $STUDENT_SURNAME"
echo "Group: $STUDENT_GROUP"
echo "Student ID: $STUDENT_ID"
echo "$LINE"
echo "System Information"
echo "$LINE"
echo "Username: $(whoami)"
echo "Hostname: $(hostname)"
echo "Current Date: $(date)"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "Operating System: $PRETTY_NAME (kernel $(uname -r))"
else
    echo "Operating System: $(uname -a)"
fi
echo "Disk Usage:"
df -h /
echo "Memory Usage:"
free -h
echo "$LINE"

if [ -f "$INFO_FILE" ]; then
    echo "Student information file exists."
else
    echo "Student information file does not exist."
fi
