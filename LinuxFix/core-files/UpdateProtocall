#!/bin/bash

clear
echo ""
echo "		Update Protocall"
echo ""
echo -n "Press ENTER to begin updating"
read
echo ""

# how to find linux distro
#	cat /etc/*release

# how to find current sources list
#	cat /etc/apt/sources.list

if [ -d /etc/pacman.d ]
then
	sudo pacman -Syu
fi

if [ -d /etc/apt ]
then
	sudo apt update
	sudo apt upgrade
fi
echo ""
echo "		Updates Complete! (hopefully)"
echo "Updates don't normally work because the source lists need to be updated"
echo ""
echo -n "Press ENTER to continue"
read
