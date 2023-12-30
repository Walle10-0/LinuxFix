#!/bin/bash

# Purge Maleware/Hacking tools

# --------------- functions----------------------
pEnter () {
echo ""
if [ -z "$1" ]; then
	echo -ne "press \e[5;31mENTER \e[0;0mto continue"
else
	echo -ne "press \e[5;31mENTER \e[0;0mto $1"
fi
read
}
purgeArr () {
for VAR in "${arr[@]}"
do
	echo ""
	echo " $VAR :: $1"
	sudo apt-get --purge remove "$VAR"
done
}

# --------------------- intro ------------------------
clear
echo ""
echo "	    X	X   XXX	   XXX	X  X"
echo "	    X	X  X   X  X	X X"
echo "	    XXXXX  XXXXX  X	XX  --+--"
echo "	    X	X  X   X  X	X X"
echo "	    X	X  X   X   XXX	X  X"
echo "		XXXXX	XXX   XXXX"
echo "		   XX  X   X  X   X"
echo "		  XX   XXXXX  XXXX"
echo "		 XX    X   X  X"
echo "		XXXXX  X   X  X v2.3"
echo ""
pEnter "zap your hacks"
echo ""
# --------------- short little thing ----------------
if [ -x "$(command -v locate)" ]; then
	sudo locate *backdoor*
else
	find / -name *backdoor* -print -delete
fi
	sudo apt purge netcat nc
echo ""

# -------------------- main script -------------------
# just run through the list

arr=("freeciv" "zangband" "icecast2" "minetest" "openarena" "manaplus")
purgeArr "Non work related app"
arr=("zmap" "nmap" "zenmap" "goldeneye" "wireshark" "ophcrack" "hydra-gtk" "kismet" "john" "johntheripper" "aircrack" "scanmem" "ettercap")
purgeArr "Hacking tool"
arr=("netcat" "nc" "telnet" "dnsmasq" "snmp" "nginx" "mariadb" "cups" "postfix" "bind9" "vino" "remmina" "remmina-common" "remote-login-service" "exim4" "exim4-base" "bluez" "pumpa" "amule" "gware")
purgeArr "Hackable service (check before deleting)"

echo ""

# -------------------- FTP nuke --------------------------------

# -------------------- ask question ----------------------
while [ true ]; do
	read -rp "Would you me to nuke FTP for you? (y/n) :" answer
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
# -------------------- bombs away! -----------------------
if [ $answer = 1 ]; then
	echo -e "	oh btw! seziure warning lol\n"
	echo -e "\e[1;5;7;31m[[[ begining search process ]]]\e[0;0m"
	echo "This is going to show a lot of information, but look closely because it might expose hidden ftp apps"
	pEnter
	echo ""
	find / -name *"ftp"*
	echo -e "\ntake note of the above files. It may by useful\n"
	pEnter
	echo ""
	echo -e "\e[1;5;7;31m[[[ locking nuclear missiles ]]]\e[0;0m"
	echo -e "\e[1;5;7;31m[[[ launch when ready ]]]\e[0;0m"
	pEnter
	arr=("ftp" "ftpd" "sftp" "sftpd" "vsftp" "vsftpd" "pureftp" "pureftpd" "pure-ftp" "pure-ftpd" "proftp" "proftpd" "pro-ftp" "pro-ftpd")
	for VAR in "${arr[@]}"
	do
		echo ""
		echo -e "\e[1;5;7;31m[[[ nuking :: $VAR ]]]\e[0;0m"
		sudo apt-get --purge remove "$VAR"
	done
	echo "and that's litterally every spelling of ftp I can think of..."
	echo ""
	echo -e "\e[1;5;7;31m[[[ begining tactical airstrike ]]]\e[0;0m"
	echo "bombs away!"
	pEnter
	arr=($(ls /etc | grep ftp))
	for VAR in "${arr[@]}"
	do
		echo ""
		echo -e "\e[1;5;7;31m[[[ striking :: $VAR ]]]\e[0;0m"
		sudo apt-get --purge remove "$VAR"
	done
	echo ""
	echo "I might have missed some but that's what you're here for"
	echo ""
fi

# -------------------------- outro --------------------------------

sudo apt-get autoremove

echo ""
echo "Your hacks have been zapped!"
echo "FYI - This does not check for services like apache2"
echo ""
pEnter "exit"
