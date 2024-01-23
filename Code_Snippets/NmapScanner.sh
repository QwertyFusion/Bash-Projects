#!/bin/bash

# Function to check if the script is run as root
check_root() 
{
    if [ "$EUID" -ne 0 ]
    then
        echo "Root Access Required"
        exit 1
    fi
}

# Function to check if the nmap command is available
check_nmap() 
{
    if ! command -v nmap &> /dev/null
    then
        echo "Error: 'nmap' command not found. Please install Nmap."
        exit 1
    fi
}

# Function to display the scan menu
display_menu() 
{
    echo "Select a Scan Type:"
    echo "1 for Aggressive"
    echo "2 for Syn"
    echo "3 for TCP"
}

# Function to perform the selected scan
perform_scan() 
{
    case $scan_type in
        1)
            nmap -A "$target_ip" -p "$port"
            ;;
        2)
            nmap -sS -O -sV "$target_ip" -p "$port"
            ;;
        3)
            nmap -sT -O -sV "$target_ip" -p "$port"
            ;;
        *)
            echo "Error: Invalid Scan Type"
            exit 1
            ;;
    esac
}

# MAIN SCRIPT

# Check if the script is run as root
check_root

# Check if nmap command is available
check_nmap

# Input IP and Port
read -p "Enter Target IP: " target_ip
read -p "Enter Target Port: " port

# Scan Type Choosing
display_menu
read -p "Choice: " scan_type

# Perform the selected scan
perform_scan

# Check if the scan was successful
if [ $? -eq 0 ]
then
    echo -e "\nScan completed successfully"
else
    echo -e "\nFailed to run Nmap scan"
fi

