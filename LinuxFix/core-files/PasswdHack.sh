#!/bin/bash

# This mini-script is to change Passwords for all users and disable the Guest account

# --------------------------- defining functions ---------------------------
# creates an ERROR sign
error_sign () {
	echo -e "\n			\e[1;31mERROR \e[0;0m\n"
	echo "	$1"
	echo ""
}

# generates a password
genPass () {
	if [ $passType = "/random" ]; then
		if (command -v apg &> /dev/null); then
			newPass=$(apg -a 0 -n 1 -m 4 -x 8)$(apg -a 1 -n 1 -m 2 -x 4)
		else
			newPass=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)
		fi
		export newPass
	fi
}

# asks a question
answer=0
ask_q () {
	counter=1
	while [ true ]; do
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

# ------------------- check if root --------------------------------------
clear
if [ $(whoami) != "root" ]
then
	error_sign "Please sign in as root to use this."
	exit
fi

# ------------------------------ Begining Message -------------------------
echo "
			PasswdHack v3.0
			
		Change Everybody's Passwords
		without permission!	;D
"
echo -ne "Press \e[1;31mENTER\e[0;0m to start changing passwords >:D"
read
#---------------------------prompt password type-------------------------
newPass="[D-f@ulT]"

echo "
         Type a new password for everybody

Examples:
   - [D-f@ulT]
   - |5g_WASD[g00d]
   - (L0v3L!nux)
   - N3wR@ssw0rd!
   - S0Rt&S3wEt

type '/random' to generate unique random passwords for everybody
type '/skip' to skip setting passwords
"
read -rp "Password: " passType
newPass=$passType

if [ $passType != "/skip" ]; then

echo "save passwords to file? leave blank if no file."
read -rp "Output File: " outFile

# ----------------------------- Password changing-------------------------
# chpasswd is in /usr/sbin/chpasswd just fyi
if [ -x "$(command -v chpasswd)" ]
then
	# This is the main password changing script
	arr=($(getent passwd {1000..60000} | cut -d: -f1))
	for VAR in "${arr[@]}"
	do
		echo ""
		genPass
		echo "$VAR:$newPass" | chpasswd
		echo "$VAR's password has been changed to $newPass"
		echo ""
		if [ -n "$outFile" ]; then
			echo -e "\n$VAR\n$newPass" >> $outFile
		fi
	done
else
# ----------------------- subscript ------------------------------
	# Iff chpasswd is not in the right directory or doesn't exist, it will give this error message
	error_sign "chpasswd is not installed or not working"
	ask_q "Would you like to try an alternate method?"

	# Now it will actually do the action
	if [ $answer = "0" ]; then
		echo "sorry things didn't work out"
		echo "stopping script..."
		echo ""
		exit
	else
		echo "trying different command..."
		arr=($(getent passwd {1000..60000} | cut -d: -f1))
		for VAR in "${arr[@]}"
		do
			echo ""
			genPass
			echo -e "$newPass\n$newPass" | passwd $VAR
			echo "$VAR's password has been changed to $newPass"
			echo ""
			if [ -n "$outFile" ]; then
				echo -e "\n$VAR\n$newPass" >> $outFile
			fi
		done
	fi
fi
fi
# ----------------------- Display Manager (Guest Account) -----------------------
ask_q "Would you like to confugure the display manager? (disabling the guest account)"

if [ $answer = "0" ]; then
	echo "alright then"
else
	echo -e "let me check what display manager you have installed\n"
echo ""
if [ -d "/etc/lightdm" ]; then
	echo "lightdm installed - configuring"
	if [ ! -f "/etc/lightdm/lightdm.conf" ]; then
		error_sign "lightdm configuration file not found"
		ask_q "Would you like to create a new configuration file?"
		if [ $answer = "0" ]; then
			echo -e "skipping lightdm...\n"
		else
			echo -e "configuring...\n"
			echo "[SeatDefaults]" > /etc/lightdm/lightdm.conf
		fi
	fi
	if [ $answer != "0" ]; then
		sudo echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
		sudo echo "greeter-show-remote-login=false" >> /etc/lightdm/lightdm.conf
		sudo echo "greeter-hide-users=true" >> /etc/lightdm/lightdm.conf
		sudo restart lightdm
	fi
fi
if [ -d "/etc/gdm3" ]; then
	echo "			WARNING!"
	echo "		gdm3 is installed"
	echo "	gdm3 is the new default display manager for Ubuntu."
	echo "	This script does not accomadate for gdm3 configurations."
	echo "	I am relatively new to it and they have more settings."
	echo "	Please ls /etc/gdm3 for configuration files."
	echo "	You may also want to cat or nano /etc/gdm3/*.conf"
	echo "			sorry :/"
	echo ""
	echo -n "press ENTER to continue"; read
fi
fi
# ------------------------ End Message ------------------------------------
echo " "
if [ $passType = "/random" ]; then
	echo -e "\e[1;31mIMPORTANT!\e[0;0m all passwords have been changed to RANDOM passwords"
	echo -e "\e[1;31mPLEASE!\e[0;0m write them down or AT LEAST copy and paste yours"
else
	echo -e "\e[1;31mIMPORTANT!\e[0;0m all passwords have been changed to $newPass"
	echo "(seriously... you might want to copy and paste it)"
fi
echo ""
echo -ne "Press \e[1;31mENTER\e[0;0m to continue"
read
