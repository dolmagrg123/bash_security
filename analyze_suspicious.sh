#!/bin/bash

#declare the source file where we will check
source_file="/var/log/auth_log.log"

#declare the destination path of the file where we will copy the lines  with suspicious words
destination_path="/home/ubuntu/bash_security"
#create path if it does not exists
mkdir -p "$destination_path" 

#words that are suspicious in the log file
keywords=("failed" "invalid" "error" "pam" "unauthorized" "failure")

#use while loop to read each line
while read -r line; do
	for word in "${keywords[@]}"; do #check each word in the list
		if echo "$line" | grep -qi "$word"; then # check for each word in line ignoring case
			cd "$destination_path"
			echo "$line" >> "suspicious_activity.log" #copy the line with suspicious word to our file
			continue 2 #move to next line if any word is found to avoid copying same line twice
		fi
	done

done < $source_file
 
