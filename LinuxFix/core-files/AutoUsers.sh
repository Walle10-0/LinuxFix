#!/bin/bash

# this script does automatic user management
# be sure to ADD authorized users and admins in Admins.config and Users.config
# if you lock yourself out of your system, that's not my fault

# ----------- variables ------------------
defaultUsers="$(dirname $0)/Users.config"
defaultAdmins="$(dirname $0)/Admins.config"
answer=0

# ------------ function stuff ----------------
questionYN () {
counter=0
while [ true ]; do
	read -rp "answer (y/n)" answer
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
				echo -e "it's not a hard question\n"
			else
				echo -e "please answer yes or no\n"
				let counter++
			fi
	esac
done
export answer
}

# 1=message 2=defaultValue
askForFile () {
	echo "Please enter the name of the file $1"
	if [ -f "$2" ]; then
		echo "Leave it blank if you would like to use the default $2"
	else
		echo "$2 is missing or not found! The default option will fail."
	fi
	echo ""
	read -rp "File Name : " answer
	echo ""
	
	if [ ! $answer ]; then
		answer=$2
	fi
	
	if [ ! -f "$answer" ]; then
		error_sign "The file $answer is missing!"
	fi
}

# creates an ERROR sign
error_sign () {
	echo ""
	echo -e "			\e[1;31mERROR \e[0;0m"
	echo ""
	echo "	$1"
	echo ""
	echo -ne "Press \e[1;31mENTER\e[0;0m to exit"; read
	exit
}

# check for root
if [ $(whoami) != "root" ]
then
	error_sign "Please sign in as root to use this."
fi

# ------------------- intro ----------------------------
clear
echo ""
echo "			AutoUsers v2.0"
echo ""
echo "		fixing all your user problems"
echo ""
echo -ne "Press \e[1;31mENTER\e[0;0m to start"; read
echo ""
echo "This script will automatically add and delete users"
echo "It requires that you create 2 lists, one of authorized users and another of authorized admins"
echo "Not doing this or incorrectly configuring the list could LOCK YOU OUT OF THE SYSTEM."
echo "Run at your own risk."
echo ""
echo "Would you like to continue?"
questionYN

if [ $answer = 0 ]; then
	echo "ok bye"
	echo ""
	exit
fi

# ----------------- ask for files + more checks -----------------
askForFile "that lists all the authorized admins" $defaultAdmins
IFS=$'\n' read -rd '' -a authAdmins <<< $(grep -o '^[^#]*' $answer)

if [ ! ${authAdmins[@]} ]; then
	error_sign "List of authorized admins is empty. Please add at least 1 admin."
fi

askForFile "that lists all the authorized users" $defaultUsers
IFS=$'\n' read -rd '' -a authUsers <<< $(grep -o '^[^#]*' $answer)

# ---------------- user auditing  ---------------------
allUsers=("${authAdmins[@]}" "${authUsers[@]}")
arr=($(getent passwd {1000..60000} | cut -d: -f1))

# check for unauthorized users
for VAR in "${arr[@]}"
	do
		if [[ ! " ${allUsers[*]} " =~ " $VAR " ]]; then
			deluser $VAR
		fi
	done

# check for missing users
for VAR in "${allUsers[@]}"
	do
		if [[ ! " ${arr[*]} " =~ " $VAR " ]]; then
			adduser $VAR
			# this commented line will automatically add users (no user prompts)
			# echo -e "password\npassword\ntest1\ntest2\ntest3\ntest4\ntest5\nY\n" | adduser fish3 ; echo -e "\n\n"
			arr+=("$VAR")
		fi
	done

# fetch admins
VAR=$(getent group sudo | cut -d: -f4)
arr=($(echo $VAR | tr ',' "\n"))

# check for unauthorized admins
for VAR in "${arr[@]}"
	do
		if [[ ! " ${authAdmins[*]} " =~ " $VAR " ]]; then
			deluser $VAR sudo
		fi
	done

# check for missing admins
for VAR in "${authAdmins[@]}"
	do
		if [[ ! " ${arr[*]} " =~ " $VAR " ]]; then
			adduser $VAR sudo
			arr+=("$VAR")
		fi
	done

echo ""
echo "Users and admins have been updated to match list"
echo ""
echo -ne "Press \e[1;31mENTER\e[0;0m to exit"; read
