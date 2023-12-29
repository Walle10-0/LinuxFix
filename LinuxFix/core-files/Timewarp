#!/bin/bash

# This is a test script for backing up and restoring files

# ------------- Defining functions ---------------------
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
			echo -e "come on! we don't have all of time...\n"
			else
			echo -e "please answer yes or no\n"
			let counter++
			fi
	esac
done
}

# ---------------------- intro -------------------------
echo ""
echo "		Timewarp v0.0"
echo ""
echo "	Welcome to the time machine!"
echo "	get ready for some time warping"
echo ""
echo -n "press ENTER to begin your journey through time"; read
echo ""
if [ ! -d "/backup" ]; then
	mkdir /backup
	mkdir /backup/other
fi
# ----------------- actual script ---------------------
ask_q "would you like to create a backup?"
if [ $answer = 1 ]; then
	echo ""
	echo "	it's time to stop time!"
	echo ""
	backup=$(date -u +%y-%m-%d-%H-%M-%S)
	echo "the current time is $backup"
	echo "(Format = Year-Month-Day-Hour-Minute-Second)"
	echo "backups from this time will be stored in:"
	echo "	/backup/$backup"
	echo ""
	echo -n "press ENTER to begin backing up"; read
	mkdir /backup/$backup
	arr=($(ls /))
	arr=( “${arr[@]/backup}” )
	for VAR in "${arr[@]}"
	do
		ask_q "would you like to backup $VAR?"
		if [ $answer = 1 ]; then
			cp /$VAR/ -R /backup/$backup
			echo "$VAR has been backed up to /backup/$backup"
			echo ""
			echo -n "press ENTER to continue"; read
		fi
		echo ""
	done
else
	echo "ok cool, skipping lol"
	echo ""
fi
echo "I know the title also says 'restore' but we don't actually do that"
echo "get clickbaited lol"
echo ""
echo -n "press ENTER to travel back to the future"; read
echo "*insert back to the future theme here*"


