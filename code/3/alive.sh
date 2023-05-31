#!/usr/bin/bash

input=$1

# Validate input   
if [[ $input != *.*.*.*-*.*.*.* ]]; then
    echo "Invalid input. Please enter in the format of 'ipv4-ipv4'"
    exit
fi

# Split IP addresses   
ip1=$(echo $input | cut -d'-' -f1)  
ip2=$(echo $input | cut -d'-' -f2)  

# Validate octets 
for ip in $ip1 $ip2; do
    oct1=$(echo $ip | cut -d. -f1)
    oct2=$(echo $ip | cut -d. -f2)
    oct3=$(echo $ip | cut -d. -f3)
    oct4=$(echo $ip | cut -d. -f4)
    for oct in $oct1 $oct2 $oct3 $oct4; do
        if [[ oct -gt 255 || oct -lt 0 ]]; then 
            echo "Invalid IP address!"
            exit 
        fi
    done

done

ip_lower="1"
ip_upper="2"
# Compare IP addresses
if [[ $ip1 < $ip2 ]]; then
    ip_lower=$ip1
    ip_upper=$ip2
elif [[ $ip2 < $ip1 ]]; then
    ip_lower=$ip2
    ip_upper=$ip1
else 
    ip_lower=$ip1
    ip_upper=$ip2
fi

ip_lower_num=$(echo $ip_lower | awk -F. '{ print $1*256*256*256 + $2*256*256 + $3*256 + $4 }')
ip_upper_num=$(echo $ip_upper | awk -F. '{ print $1*256*256*256 + $2*256*256 + $3*256 + $4 }')

for i in $(seq $ip_lower_num $ip_upper_num); do
    ip=$(echo $i | awk '{printf "%d.%d.%d.%d\n", $1/256/256/256,$1/256/256%256,$1/256%256,$1%256}')
        ping -c2 $ip &> /dev/null
    if [ $? = 0 ]; then
    echo "$ip is UP"
    else
    echo "$ip is DOWN"
    fi
done