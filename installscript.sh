#!/bin/bash

# INSTALL SCRIPT FOR EDUGEEK - KStephens 07/06/2018

# Set the ignored user here, we don't really want to nuke the local admin user!
SKIPUSER="admin"



# Get a list of our users in /Users - ignore some folders that are not user accounts
USERS=($(find /Users -maxdepth 1 | grep -v -e ".localized" -e "Shared" -e "Deleted Users" -e ".DS_Store" | tail +2 | awk -F "/" '{print $3}'))

# Get current logged in username
CURRENTUSER=$(stat -f %Su /dev/console)

# Get local script path
CURRENTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

echo "Starting Install..."

# Install Script
mkdir "/Library/Application Support/login/"
cp "$CURRENTPATH/login.sh" "/Library/Application Support/login/"
chmod 755 "/Library/Application Support/login/login.sh"

# Modify the defaults template user
mkdir "/System/Library/User Template/English.lproj/Library/LaunchAgents"
cp "$CURRENTPATH/com.user.loginscript.plist" "/System/Library/User Template/English.lproj/Library/LaunchAgents/"
chown -R root:wheel "/System/Library/User Template/English.lproj/Library/LaunchAgents/"
chmod -R 700 "/System/Library/User Template/English.lproj/Library/LaunchAgents/"


# Loop through existing users
for P in "${USERS[@]}"
do
	if [[ "$P" == "$SKIPUSER" ]]; then
		echo "Ignoring Set User: $SKIPUSER"
	else
		echo "Working On: $P"
		cp "$CURRENTPATH/com.user.loginscript.plist" "/Users/$P/Library/LaunchAgents/"
		chown $P:staff "/Users/$P/Library/LaunchAgents/com.user.loginscript.plist"
		chmod 644 "/Users/$P/Library/LaunchAgents/com.user.loginscript.plist"
	fi
done

echo "Finished!"


exit 0