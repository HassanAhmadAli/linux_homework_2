#!/bin/bash
# alive.sh
# Checks to see if hosts 192.168.0.1-192.168.0.20 are alive
# Iterate through IP addressesexp
for n in {1..20}; do
    host=192.168.0.$n
    ping -c2 $host &> /dev/null
    if [ $? = 0 ]; then
    echo "$host is UP"
    else
    echo "$host is DOWN"
    fi
done
