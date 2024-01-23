#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]
then
    echo "Usage: $0 <directory_to_check> <baseline_file>"
    exit 1
fi

# Get directory and baseline file paths from command-line arguments
DIRECTORY_TO_CHECK="$1"
BASELINE_FILE="$2"

# Function to initialize the baseline file with current file list and their timestamps
initialize_baseline()
{
    find "$DIRECTORY_TO_CHECK" -type f -exec stat --printf="%n %Y\n" {} + > "$BASELINE_FILE"
}

# Function to check file integrity
check_integrity() 
{
    current_file_list=$(find "$DIRECTORY_TO_CHECK" -type f -exec stat --printf="%n %Y\n" {} +)

    if [ "$current_file_list" == "$(cat "$BASELINE_FILE")" ]
    then
        echo "File integrity check passed. No changes detected."
    else
        echo "File integrity check failed. Changes detected!"
    fi
}

# Check if the baseline file exists, and initialize it if not
if [ -e "$BASELINE_FILE" ]
then
    check_integrity
else
    initialize_baseline
    echo "Baseline file created. Run the script again to check file integrity."
fi

# Monitor file system events using inotifywait
while true
do
    inotifywait -e modify,create,delete,move -r "$DIRECTORY_TO_CHECK"
    check_integrity
done

