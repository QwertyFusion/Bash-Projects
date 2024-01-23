#!/bin/bash

# Function to check if the script is run as root
check_root() 
{
    if [ "$EUID" -ne 0 ]
    then
        echo "Root access required"
        exit 1
    fi
}

# Function to display usage information
display_usage() 
{
    echo "Usage: $0 <interface> <mode> [-v]"
    echo "Example: $0 wlan0 monitor"
    exit 1
}

# Function to validate the specified mode for the given interface
validate_mode() 
{
    supported_modes=$(iw list | grep -A2 "Supported interface modes" | grep -oP '(?<=\*\s)\S+')
    if [[ $supported_modes =~ $mode ]]
    then
        return 0  # Mode is valid
    else
        return 1  # Mode is not valid
    fi
}

# Function for error logging
log_error() 
{
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: $1" >> script_error.log
}

# Function to restore the original mode of the interface
restore_original_mode() 
{
    if [ -n "$original_mode" ]
    then
        echo "Restoring original mode ($original_mode) for $interface..."
        iw dev $interface set type $original_mode
    fi
}

# Function to display detailed information during execution (verbose mode)
verbose_output() 
{
    echo "Verbose Mode:"
    echo " - Current interface mode: $(iwconfig $interface | awk '/Mode/ {print $4}')"
    echo " - Supported modes: $(iw list | grep -A2 "Supported interface modes" | grep -oP '(?<=\*\s)\S+')"
}

# MAIN SCRIPT

# Check root privileges
check_root

# Check if the required arguments are provided
if [ $# -lt 2 ] || [ $# -gt 3 ]
then
    display_usage
fi

# Parse command line options
while getopts ":v" opt
do
    case $opt in
        v)
            verbose="true"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            display_usage
            ;;
    esac
done

# Remove parsed options
shift $((OPTIND-1))

# Variables
interface=$1
mode=$2
verbose=${verbose:-"false"}  # Default to non-verbose mode

# Validate the specified mode
if ! validate_mode
then
    echo "Error: Invalid mode '$mode' for $interface"
    log_error "Invalid mode '$mode' for $interface"
    exit 1
fi

# Store the original mode of the interface
original_mode=$(iwconfig $interface | awk '/Mode/ {print $4}')

# Bring down the interface
ifconfig $interface down

# Change monitor mode
echo "Changing $interface to $mode mode..."
iw dev $interface set type $mode

# Check if the mode change was successful
if [ $? -eq 0 ]
then
    echo "Mode change to $mode successful"
else
    echo "Failed to change mode to $mode"
    log_error "Failed to change mode to $mode for $interface"
    restore_original_mode
    exit 1
fi

# Bring up the interface
ifconfig $interface up

# Display the mode change success information
if [ "$verbose" == "true" ]
then
    verbose_output
fi
