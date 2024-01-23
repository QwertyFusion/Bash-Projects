#!/bin/bash

# Network monitoring script

# Configurable parameters
SLEEP_INTERVAL=5
PING_COUNT=5

# Function to check internet connectivity
check_connectivity() 
{
  ping -c 1 google.com > /dev/null 2>&1
  return $?
}

# Function to measure latency
measure_latency() 
{
  ping -c $PING_COUNT google.com | tail -1 | awk '{print "Latency:", $4 " ms"}'
}

# Function to measure bandwidth
measure_bandwidth() 
{
  speedtest-cli --simple
}

# Function to display real-time statistics
display_realtime_stats() 
{
  while true
  do
    clear
    echo "==== Real-Time Network Statistics ===="
    
    # Check internet connectivity
    if check_connectivity
    then
      echo "Internet Connectivity: Connected"
      measure_latency
      measure_bandwidth
    else
      echo "Internet Connectivity: Disconnected"
    fi

    sleep $SLEEP_INTERVAL
  done
}

# Function to generate a report
generate_report() 
{
  echo "==== Network Report ===="
  
  # Check internet connectivity
  if check_connectivity
  then
    echo "Internet Connectivity: Connected"
    measure_latency
    measure_bandwidth
  else
    echo "Internet Connectivity: Disconnected"
  fi
}

# Main menu
echo "1. Display Real-Time Statistics"
echo "2. Generate Network Report"
read -p "Choose an option (1/2): " option

case $option in
  1)
    display_realtime_stats
    ;;
  2)
    generate_report
    ;;
  *)
    echo "Invalid option. Exiting."
    ;;
esac
