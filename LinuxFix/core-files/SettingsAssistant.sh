#!/bin/bash

# This script configures various computer configuration files and works with the 'settings' folder
# it is a bit bulky but I cannot think of an intuitive way to divide settings because they are all configured similarly

# -------------------- variables ---------------------------
defaultPath="$(dirname $0)/templates"
ANSWER=0
version="v2.0"

# -------------------- functions ---------------------------
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
				echo "please answer yes or no";;
			esac
	done
}

# creates an ERROR sign
error_sign () {
	echo -e "\n			\e[1;31mERROR \e[0;0m\n"
	echo "	$1"
	echo ""
	exit
}

# paste_config command with fields 1=fileName 2=filePath
paste_config () {
	if [ -f "$2" ]; then
		echo "Here are the differences : >NEW <OLD"
		diff "$2" "$defaultPath/$1"
		echo "---------------------------"
		ask_q "do you want to continue? (y/n)"
		if [ $ANSWER = 1 ] ; then
			echo "configuring $2"
			cp "$2" "/backup/other/$1"
			cp "$defaultPath/$1" "$2"
		fi
	else
		echo "$2 does not exist so that's not my problem"
	fi
}

# ask_config command with fields 1=humanName 2=fileName 3=filePath
ask_config () {
	ask_q "do you want to configure $1? ($3)"
	if [ $ANSWER = 1 ]; then
		paste_config "$2" "$3"
	else
		echo "skipping..."
	fi
}

# ------------------- intro ----------------------------
clear
echo ""
echo "			SettingsAssistant $version"
echo ""
echo "		Setting the mood for cybersecurity..."
echo ""
echo -ne "Press \e[1;31mENTER\e[0;0m to do cyber security stuff"; read
echo ""

# ------------------- checks -----------------------------
if [ ! -d "$defaultPath" ]; then
	error_sign "directory $defaultPath does not exist"
elif [ $(whoami) != "root" ]; then
	error_sign "are you root?"
fi
if [ ! -d "/backup/other" ]; then
	if [ ! -d "/backup" ]; then
		mkdir "/backup"
	fi
	mkdir "/backup/other"
fi

# --------------- short little thing ----------------
if [ -x "$(command -v locate)" ]; then
	sudo locate *backdoor*
else
	find / -name *backdoor* -print -delete
fi
	sudo apt purge netcat nc
echo ""

# ---------- firewall ----------
sudo apt install ufw
echo " "
sudo ufw reset
sudo ufw enable
echo ""
echo "finished building a firewall, Trump would be proud!"
echo ""

# ------------------------- actual script -------------------------

# Password age  -  /etc/login.defs
ask_config "password age policies" "login.defs" "/etc/login.defs"

# password policies
ask_q "do you want to configure password complexity requirements? (pwquality) (kinda broken)"
if [ $ANSWER = 1 ]; then
#	pwquality
	echo "configuring pwquality"
	echo "		-/etc/pam.d/common-auth"
	paste_config "common-auth" "/etc/pam.d/common-auth"
	echo "		-/etc/pam.d/common-password"
	paste_config "common-password" "/etc/pam.d/common-password"
	echo ""
else
	echo "skipping..."
fi

# Network Configurations
ask_config "network configurations" "sysctl.conf" "/etc/sysctl.conf"
if [ $ANSWER = 1 ]; then
	sysctl -p
fi

# sudoers
ask_config "sudoers file" "sudoers" "/etc/sudoers"

# ------------------------- firefox fix ---------------------------
if [ $(basename $(lsb_release -a 2> /dev/null | sed -n 's/.*ID://p')) = Debian ]; then
ask_q "do you want to configure firefox? (50 50 shot it will work)"
	if [ $ANSWER = 1 ]; then
		sudo apt-get install firefox
		echo ""
		arr=($(ls /home))
		for VAR in "${arr[@]}"
		do
			paste_config "prefs.js" "/home/$VAR/.mozilla/firefox/*default-esr/prefs.js"
		done
	fi
fi

# ------------------ critical services (BETA) --------------------------
ask_q "do you want to configure critical services? (Beta)"
if [ $ANSWER = 1 ]; then
	# ssh
	ask_q "do you want ssh installed?"
	if [ $ANSWER = 1 ]; then
		sudo apt install openssh-server
		service ssh start
		service sshd start
		echo ""
		ask_config "ssh" "sshd_config" "/etc/ssh/sshd_config"
		service ssh restart
		service sshd restart
		ufw allow OpenSSH
	else
		sudo apt purge openssh-server
	fi
	
	# ftp
	ask_q "do you want ftp installed?"
	if [ $ANSWER = 1 ]; then
		sudo apt install vsftpd
		service vsftpd start
		ask_config "ftp" "vsftpd.conf" "etc/vsftpd.conf"
		ufw allow 21
		service vsftpd reload
		service vsftpd start
	
		ufw allow 20:21/tcp
		ufw allow 30000:31000/tcp
	else
		arr=("ftp" "ftpd" "sftp" "sftpd" "vsftp" "vsftpd" "pureftp" "pureftpd" "pure-ftp" "pure-ftpd" "proftp" "proftpd" "pro-ftp" "pro-ftpd")
		for VAR in "${arr[@]}"
		do
			echo ""
			echo -e "\e[1;5;7;31m[[[ nuking :: $VAR ]]]\e[0;0m"
			sudo apt-get --purge remove "$VAR"
		done
		echo "and that's litterally every spelling of ftp I can think of..."
	fi
	
	# apache2
	ask_q "do you want apache2 installed?"
	if [ $ANSWER = 1 ]; then
		sudo apt install apache2
		ask_config "apache2" "apache2.conf" "/etc/apache2/apache2.conf"
	else
		sudo apt purge apache2
	fi
else
	echo "	skipping..."
fi

# ---------------------- end message ----------------------------
echo ""
echo "Thank you for using SettingAssistant $version"
echo ""
echo "this script does not handle permissions on settings so you might want to run 'FileLock'"
echo "backups of the most recent config files have been stored in /backup/other (they will overwrite the next time you run this)"
echo ""
echo -n "Now press ENTER to go back to your pathetic lives!"
read
echo ""

