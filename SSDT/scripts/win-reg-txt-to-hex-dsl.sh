#!/bin/bash

#█▀ █▄█ █▀▀ █░█ █▀▀ █░█
#▄█ ░█░ █▄▄ █▀█ ██▄ ▀▄▀

#Author: <Anton Sychev> (anton at sychev dot xyz) 
#win-reg-txt-to-hex-dsl (c) 2023 
#Created:  2023-11-22 23:29:47 
#Desc: extract PPT from reg export file and convert to hex dsl format, just simply run and copy / paste


export LC_ALL=C

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <file>"
    echo -e "\n\n-------\nSample file content: Key Name:          HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001\nClass Name:        <NO CLASS>\nLast Write Time:   05/09/2023 - 12:29\n-------\n"
    exit 1
fi

file_path=$1

if [ ! -f "$file_path" ]; then
    echo "Error: File '$file_path' not found."
    exit 1
fi

file_content=$(cat "$file_path")

PPT=""
prev_line=""

BLOCK=$(echo -e "$file_content" | grep -A 200 'PP_PhmSoftPowerPlayTable.*')

while IFS= read -r line; do
    if [[ "$line" == *"Name:"* || "$line" == *"Type:"* || "$line" == *"Data:"* ]]; then
        continue
    fi

    PPT+="$line"$'\n'  # Use $'\n' to preserve newlines

    if [[ "$prev_line" == "$line" ]]; then
        break
    fi
    
    prev_line="$line"
done <<< "$BLOCK"

formatted_content=$(echo "$PPT" | sed 's/ - / /g')

formatted_content=$(echo "$formatted_content" | sed 's/^[[:xdigit:]]\{8\}\s*//' | sed "s/   //g")
formatted_content=$(echo "$formatted_content" | sed 's/.\{47\}/&  \/\//g')
formatted_content=$(echo "$formatted_content" | sed 's/\([0-9a-fA-F]\{2\}\)/0x\1, /g')
formatted_content=$(echo "$formatted_content" | sed 's/,  \./ \/\/\./g' | sed 's/\/\/.*//g' | sed 's/  //g' | sed 's/^/\t\t/')
formatted_content=$(echo "$formatted_content" | tr -d '[:space:]') 
formatted_content=$(echo "$formatted_content" | fold -w 80 | sed 's/^/\t\t/')

printf "\t\"PP_PhmSoftPowerPlayTable\",\n\tBuffer ()\n\t{\n" 
printf "$formatted_content" 
printf "\n\t}\n"
