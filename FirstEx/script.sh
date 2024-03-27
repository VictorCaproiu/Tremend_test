#!bin/bash

UID_LOWER_BOUND=1
UID_UPPER_BOUND=20

SLEEP_TIME=2



check_dir(){
	echo "Home directory content:"
	ls /home
}

names_in_passwd(){
	echo -e "\n\nUsernames in the passwd file:\n"
	sleep 1
	awk -F: '{ print $1 }' /etc/passwd
	echo -e "\n\n"
}

nr_of_users(){
	echo -e "\n\nNumber of users:"
	wc -l /etc/passwd
}

check_user_home(){
	echo -ne "\nEnter username value:"
	read user
	echo -en "This user's home directory is:   "

	grep $user /etc/passwd | awk -F: '{ print $6 }'
}

uids_in_range(){
	echo -e "\nUsers with UIDs in range $UID_LOWER_BOUND - $UID_UPPER_BOUND are:"
	awk -F: -v LOW=$UID_LOWER_BOUND -v UPP=$UID_UPPER_BOUND '$3 >= LOW && $3 <= UPP  {print $1}' /etc/passwd
}

users_with_std_shells(){
	echo -e "\nThe users with standard shells are:"	
	awk -F: '$7 ~ /(bash|sh|zsh|ksh|csh|tcsh|fish)$/ {print $1}' /etc/passwd
}

replace_slash(){
	sed 's/\//\\/g' /etc/passwd > passwd_repl
	echo -e "\nReplaced every \\ with a \/ in passwd and redirected to passwd_repl"
}

private_ip(){
	echo -e "\nThe private IP address of the system is:"
	hostname -I
}

public_ip(){
	echo -e "\nThe public IP address of the system is:"
	dig +short myip.opendns.com @resolver1.opendns.com
}

su_john(){
	su john
}

check_dir
sleep $SLEEP_TIME

names_in_passwd
sleep $SLEEP_TIME

nr_of_users
sleep $SLEEP_TIME

check_user_home
sleep $SLEEP_TIME

uids_in_range
sleep $SLEEP_TIME

users_with_std_shells
sleep $SLEEP_TIME

replace_slash
sleep $SLEEP_TIME

private_ip
sleep $SLEEP_TIME

public_ip
sleep $SLEEP_TIME

su_john
sleep $SLEEP_TIME

check_dir

