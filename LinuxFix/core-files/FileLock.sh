#!/bin/bash

# this script does file permissions based on FileLock.config

# ------------ intro -----------------
clear
echo ""
echo "	XXXX XXX X    XXXX   X	  XXXX XXXX X  X"
echo "	X     X  X    X	     X	  X  X X    X X"
echo "	XXXX  X  X    XXXX   X    X  X X    XX"
echo "	X     X  X    X	     X    X  X X    X X"
echo "	X    XXX XXXX XXXX   XXXX XXXX XXXX X  X"
echo "  v3.0"
echo ""
echo -ne "Press \e[1;31mENTER\e[0;0m to protect your core files"; read
echo ""

# --------- ask for file -----------
default="$(dirname $0)/FileLock.config"

echo "Please enter the name of the file you would like to use to set file permissions."
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

if [ -f "$filename" ]; then
	# ---------- change file permissions --------
	
	IFS=$'\n' read -rd '' -a arr <<< $(grep -o '^[^#]*' $filename)

	for VAR in "${arr[@]}"
	do
		target=$(echo "$VAR" | cut -d ' ' -f 2-)
		if [ -e "$target" ]; then
			chmod $VAR
		fi
	done
	echo ""
	echo "	core files are secure"
else
	# ------ error 404 --------
	echo -e "			\e[1;31mERROR \e[0;0m"
	echo ""
	echo "The file '$filename' is missing!"
	echo "file permissions have not been changed."
fi

# --------- end message ---------
echo ""
echo -ne "Press \e[1;31mENTER\e[0;0m to exit"; read
