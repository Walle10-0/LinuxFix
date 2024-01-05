#!/bin/bash

# This script removes all ".mp3" files

# Begining Message
clear
echo ""
echo "		The MP3 Murderer :"
echo "			: DOWN WITH MP3s!"
echo ""
answer=0
counter=1
while [ true ]; do
	read -rp "do you want to terminate all MP3 files? (y/n)" answer
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
			echo -e "do you think this is funny?\n"
			else
			echo -e "I have MP3s to destroy... just answer y/n\n"
			let counter++
			fi
	esac
done
}
if [ $answer = 1 ]; then
	# Check of "locate" command exists
	if [ -x "$(command -v locate)" ]
	then
		# actually destroy MP3 files
		sudo updatedb
		sudo locate -0 --regex ".*\.mp3$" | xargs -t0 sudo rm
	else
		# iff locate is not found... try "find" command
		echo ""
		echo "	locate command not found..."
		echo "	...attempting alternate method..."
		echo ""
		find / -name *.mp3 -print -delete
		echo ""
		echo "hopefully that worked better"
	fi
	
	# End Message
	echo ""
	echo "MP3s Terminated!"
else
	echo "MP3s not terminated"
	echo -e "\n lol"
echo ""
echo -n "Press ENTER to continue"
read
