#!/bin/bash

# this is a beta test for user managment
# be sure to ADD authorized users and admins IN THE CODE right HERE

authAdmins=("zagreus" "hades" "nyx" "persephone")
authUsers=("hypnos" "thanatos" "megaera" "eurydice" "orpheus" "sisyphus" "charon" "achilles" "dusa" "broker" "skelly" "chaos")
answer=0

# don't add admins in the authUsers. I'll automatically combine the lists

# function stuff
questionYN () {
while [ true ]; do
	read -rp "answer (y/n)" answer
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
				echo -e "it's not a hard question\n"
			else
				echo -e "please answer yes or no\n"
				let counter++
			fi
	esac
done
export answer
}

# main script
echo ""
echo "This script is a test version of user management"
echo "run at your own risk"
echo ""
echo "NOTE : This script requires going INTO THE CODE and adding an array of admins and standard users. Not doing this could LOCK YOU OUT OF THE SYSTEM. You also need to log in as root. Have you done this?"
questionYN

if [ $answer = 0 ]; then
	echo "go do that right now and come back later"
	echo ""
	exit
fi

echo "say a prayer that this works"
echo ""

allUsers=("${authAdmins[@]}" "${authUsers[@]}")
arr=($(getent passwd {1000..60000} | cut -d: -f1))

# check for unauthorized users
for VAR in "${arr[@]}"
	do
		if [[ ! " ${allUsers[*]} " =~ " $VAR " ]]; then
			deluser $VAR
		fi
	done

# check for missing users
for VAR in "${allUsers[@]}"
	do
		if [[ ! " ${arr[*]} " =~ " $VAR " ]]; then
			adduser $VAR
# this commented line will automatically add users
# echo -e "password\npassword\ntest1\ntest2\ntest3\ntest4\ntest5\nY\n" | adduser fish3 ; echo -e "\n\n"
		fi
	done

VAR=$(getent group sudo | cut -d: -f4)
arr=($(echo $VAR | tr ',' "\n"))

# check for unauthorized admins
for VAR in "${arr[@]}"
	do
		if [[ ! " ${authAdmins[*]} " =~ " $VAR " ]]; then
			deluser $VAR sudo
		fi
	done

# check for missing admins
for VAR in "${authAdmins[@]}"
	do
		if [[ ! " ${arr[*]} " =~ " $VAR " ]]; then
			adduser $VAR sudo
		fi
	done
