#!/bin/bash

# this script literally just runs other scripts so it should work
directory=$(dirname $0)

run () {
	if [ -f "$directory" ]; then
		bash "$directory/$1"
	fi
}

answer=0
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
run PasswdHack.sh

# User auditing
ask_q "would you like LinuxFix to attempt audit users? (recommended + beta + configuration needed)"
if [ "$answer" = "1" ]; then
	run AutoUsers.sh
fi

# Purge Maleware/Hacking tools
run HackZap.sh

# Install critical software
run SoftwareSuperman.sh

# Settings
run SettingsAssistant.sh

# File permissions
run FileLock.sh

# Firewall
ask_q "would you like LinuxFix to attempt to configure the firewall? (recommended only if you like Trump)"
if [ "$answer" = "1" ]; then
	run FirewallForger.sh
fi

# Firefox(Debian Only)
if [ $(basename $(lsb_release -a 2> /dev/null | sed -n 's/.*ID://p')) = Debian ]
then
	ask_q "would you like Linux Fix to attempt to configure firefox? (not recommended)"
	if [ "$answer" = "1" ]; then
		run FirefoxFix.sh
	fi
fi


# Friendly Reminder
clear
echo " "
echo "IMPORTANT! all passwords have been changed. Please write them down"
echo ""
echo -n "Press ENTER to continue"
read

# View user's files
run ServerSpy.sh

# Remove .mp3 files
bash $directory/"MP3_Murderer.sh"
