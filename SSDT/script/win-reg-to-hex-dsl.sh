#!/bin/bash

#█▀ █▄█ █▀▀ █░█ █▀▀ █░█
#▄█ ░█░ █▄▄ █▀█ ██▄ ▀▄▀

#Author: <Anton Sychev> (anton at sychev dot xyz) 
#win-reg-dump-TXT-to-hex-dsl.sh (c) 2023 
#Created:  2023-11-22 23:29:47 
#Desc: extract PPT from reg export file and convert to hex dsl format just simply run and copy and paste


export LC_ALL=C

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <file>"
    echo -e "\n\n-------\nSample file content: Windows Registry Editor Version 5.00\n\n[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001]\n\"DriverDesc"="AMD Radeon RX 6900 XT\"\n\"ProviderName\"=\"Advanced Micro Devices, Inc.\"\n\"DriverDateData\"=hex:00,00,61,20,9d,ba,d9,01\"\n-------\n"
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

BLOCK=$(echo -e "$file_content" | grep -A 200 '\"PP_PhmSoftPowerPlayTable\"=hex:.*')

while IFS= read -r line; do
    if [[ "$line" == *"["* ]]; then
        break
    fi
    
    PPT+="$line"$'\n'  # Use $'\n' to preserve newlines
    prev_line="$line"
done <<< "$BLOCK"

formatted_content=$(echo "$PPT" | sed 's/  //g' | sed 's/\"PP_PhmSoftPowerPlayTable\"\=hex\://g' | sed 's/\,\\/,/g' | sed 's/\,//g')
formatted_content=$(echo "$formatted_content" | sed 's/\([0-9a-fA-F]\{2\}\)/0x\1 ,/g' | sed 's/\n|\r\n//g')
formatted_content=$(echo "$formatted_content" | tr -d '[:space:]') 
formatted_content=$(echo "$formatted_content" | sed 's/,$//' | fold -w 80 )

echo "\"PP_PhmSoftPowerPlayTable\","
echo -e "\tBuffer ()"
echo -e "\t{"
echo -e "$formatted_content"
echo -e "\t}\n"