#!/bin/bash

source_file="/var/log/auth_log.log"
destination_file="suspicious_activity.log"

# Check if the file exists
if [[ ! -f "$destination_file" ]]; then
  touch "$destination_file"
fi


keywords=("failed" "invalid" "error" "pam" "unauthorized" "failure")

while read -r line; do
	for word in "${keywords[@]}"; do
		if echo "$line" | grep -qi "$word"; then
			echo "$line" >> "$destination_file"
			continue 2
		fi
	done

done < $source_file
 
