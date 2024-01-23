#!/bin/bash

# Function to generate a random password
generate_password() 
{
    local length=$1
    tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c $length
}

# Function to store a password
store_password() 
{
    local site=$1
    local username=$2
    local password=$3

    echo "$site,$username,$password" >> passwords.csv
    echo "Password for $site stored successfully."
}

# Function to retrieve a password
retrieve_password() 
{
    local site=$1
    local username=$2

    local password=$(grep "^$site,$username," passwords.csv | cut -d',' -f3)

    if [ -n "$password" ]
    then
        echo "Password for $site ($username): $password"
    else
        echo "Password not found for $site ($username)."
    fi
}

# Function to update a password
update_password() 
{
    local site=$1
    local username=$2
    local new_password=$3

    sed -i "/^$site,$username,/s/[^,]*\$/$new_password/" passwords.csv

    if [ $? -eq 0 ]
    then
        echo "Password for $site ($username) updated successfully."
    else
        echo "Failed to update password for $site ($username)."
    fi
}

# Menu for user interaction
while true
do
    echo "1. Generate Password"
    echo "2. Store Password"
    echo "3. Retrieve Password"
    echo "4. Update Password"
    echo "5. Exit"
    read -p "Select an option (1-5): " option

    case $option in
        1)
            read -p "Enter password length: " length
            password=$(generate_password $length)
            echo "Generated Password: $password"
            ;;
        2)
            read -p "Enter site: " site
            read -p "Enter username: " username
            read -s -p "Enter password: " password
            echo
            store_password $site $username $password
            ;;
        3)
            read -p "Enter site: " site
            read -p "Enter username: " username
            retrieve_password $site $username
            ;;
        4)
            read -p "Enter site: " site
            read -p "Enter username: " username
            read -s -p "Enter new password: " new_password
            echo
            update_password $site $username $new_password
            ;;
        5)
            echo "Exiting the password manager."
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose a number between 1 and 5."
            ;;
    esac
done

