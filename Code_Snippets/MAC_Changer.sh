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

# Function to display usage information
display_usage() 
{
    echo "Usage: $0 <interface> [new_mac]"
    echo "Example 1: $0 eth0"
    echo "Example 2: $0 eth0 00:11:22:33:44:55"
}

# Function to check if the specified network interface exists
check_interface() 
{
    if ! ip link show "$1" &> /dev/null
    then
        echo "Error: Network interface $1 not found"
        exit 1
    fi
}

# Function to generate a random MAC address
generate_random_mac() 
{
    echo '02:%02X:%02X:%02X:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256))
}

# Function to create a backup of the current MAC address
backup_mac() 
{
    current_mac=$(ip link show "$interface" | awk '/ether/ {print $2}')
    script_directory=$(dirname "$(readlink -f "$0")")
    backup_file="$script_directory/$interface.mac_backup"
    echo "Backing up current MAC address $current_mac to $backup_file"
    echo "$current_mac" > "$backup_file"
}

# Function to display network interface information
display_interface_info() 
{
    echo "Network Interface Information for $interface:"
    ip link show "$interface"
}

# Function to check if the 'ip' command is available
check_ip_command() 
{
    if ! command -v ip &> /dev/null
    then
        echo "Error: 'ip' command not found. Please install the 'iproute2' package."
        exit 1
    fi
}

# MAIN SCRIPT

# Check root privileges
check_root

# Check if the required argument is provided
if [ $# -lt 1 ] || [ $# -gt 2 ]
then
    display_usage
    exit 1
fi

# Variables
interface="$1"

# Check if the specified network interface exists
check_interface "$interface"

# Check if the 'ip' command is available
check_ip_command

# Display network interface information
display_interface_info

# Confirm with the user before making changes
read -p "Do you want to proceed? (y/n): " confirm
if [ "$confirm" != "y" ]
then
    echo "Operation canceled by user."
    exit 0
fi

# Check if a new MAC address is provided
if [ $# -eq 1 ]
then
    # Generate a random MAC address
    new_mac=$(generate_random_mac)
else
    # Use the provided MAC address
    new_mac="$2"
fi

# Backup the current MAC address
backup_mac

# Bring down the network interface
echo "Bringing down $interface..."
ip link set dev "$interface" down

# Change the MAC address
echo "Changing MAC address of $interface to $new_mac..."
ip link set dev "$interface" address "$new_mac"

# Bring up the network interface
echo "Bringing up $interface..."
ip link set dev "$interface" up

# Display current MAC address
current_mac=$(ip link show "$interface" | awk '/ether/ {print $2}')
echo "Current MAC address of $interface: $current_mac"

# Check if the MAC address change was successful
if [ "$current_mac" == "$new_mac" ]
then
    echo "MAC address change successful"
else
    echo "Failed to change MAC address"
    # Restore the previous MAC address from the backup
    echo "Restoring previous MAC address from backup"
    ip link set dev "$interface" address "$(cat "$backup_file")"
    ip link set dev "$interface" up
fi

