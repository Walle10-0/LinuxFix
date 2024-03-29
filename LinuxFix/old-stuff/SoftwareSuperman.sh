#!/bin/bash

# ------------------------ functions -------------------

graphic () {
bash $PWD/"core-files"/Graphics "$1"
}

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

# paste_config command with fields 1=humanName 2=fileName 3=filePath 4=skipQuestion
paste_config () {
if [ -f "$3" ]; then
	if [ "$4" = "skip" ]; then
		answer=1
	else
	ask_q "do you want to configure $1? ($3)"
	fi
	if [ $answer = 1 ]; then
		echo "Here are the differences : >NEW <OLD"
		diff "$3" "$PWD/core-files/settings/$2"
		echo "---------------------------"
		ask_q "do you want to continue? (y/n)"
		if [ $answer = 1 ] ; then
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

purge_ftp () {
sudo apt purge vsftpd
sudo apt purge ftp
sudo apt purge pureftpd
sudo apt purge proftpd
}

configur () {
graphic "$1"
if [ "$1" = "openssh-server" ]
then
	echo ""
	service ssh start
	service sshd start
	echo ""
	paste_config "ssh" "sshd_config" "/etc/ssh/sshd_config"
	service ssh restart
	service sshd restart
	ufw allow OpenSSH

	echo "	SSH is secure!"

elif [ $1 = "vsftpd" ]
then
	echo ""
	service vsftpd start
	paste_config "ftp" "vsftpd.conf" "etc/vsftpd.conf"
	ufw allow 21
	service vsftpd reload
	service vsftpd start

	ufw allow 20:21/tcp
	ufw allow 30000:31000/tcp

	echo ""
	echo "	FTP is secure (hopefully.........)"

elif [ $1 = apache2 ]
then
	paste_config "apache2" "apache2.conf" "/etc/apache2/apache2.conf"

elif [ $1 = samba ]
then
	echo "I don't have anything for samba... sry..."
else
	echo "whoops! something went wrong..."
fi
	graphic enter
}

# ------------------------------ intro ------------------------

graphic Superman

if [ ! -d "/backup/other" ]; then
	if [ ! -d "/backup" ]; then
		mkdir "/backup"
	fi
	mkdir "/backup/other"
fi

# ------------------- main installation script---------------------------------
arr=("libpam-pwquality" "bum" "ufw" "software-properties-gtk" "coreutils")
for VAR in "${arr[@]}"
do
	echo ""
	if [ "$VAR" = "coreutils" ]
	then
		sudo apt install --reinstall "$VAR"
	else
		sudo apt install "$VAR"
	fi
done

# ------------------ critical services (BETA) --------------------------
echo ""
ask_q "do you want to configure critical services? (Beta)"
if [ $answer = 1 ]; then
	arr=("openssh-server" "samba" "vsftpd" "apache2")
	for VAR in "${arr[@]}"
	do
		echo ""
		ask_q "do you want $VAR installed?"
		if [ $answer = 1 ]; then
			sudo apt install $VAR
			echo ""
			echo "configuring : $VAR"
			configur "$VAR"
		elif [ $answer = 0 ]; then
			if [ "$VAR" = vsftpd ] ; then
				purge_ftp
				echo ""
				echo "FTP is sneaky."
				echo "This did NOT purge all types of ftp."
				echo "Please run the FTP nuke in 'HackZap'"
				echo ""
				echo -n "press ENTER to continue"; read
			else
				sudo apt purge $VAR
			fi
		fi
	done
else
	echo "	skipping..."
fi
echo ""
echo '*superman theme plays in background*'
echo ""
echo -n "press ENTER to exit"
read
