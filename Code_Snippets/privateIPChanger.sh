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

# Function to check if required commands are available
check_commands() 
{
    for cmd in "$@"
    do
        if ! command -v "$cmd" &> /dev/null
        then
            echo "Error: '$cmd' command not found. Please install the required package."
            exit 1
        fi
    done
}

# Function to validate an IP address
validate_ip() 
{
    local ip=$1
    if [[ ! $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
    then
        echo "Error: Invalid IP address format: $ip"
        exit 1
    fi
}

# Function to validate a subnet mask
validate_subnet_mask()
{
    local subnet_mask=$1
    if [[ ! $subnet_mask =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
    then
        echo "Error: Invalid subnet mask format: $subnet_mask"
        exit 1
    fi
}

# Function to display usage information
display_usage()
{
    echo "Usage: $0 <interface> <ip_address> <subnet_mask> <gateway>"
    echo "Example: $0 eth0 192.168.1.2 255.255.255.0 192.168.1.1"
    exit 1
}

# MAIN SCRIPT

# Check if the script is run as root
check_root

# Check if required commands are available
check_commands ip

# Check if the required arguments are provided
if [ $# -ne 4 ]; then
    display_usage
fi

# Variables
interface=$1
ip_address=$2
subnet_mask=$3
gateway=$4

# Validate IP address format
validate_ip "$ip_address"
validate_subnet_mask "$subnet_mask"
validate_ip "$gateway"

# Bring down the network interface
echo "Bringing down $interface..."
ip link set dev "$interface" down

# Change IP address
echo "Changing IP address of $interface to $ip_address with subnet mask $subnet_mask..."
ip addr add "$ip_address/$subnet_mask" dev "$interface"

# Change default gateway
echo "Changing default gateway to $gateway..."
ip route add default via "$gateway"

# Bring up the network interface
echo "Bringing up $interface..."
ip link set dev "$interface" up

# Check if the IP address change was successful
if [ $? -eq 0 ]
then
    echo "IP address change successful"
else
    echo "Failed to change IP address"
fi

# Display current IP address
echo -e "\nCurrent IP address of $interface:"
ip addr show "$interface" | awk '/inet / {print $2}'

