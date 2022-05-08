#!/bin/bash

# This script configures various computer configuration files and works with the 'settings' folder

# -------------------- functions ---------------------------
VAR=0
ANSWER=0

ask_q () {
	while [ true ]; do
		echo ""
		echo "$1"
		read -rp "	: " VAR
		case "$VAR" in
			[Yy]* )
				echo " ";
				ANSWER=1;
				break;;
			[Nn]* )
				echo " ";
				ANSWER=0;
				break;;
			*)
				echo "ERROR";;
			esac
	done
}
error_sign () {
	echo ""
	echo -e "			\e[1;31mERROR \e[0;0m"
	echo ""
}
# paste_config command with fields 1=humanName 2=fileName 3=filePath 4=skipQuestion
paste_config () {
if [ -f "$3" ]; then
	if [ "$4" = "skip" ]; then
		ANSWER=1
	else
	ask_q "do you want to configure $1? ($3)"
	fi
	if [ $ANSWER = 1 ]; then
		echo "Here are the differences : >NEW <OLD"
		diff "$3" "$PWD/core-files/settings/$2"
		echo "---------------------------"
		ask_q "do you want to continue? (y/n)"
		if [ $ANSWER = 1 ] ; then
			echo "configuring $3"
			cp "$3" "/backup/other/$2"
			cp "$PWD/core-files/settings/$2" "$3"
		fi
	else
		echo "skipping..."
	fi
else
	echo "$3 does not exist so that's not my problem"
fi
}

# ------------------- intro ----------------------------
clear
echo ""
echo "		SettingsAssistant v1.5"
echo ""
echo "		Random cyber security stuff..."
echo ""
echo -n "press ENTER to do cyber security stuff"; read
echo ""

# ------------------- checks -----------------------------
if [ ! -d "$PWD/core-files/settings" ]; then
	error_sign
	echo "directory $PWD/core-files/settings does not exist"
	echo "are you in the LinuxFix folder?"
	exit
fi
if [ $(whoami) != "root" ]; then
	error_sign
	echo "are you root?"; echo ""
	exit
fi
if [ ! -d "/backup/other" ]; then
	if [ ! -d "/backup" ]; then
		mkdir "/backup"
	fi
	mkdir "/backup/other"
fi
# ------------------------- actual script -------------------------

# Password age  -  /etc/login.defs
paste_config "password age policies" "login.defs" "/etc/login.defs"

# password policies
ask_q "do you want to configure password complexity requirments? (pwquality) (kinda broken)"
if [ $ANSWER = 1 ]; then
#	pwquality
	echo "configuring pwquality"
	echo "		-/etc/pam.d/common-auth"
	paste_config "common-auth" "common-auth" "/etc/pam.d/common-auth" "skip"
	echo "		-/etc/pam.d/common-password"
	paste_config "common-password" "common-password" "/etc/pam.d/common-password" "skip"
	echo ""
else
	echo "skipping..."
fi

# Network Configurations
paste_config "network configurations" "sysctl.conf" "/etc/sysctl.conf"
if [ $ANSWER = 1 ]; then
	sysctl -p
fi

# sudoers
paste_config "sudoers file" "sudoers" "/etc/sudoers"

# Critical services
#ask_q "do you want to configure critical services? (Beta version)"
#if [ $ANSWER = 1 ] ; then
#	ask_q "Is OpenSSH a critical service and do you want it installed?"
#	if [ $ANSWER = 1 ] ; then
#	
#	else
#	
#	fi
#else
#	echo "skipping..."
#fi


# ---------------------- end message ----------------------------
echo ""
echo "Thank you for using SettingAssistant v1.5"
echo ""
echo "this script does not handel permissions on settings so you might want to run 'FileLock'"
echo "backups of the most recent config files have been stored in /backup/other (they will overwrite the next time you run this)"
echo ""
echo -n "press ENTER to exit"
read
echo ""

