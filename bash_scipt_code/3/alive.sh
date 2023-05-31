#!/usr/bin/bash

# Validate the number of arguments
if [ "$#" -ne 1 ]; then
    echo "Invalid argument. the argument should be in the format of \"ipv4-ipv4\" , for example \"172.29.5.12\""
    exit
  exit 1
fi


# Validate the format of the argument
if [[ $1 != *.*.*.*-*.*.*.* ]]; then
    echo "Invalid argument. the argument should be in the format of \"ipv4-ipv4\" , for example \"172.29.5.12\""
    exit
fi

# Split argument into two ip address's
ip1=$(echo $1 | cut -d'-' -f1)  
ip2=$(echo $1 | cut -d'-' -f2)  

# Validate octets is in range [0 , 255] which is the possible values of an octet
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
# declare varibles to contain the lower/upper bound of the ipv4 address's range
ip_lower_bound="1"
ip_upper_bound="2"

# assigne the correct bounds
if [[ $ip1 < $ip2 ]]; then
    ip_lower_bound=$ip1
    ip_upper_bound=$ip2
elif [[ $ip2 < $ip1 ]]; then
    ip_lower_bound=$ip2
    ip_upper_bound=$ip1
else 
    ip_lower_bound=$ip1
    ip_upper_bound=$ip2
fi

# declare varibles with the binary value of the ipv4 address's
ip_lower_bound_num=$(echo $ip_lower_bound | awk -F. '{ print $1*256*256*256 + $2*256*256 + $3*256 + $4 }')
ip_upper_bound_num=$(echo $ip_upper_bound | awk -F. '{ print $1*256*256*256 + $2*256*256 + $3*256 + $4 }')

# loop through the ipv4 address's in the specefied bound
for i in $(seq $ip_lower_bound_num $ip_upper_bound_num); do
    # convert the binary value of i into a string compitable with the format oct.oct.oct.oct
    ip=$(echo $i | awk '{printf "%d.%d.%d.%d\n", $1/256/256/256,$1/256/256%256,$1/256%256,$1%256}')
        ping -c2 $ip &> /dev/null
    if [ $? = 0 ]; then
    echo "$ip is UP"
    else
    echo "$ip is DOWN"
    fi
done