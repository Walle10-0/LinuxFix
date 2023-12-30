#!/bin/bash

# HackZap rebrand
# uninstalls all applications in BulkUnistall.config

# --------------------- intro ------------------------
clear
echo ""
echo "			BulkUninstall v1.0"
echo ""
echo "		literally just uninstall everything"
echo ""
echo -ne "Press \e[1;31mENTER\e[0;0m to start"; read
echo ""

# --------- ask for file -----------
default="$(dirname $0)/BulkUninstall.config"

echo "Please enter the name of the file lists the software you want uninstalled."
if [ -f "$default" ]; then
	echo "Leave it blank if you would like to use the default $default"
else
	echo "$default is missing or not found! The default option will fail."
fi
echo ""
read -rp "File Name : " filename
echo ""

if [ ! $filename ]; then
	filename=$default
fi

# -------------------- main script -------------------

if [ -f "$filename" ]; then
	# just run through the list and uninstall everything

	IFS=$'\n' read -rd '' -a arr < $filename
	
	for VAR in "${arr[@]}"
	do
		echo ""
		if [[ "$VAR" == '#'* ]]; then
			VAR="${VAR:1}"
			echo " $VAR"
			echo ""
		else
			echo " $VAR ::"
			sudo apt-get --purge remove "$VAR"
		fi
	done
	
	echo ""
	sudo apt-get autoremove
	
	echo ""
	echo "Software successfully destroyed"
else
	# ------ error 404 --------
	echo -e "			\e[1;31mERROR \e[0;0m"
	echo ""
	echo "The file '$filename' is missing!"
	echo "un-installation canceled."
fi

# -------------------------- outro --------------------------------

echo ""
echo -ne "Press \e[1;31mENTER\e[0;0m to exit"; read
