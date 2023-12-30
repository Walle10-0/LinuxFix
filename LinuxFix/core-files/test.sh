#!/bin/bash

clear
echo ""
echo -n "Press ENTER to continue"
read test
echo ""

if [ ! $test ]; then
	echo "nothing"
fi

filename="$(dirname $0)/BulkUninstall.config"

#IFS=$'\n' read -rd '' -a arr <<< $(grep -o '^[^#]*' $filename)

IFS=$'\n' read -rd '' -a arr < $filename

for VAR in "${arr[@]}"
do
	if [[ "$VAR" == '#'* ]]; then
		VAR="${VAR:1}"
		echo " $VAR"
		echo ""
	else
		echo "+ $VAR +"
	fi
done
