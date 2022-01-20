#!/bin/bash

dnssearch(){
    local dns=$(host $1 | cut -d " " -f 5)
    echo $dns
}

pingAll(){
  for addr in $(seq -f "$1.%g" 254); do
      ping -c 1 -W 0.1 $addr &> /dev/null
      success=$?
      if [[ $success -eq 0 ]]; then
	  dns=$(dnssearch $addr)
	  echo $addr "up at" $dns 
      else
	  echo $addr "Down"
	  sleep 0.1
      fi
  done
}


subnet=$(echo $1 | cut -d "/" -f 2)
echo $subnet
netAddr=$(echo $1 | cut -d "." -f 1,2,3)
pingAll $netAddr
done
