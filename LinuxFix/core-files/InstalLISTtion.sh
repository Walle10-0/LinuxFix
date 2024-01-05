#!/bin/bash

# installs/re-installs all applications in InstalLISTtion.config

# just run through the list and install everything
instalLIST () {
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
			sudo apt install --reinstall "$VAR"
		fi
	done
	
	echo ""
	echo "Software successfully installed"
}

# shows repositories, updates package list, and asks if user wants to install updates
runUpdates () {
	echo -e "\nCurrent Repositories :: \n"
	sudo apt-cache policy
	echo -e "\nPlease note that updates and installations may break if repositories are incorrect"
	echo -ne "Press \e[1;31mENTER\e[0;0m to continue"; read
	echo ""
	sudo apt update
	echo ""
	while [ true ]; do
		read -rp "Would you like to install updates? (y/n) :" answer
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
					echo -e "come on man!\n it's a simple yes or no question!\n"
				else
					echo -e "please answer yes or no\n"
					let counter++
				fi
		esac
	done
	if [ $answer == 1 ]; then
		sudo apt full-upgrade
	fi
}

# --------------------- intro ------------------------
clear
echo ""
echo -e "			Instal\e[1;36mLIST\e[0;0mtion v1.0"
echo ""
echo -e "		instal\e[1;36mLIST\e[0;0m your installation with this list"
echo ""
echo -ne "Press \e[1;31mENTER\e[0;0m to start"; read
echo ""

# --------- ask for file -----------
default="$(dirname $0)/InstalLISTtion.config"

echo "Please enter the name of the file lists the software you want installed."
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
	runUpdates
	instalLIST
else
	# ------ error 404 --------
	echo -e "			\e[1;31mERROR \e[0;0m"
	echo ""
	echo "The file '$filename' is missing!"
	echo "installation canceled."
fi

# -------------------------- outro --------------------------------
echo ""
echo -ne "Press \e[1;31mENTER\e[0;0m to exit"; read
