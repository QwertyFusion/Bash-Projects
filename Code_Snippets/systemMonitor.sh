#!/bin/bash

SLEEP_DURATION=60  # Adjust the sleep duration based on your monitoring frequency

# Ask the user for the log file path
read -p "Enter the path for log files (e.g., /var/log/system_monitor): " LOG_DIR
mkdir -p "$LOG_DIR"

# Set the threshold values for resource monitoring
CPU_THRESHOLD=80      # Set the CPU usage threshold in percentage
MEMORY_THRESHOLD=80   # Set the memory usage threshold in percentage
DISK_THRESHOLD=90     # Set the disk space usage threshold in percentage
NETWORK_THRESHOLD=100  # Set the network activity threshold in KB/s

# Function to get the current timestamp
get_timestamp() 
{
    date "+%Y-%m-%d %H:%M:%S"
}

# Function to log messages
log_message()
{
    echo "[$(get_timestamp)] $1" >> "$LOG_DIR/system_monitor.log"
}

# Function to monitor CPU usage
monitor_cpu()
{
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')
    if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]
    then
        log_message "High CPU usage detected: $cpu_usage%"
    fi
}

# Function to monitor memory consumption
monitor_memory() 
{
    local memory_usage=$(free | awk '/Mem:/ {print int($3/$2 * 100)}')
    if [ "$memory_usage" -gt "$MEMORY_THRESHOLD" ]
    then
        log_message "High memory usage detected: $memory_usage%"
    fi
}

# Function to monitor disk space
monitor_disk()
{
    local disk_usage=$(df -h | awk '$NF=="/" {print int($5)}')
    if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]
    then
        log_message "High disk space usage detected: $disk_usage%"
    fi
}

# Function to monitor network activity
monitor_network() 
{
    local network_usage=$(ifstat -q 1 1 | tail -n 1 | awk '{print $1}')
    if [ "$network_usage" -gt "$NETWORK_THRESHOLD" ]
    then
        log_message "High network activity detected: $network_usage KB/s"
    fi
}

# Main monitoring loop
while true
do
    monitor_cpu
    monitor_memory
    monitor_disk
    monitor_network
    sleep $SLEEP_DURATION
done

