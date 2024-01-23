#!/bin/bash

# Validate input parameters
if [ "$#" -ne 2 ]
then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

# Accept source and destination paths as arguments
source_dir="$1"
destination_dir="$2"

# Validate source directory
if [ ! -d "$source_dir" ]
then
    echo "Error: Invalid source directory."
    exit 1
fi

# Validate destination directory
if [ ! -d "$destination_dir" ]
then
    echo "Error: Invalid destination directory."
    exit 1
fi

# Ask for user confirmation
read -p "Do you want to proceed with the backup? (y/n): " choice
if [ "$choice" != "y" ]
then
    echo "Backup aborted by user."
    exit 0
fi

# Create a backup folder with the current date
backup_folder="$destination_dir/backup_$(date +'%Y%m%d_%H%M%S')"
mkdir -p "$backup_folder"

# Logging
log_file="$backup_folder/backup_log.txt"
echo "Backup started at $(date +'%Y-%m-%d %H:%M:%S')" > "$log_file"

# Copy files from source to backup folder using rsync
rsync -av --delete "$source_dir/" "$backup_folder" >> "$log_file" 2>&1

echo "Backup completed at $(date +'%Y-%m-%d %H:%M:%S')" >> "$log_file"

# Display success message
echo "Backup completed successfully. Files are stored in: $backup_folder"

