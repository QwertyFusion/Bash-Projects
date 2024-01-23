Red=$'\e[1:31m'
Green=$'\e[1;32m'
Blue=$'\e[1;34m'

#!/bin/bash

while true
do
    clear  # Clear the terminal screen

    # Display the digital watch
    echo -n "Digital Watch: "
    echo $Blue $(date +%T)
    
    # Display the calendar
    echo -e "\nCalendar:"
    cal

    # Sleep for 1 second before updating again
    sleep 1
done

