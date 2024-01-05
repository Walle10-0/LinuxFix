#!/bin/bash

# this script literally just runs other scripts so it should work

# variables
directory=$(dirname $0)
answer=0

# functions
run () {
	if [ -f "$directory/$1" ]; then
		bash "$directory/$1"
	fi
}

ask_q () {
counter=1
while [ true ]; do
	echo ""
	read -rp "$1 (y/n)" answer
	echo ""
	case "$answer" in
		[Yy]*)
			answer=1
			break;;
		[Nn]*)
			answer=0
			break;;
		*)
			if [ $counter -gt 3 ];then
			echo -e "you're doing this deliberately now... please stop...\n"
			else
			echo -e "please answer yes or no\n"
			let counter++
			fi
	esac
done
}


# Core script : This script has which scripts get run and which order

# Change passwords
run "PasswdHack.sh"

# User auditing
ask_q "would you like LinuxFix to attempt audit users? (recommended + configuration needed)"
if [ "$answer" = "1" ]; then
	run "AutoUsers.sh"
fi

# Purge Maleware/Hacking tools
run "BulkUninstall.sh"

# Install critical software
run "InstalLISTtion.sh"

# Settings
run "SettingsAssistant.sh"

# File permissions
run "FileLock.sh"

# Friendly Reminder
clear
echo " "
echo "IMPORTANT! all passwords have been changed. Please write them down"
echo ""
echo -n "Press ENTER to continue"
read

# View user's files
run "ServerSpy.sh"

# Remove .mp3 files
run "MP3_Murderer.sh"
