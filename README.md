# Bash Projects
<p align="center">
  <img src="https://raw.github.com/QwertyFusion/Bash-Projects/master/Images/thumbnail.png" alt="++10 Bash Projects by Rishi Banerjee"/>
</p>
<p align="center">This repository contains a collection of Bash scripts that serve various purposes, from network configuration and monitoring to system administration tasks. Each script is designed to be informative, modular, and ready for use in different scenarios.</p>

## Table of Contents

1. [**Backup Script**](Code_Snippets/backupScript.sh)
   - **Input Validation:** Validates command-line arguments and checks the existence of source and destination directories.
   - **Backup Execution:** Confirms user intent, creates a timestamped backup folder, logs the backup process, and uses rsync to copy files with deletion synchronization.
   - **Logging and Output:** Records start and completion times in a log file, displays success messages, and informs the user about the location of the backup.

2. [**File Integrity Checker Script**](Code_Snippets/fileIntegrityChecker.sh)
   - **Initialization and Validation:** Validates command-line arguments, initializes a baseline file with filenames and timestamps if it doesn't exist.
   - **File Integrity Check:** Compares the current file list in a specified directory with the baseline file to detect changes in file integrity.
   - **Real-time Monitoring:** Utilizes inotifywait to continuously monitor file system events (modify, create, delete, move) in the specified directory, triggering the integrity check on any detected change.

3. [**MAC Address Changer Script**](Code_Snippets/MAC_Changer.sh)
   - **Root Validation and Usage Information:** Ensures the script is run with root privileges, displays usage information if arguments are incorrect.
   - **Network Interface and MAC Address Handling:** Verifies the specified interface, checks 'ip' command availability, manipulates MAC addresses, and creates backups.
   - **User Confirmation and Status Display:** Confirms user intent, brings down and up the network interface, displays current MAC address, and confirms the success of the MAC address change, with restoration on failure.

4. [**Monitor Mode Change Script**](Code_Snippets/monitorChangeMode.sh)
   - **Root Validation and Usage Information:** Ensures script is run with root privileges, displays usage information if arguments are incorrect.
   - **Mode Change and Validation:** Validates specified mode for a given interface, logs errors, and restores original mode on failure.
   - **Verbose Output and Success Information:** Optionally provides verbose output, displaying detailed information about the mode change success.

5. [**Nmap Scanner Script**](Code_Snippets/NmapScanner.sh)
   - **Root and Dependency Check:** Ensures script runs with root privileges and checks for the availability of the 'nmap' command.
   - **User Input and Scan Type Selection:** Takes user input for target IP and port, displays a menu for choosing a scan type, and reads the user's selection.
   - **Nmap Scan Execution and Result Handling:** Executes the selected scan type using 'nmap', checks for success, and displays corresponding messages.

6. [**Digital Watch Script**](Code_Snippets/digitalWatch.sh)
   - **Color Definitions:** ANSI escape codes define color variables (Red, Green, Blue) for formatting text in the terminal.
   - **Main Loop and Display:** Infinitely updates the terminal display with a digital watch showing the current time in blue and a calendar using ANSI escape codes.
   - **Update Interval:** Sleeps for 1 second between updates to create a continuously refreshing display.

7. [**Network Monitor Script**](Code_Snippets/networkMonitor.sh)
   - **Configurable Parameters and Functions:** Sets configurable parameters (sleep interval, ping count) and defines functions to check connectivity, measure latency, measure bandwidth, display real-time stats, and generate a network report.
   - **Real-Time Statistics Display:** Infinitely updates and clears the terminal, showing real-time network stats, including connectivity status, latency, and bandwidth, with a specified sleep interval.
   - **User Interaction and Main Menu:** Presents a menu allowing the user to choose between displaying real-time stats or generating a network report, executing the selected option using a case statement.

8. [**Password Manager Script**](Code_Snippets/passwordManager.sh)
   - **Password Management Functions:** Functions to generate, store, retrieve, and update passwords with site and username information in a CSV file.
   - **Interactive User Menu:** Presents a menu for users to generate, store, retrieve, or update passwords interactively; loops until the user chooses to exit.
   - **User Input Handling:** Gathers user input for password-related operations, providing feedback on password generation, storage, retrieval, or update actions.

9. [**Private IP Changer Script**](Code_Snippets/privateIPChanger.sh)
   - **Root and Dependency Check:** Ensures script runs with root privileges and checks for the availability of the 'ip' command.
   - **Network Configuration:** Validates and configures IP address, subnet mask, and default gateway for a specified network interface, displaying success or failure messages.
   - **Current IP Display:** Shows the current IP address of the specified interface after the change, providing essential feedback on the configuration outcome.

 10. [**System Monitoring Script**](Code_Snippets/systemMonitor.sh)
     - **User Input and Log Configuration:** Prompts the user for a log file path, creates the directory, and sets thresholds for CPU, memory, disk, and network monitoring.
     - **Monitoring Functions:** Defines functions to continuously monitor CPU usage, memory consumption, disk space, and network activity, logging messages when thresholds are exceeded.
     - **Continuous Monitoring Loop:** Runs an infinite loop, executing monitoring functions at regular intervals and logging messages based on the defined thresholds. Adjust the SLEEP_DURATION variable for desired monitoring frequency.
     
 11. [**System Update Script**](Code_Snippets/systemUpdateEnhanced.sh)
     - **Configuration and Error Handling:** Sets up configuration variables, including the log file, package manager, and backup directory. Enforces script exit on error (set -e) for improved error handling.
     - **Logging and Execution Functions:** Implements log_command for detailed command logging with timestamps and exit codes. Displays a user-friendly progress bar during package management tasks.
     - **Package Management and Update Process:** Updates package lists, upgrades installed packages, cleans up unused packages, and updates snaps and flatpaks. Creates a backup directory, logs the update process, and provides progress information and user-friendly messages.

## Usage

### Prerequisites

1. **Bash:** Ensure that Bash is installed on your system.

   ```bash
   sudo apt-get update
   sudo apt-get install bash
   ```
2. **Text Editor (Optional):** You may want to use a text editor like Gedit for editing the scripts.
   ```bash
   sudo apt-get install gedit
   ```
3. Each script includes usage instructions within its code or README section. To run a script:
   ```bash
   bash script-name.sh
   ```

## License
This project is licensed under the [MIT License](LICENSE).
Feel free to explore, utilize, and modify these scripts as needed. Contributions and feedback are encouraged and appreciated.

## Programming tools used:-
<p align="left">
<a href="https://ubuntu.com" target="_blank" rel="noreferrer"> <img src="https://www.shareicon.net/download/2015/09/17/102458_ubuntu.svg" alt="Ubuntu" width="40" height="40"/> </a>
<a href="https://help.gnome.org/users/gedit/stable/" target="_blank" rel="noreferrer"> <img src="https://github.com/QwertyFusion/Bash-Projects/assets/60546350/c3848c78-f159-4c25-b027-2376a5b5abf9" alt="Gedit" width="60" height="40"/> </a>
</p>

## Programming languages used:-
<p align="left">
<a href="https://www.gnu.org/software/bash/" target="_blank" rel="noreferrer"> <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Bash_Logo_Colored.svg/2048px-Bash_Logo_Colored.svg.png" alt="Bash" width="40" height="40"/> </a> 
<a href="https://www.linux.org" target="_blank" rel="noreferrer"> <img src="https://cdn-icons-png.flaticon.com/512/518/518713.png" alt="Linux" width="40" height="40"/> </a>
</p>

## Developer
*   [@QwertyFusion](https://github.com/QwertyFusion)
