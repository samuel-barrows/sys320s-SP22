#!/bin/bash

#https://rules.emergingthreats.net/blockrules/emerging-botcc.rules
#https://rules.emergingthreats.net/blockrules/compromised-ips.txt

#https://www.cisco.com/c/en/us/support/docs/ip/access-lists/26448-ACLsamples.html#anc6

curl https://rules.emergingthreats.net/blockrules/emerging-botcc.rules --output test.txt
curl https://rules.emergingthreats.net/blockrules/compromised-ips.txt --output test2.txt

format() {
    # Take the files, take the ips, and combine them all together

    touch ips.txt
    
    # pipeline to extract all IPs from the first file
    cat test.txt | cut -d "[" -f2 | cut -d "]" -f1 | grep "^[^#;]" | tr " " "," | sed 's/,/,\n/g' > ips.csv

    # pipeline to convert the second file to a csv
    sed s/$/,/g test2.txt | tr " " "," >> ips.csv
}

iptables() {
    
    return 0
}

netscan() {
    # Create netscan ruleset
    return 0
}

cisco() {
    # Create cisco ruleset
    while read line
    do
	line=$(echo $line | sed 's/,//g')
	echo "access-list 1 deny host $(echo $line)"
    done < ips.csv
}

format
cisco
