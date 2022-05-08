#!/bin/bash

clear
echo ""
echo ""
echo "		Firefox Fix v0.0"
echo "	Firefox! Prepare to be Fixed!"
echo ""
echo ""
echo -n "Press ENTER to begin"
read

echo ""
if [ ! -x "$(command -v locate)" ]
then
	sudo apt-get install firefox
	echo ""
fi

if [ $(basename $(lsb_release -a 2> /dev/null | sed -n 's/.*ID://p')) = Debian ]
then
arr=($(ls /home))
for VAR in "${arr[@]}"
do
	cp "$PWD"/"core-files"/settings/prefs.js /home/"$VAR"/.mozilla/firefox/*default-esr/prefs.js
done
fi
echo ""
echo "		Firefox is fixed... (hopefully)"
echo ""
echo -n "Now press ENTER to go back to your pathetic lives!"
read
