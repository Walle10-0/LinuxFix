#!/bin/bash

# This is a test (DO NOT USE ON NON LINUX!!!!!)
# Don't forget to enable the script using "chmod +x" or "bash"
# This script will go through everything and will ask you to confirm things. Don't be afraid to say no to installing malware and say no to deleting critical services
# You may need to spam enter

# $PWD/"core-files"/Graphics load

version="2.2"

if [ $(whoami) = root ]
then
	if [ $(basename "$PWD") = LinuxFix ]
	then
		chmod +x $PWD/"core-files"/*
		bash $PWD/"core-files"/Graphics.sh intro $version
		bash $PWD/"core-files"/LinuxFixCore.sh
		clear
		echo " "
		echo "Thanks for using LinuxFix v$version! The program that Fixes your Linux!"
		echo " "
		echo "it did a lot off stuff that I don't care to mention"
#		echo "note : This script installed services, deleted bad stuff, removed .mp3 files, updated the computer, changed passwords, disabled the guest account (hopefully), and reset/set the firewall"
		echo " "
		echo -ne "press \e[0;31mENTER \e[0;0mto exit"
		read
		echo ""

	else
	echo "		     ERROR"
	echo ""
	echo "you need to be in the LinuxFix folder"
	echo ""
	fi

else
	echo "		ERROR"
echo ""
	echo "you need to sign in as root"
echo ""
fi
