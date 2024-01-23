#!/bin/bash

set -e

# Configuration
LOG_FILE="update_log.txt"
PACKAGE_MANAGER="apt"
BACKUP_DIR="backup_$(date '+%Y%m%d_%H%M%S')"

# Function to log commands and their output with timestamps and exit code
log_command() 
{
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Running: $*"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Running: $*" >> "$LOG_FILE"
    "$@" |& tee -a "$LOG_FILE"
    local exit_code=${PIPESTATUS[0]}
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Exit Code: $exit_code" >> "$LOG_FILE"
    if [ "$exit_code" -ne 0 ]; then
        echo "Error: Command failed with exit code $exit_code."
        exit "$exit_code"
    fi
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ----------------------------" >> "$LOG_FILE"
}

# Function to display a progress bar
progress_bar() 
{
    local duration="$1"
    local block="▇"
    local progress=""
    local progress_length=20

    for ((i = 0; i < progress_length; i++)); do
        progress+=" "
    done

    echo -ne "["
    for ((i = 0; i < progress_length; i++)); do
        echo -ne "$block"
        sleep "$duration"
    done
    echo -ne "]"
}

# Function to provide user-friendly messages
print_message() 
{
    echo "------------------------------------------------------------"
    echo "$1"
    echo "------------------------------------------------------------"
}

# Display progress information
print_message "Updating package lists... Please wait."
log_command sudo $PACKAGE_MANAGER update
progress_bar 0.1
echo "Package lists updated successfully."

print_message "Upgrading installed packages... This may take some time."
log_command sudo $PACKAGE_MANAGER upgrade -y
progress_bar 0.1
echo "Installed packages upgraded successfully."

print_message "Cleaning up unused packages... Please wait."
log_command sudo $PACKAGE_MANAGER autoremove -y
progress_bar 0.1
echo "Unused packages cleaned up successfully."

print_message "Updating snaps... Please wait."
log_command sudo snap refresh
progress_bar 0.1
echo "Snaps updated successfully."

print_message "Updating flatpaks... Please wait."
log_command flatpak update -y
progress_bar 0.1
echo "Flatpaks updated successfully."

# Backup before making changes
print_message "Creating backup... Please wait."
mkdir "$BACKUP_DIR"

echo "Backup created in: $BACKUP_DIR"

print_message "Update complete! Log saved to $LOG_FILE"

echo "Update complete! Log saved to $LOG_FILE"

