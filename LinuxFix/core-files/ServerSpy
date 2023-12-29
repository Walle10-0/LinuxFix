#!/bin/bash

# View user's files
clear
echo ""
echo ""
echo "		ServerSpy v2.05"
echo '	"viewing files efficiently..."'
echo ""
echo ""
echo -n "Press ENTER to begin"
read

arr=($(ls /home))
for VAR in "${arr[@]}"
do
	echo ""
	echo "$VAR's home directory :"

	arr2=($(ls /home/$VAR))
	if [[ "${arr2[@]}" == "" ]]
	then
	echo "			[[[EMPTY]]]"

	else

	ls /home/$VAR
	echo ""

	for VAR2 in "${arr2[@]}"
	do
		ls /home/$VAR/$VAR2
	done
	fi
	echo ""
	echo -n "Press ENTER to continue"
	read
done
echo ""
echo "Crontabs : (routinely run scripts)"
ls /var/spool/cron
ls /var/spool/cron/crontabs
echo ""
echo -n "Press ENTER to continue"
read

arr=($(ls /var/spool/cron/crontabs))
for VAR in "${arr[@]}"
do
	echo ""
	echo "$VAR :"
# This new thing SHOULD work... but it might not... idk
	grep "^[^#]" /var/spool/cron/crontabs/$VAR
#	sed '1,27d' /var/spool/cron/crontabs/$VAR
	echo "-----------------------------------"
	echo -n "Press ENTER to continue"
	read
done

echo ""
echo "all folders and crontabs viewed =) I hope you took notes"
echo ""
echo -n "Press ENTER to exit"
read
