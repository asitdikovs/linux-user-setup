#!/bin/bash

# run script as root user 
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 
  exit 1
fi
# Variables 
LOGFILE="/var/log/user_setup.log"
DEFAULT_PASS="defaultpassword"
TMP_LOGFILE="/tmp/user_setup.log"

# Check if username was provided as an argument
if [[ -n "$1" ]]; then
  username="$1"
else
  # Ask for username input
  echo "Enter the username you want to create:"
  read -p "Username: " username
fi

# check if user with this username already exists
if id "$username" &>/dev/null; then
  echo "User '$username' already exists."
  exit 1
else
  # create user with this username, assign to default group and set default password
  useradd -m -s /bin/bash "$username"
  echo "User '$username' created successfully."
  echo "Setting default password for user '$username'."
  echo "$username:$DEFAULT_PASS" |  chpasswd
  echo "Default password set for user '$username'."
  fi 
# assign user to default group, if other group not provided
if [[ -z "$2" ]]; then
  usermod -aG users "$username"
  echo "User '$username' added to the 'users' group."
else
  group="$2"
  usermod -aG "$group" "$username"
  echo "User '$username' added to the '$group' group."
fi

# log action to a file with 'date and time' to /var/log/user_setup.log
if [[ -w $(dirname "$LOGFILE") || ! -e "$LOGFILE" ]]; then
  echo "$(date): User '$username' created with default password." |  tee -a "$LOGFILE"
  chmod 644 "$LOGFILE"
  chown root:root "$LOGFILE"
  echo "Action logged to $LOGFILE"
else
# create log file in tmp directory 
  echo "$(date): User '$username' created with default password." | tee -a "$TMP_LOGFILE"
  chmod 644 "$TMP_LOGFILE"
  chown root:root "$TMP_LOGFILE"
  echo "Action logged to temporary file $TMP_LOGFILE"
fi
# display message to user
echo "User '$username' has been created with a default password. Please change the password after logging in."
exit 0