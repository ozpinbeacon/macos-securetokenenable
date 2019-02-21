#!/bin/bash
#
# SecureTokenEnable.sh
#
# Enable Secure Tokens for the assigned user using prompts and Jamf variables
# Set Jamf variables $4 and $5 to secure token enabled user and password respectively
#
# Created by Liam Matthews
# Created on 21-2-19

# Declares necessary variables
loggedInUser=$(stat -f%Su /dev/console)
assignedUser=$(defaults read /Users/$loggedInUser/Library/Preferences/menu.nomad.DEPNotifyUserInput.plist User\ Name | tr '[:lower:]' '[:upper:]')
studentOrStaff=$(defaults read /Users/$loggedInUser/Library/Preferences/menu.nomad.DEPNotifyUserInput.plist Position)

# Function for user password
function prompt() {
  osascript <<EOT
    tell app "System Events"
      text returned of (display dialog "$1" default answer "$2" buttons {"OK"} default button 1 with title "$(basename $0)" with hidden answer)
    end tell
EOT
}

# Calls the above function
userpwd="$(prompt 'Please enter your password:')"

# Enables secure token for specified user given previous information and passed Jamf variables
sysadminctl -adminUser $4 -adminPassword $5 -secureTokenOn $assignedUser -password $userpwd

echo "Secure token enabled for $assignedUser. User is now able to FileVault their machine."

exit 0
