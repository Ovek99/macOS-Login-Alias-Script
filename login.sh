#!/bin/bash

## ALIAS USER FOLDERS SCRIPT FOR EDUGEEK - Kstephens 07/06/2018

# Get current logged in username
CURRENTUSER=$(stat -f %Su /dev/console)

# Sleep for a bit to let Finder load
sleep 5

# Force network connect through Finder - just for jjohnsoncantell
open "smb://athena/${CURRENTUSER}"

# Start alias if ".usersetupdone" file is not found
if [ ! -e "/Users/$CURRENTUSER/.usersetupdone" ]; then

	# Move/Alias Desktop Folder
    chmod -R -N /Users/$CURRENTUSER/Desktop
    rm -rf /Users/$CURRENTUSER/Desktop
    ln -s "/Volumes/${CURRENTUSER}/Desktop" /Users/$CURRENTUSER/Desktop

    # Move/Alias Documents Folder
    chmod -R -N /Users/$CURRENTUSER/Documents
    rm -rf /Users/$CURRENTUSER/Documents
    ln -s "/Volumes/${CURRENTUSER}/Documents" /Users/$CURRENTUSER/Documents
        
    # Move/Alias Downloads Folder
    chmod -R -N /Users/$CURRENTUSER/Downloads
    rm -rf /Users/$CURRENTUSER/Downloads
    ln -s "/Volumes/${CURRENTUSER}/Downloads" /Users/$CURRENTUSER/Downloads  
 
    # Move/Alias Movies Folder
    chmod -R -N /Users/$CURRENTUSER/Movies
    rm -rf /Users/$CURRENTUSER/Movies
    ln -s "/Volumes/${CURRENTUSER}/Movies" /Users/$CURRENTUSER/Movies   
    
    # Move/Alias Music Folder
    chmod -R -N /Users/$CURRENTUSER/Music
    rm -rf /Users/$CURRENTUSER/Music
    ln -s "/Volumes/${CURRENTUSER}/Music" /Users/$CURRENTUSER/Music
    
    # Move/Alias Pictures Folder
    chmod -R -N /Users/$CURRENTUSER/Pictures
    rm -rf /Users/$CURRENTUSER/Pictures
    ln -s "/Volumes/${CURRENTUSER}/Pictures" /Users/$CURRENTUSER/Pictures  
    
    # Restart Dock/Desktop
    killall Dock
        
    # Write ".usersetupdone" file
    touch "/Users/$CURRENTUSER/.usersetupdone"
fi


exit 0
