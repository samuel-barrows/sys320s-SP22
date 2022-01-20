#!/bin/bash

#===System administration===#

getproc(){
  #list all processes running 
  ps -a
}

getserv(){
  #List all installed services (on systemd systems)
  systemctl list-units --type=service
}

getapps(){
  #list all installed applications (on debian based distros)
  apt list --installed
}

getusers(){
  #list all users on the system
  cat /etc/passwd | cut -d ":" -f 1,5,6,7
}


sysadmin(){
    #The menu for the sysadmin to use to access the functions above
    while [ true ]
     do 
      echo " 
      	   1) List all running processes
	   2) List all running services
	   3) List all installed software
	   4) List all users
	   5) Return to main menu
	   6) Exit "
      read option
      case $option in
	  1) getproc ;;
	  2) getserv ;;
	  3) getapps ;;
	  4) getusers ;;
	  5) break ;;
	  6) exit ;;
      esac
     done 
}

#===Security administration===#


#listuserlogon() {
#    # list current logged on users
#    who | cut -d " " -f 1
#}

lasttenlogins() {
    # list last 10 logged in users
    last | head -n10
}

logview() {
    # print last 20 lines of an arbitrary file in /var/log
    while [ true ]
      do 
       ls /var/log
       echo "\nSpecify the given log in /var/log: "
       read log
       path="/var/log/$log"
       if [[ log =~ \.\..* ]]; then
	   echo "Please specify a log in /var/log"
       else
	   tail -n20 $path
	   break 
       fi
    done
}

netcon() {
    # Show the current network connections 
    lsof -i -n
}

shprocdet() {
    # Show the specific details of a specific process or proccess ID
}

secadmin(){

    #The security admin menu to run the functions above
    while [ true ]
     do 
      echo " 
      	   1) List last 10 logged in users
	   2) Print recent logs of a log
	   3) Run lsof -i -n
	   4) Show details of a running process
	   5) Return to main menu
	   6) Exit "
      read option
      case $option in
	  1) lasttenlogins ;;
	  2) logview ;;
	  3) netcon;;
	  4) shprocdet ;;
	  5) break ;;
	  6) exit ;;
      esac
    done
}

mainmenu(){
    while [ true ]
    do
      echo " 
      	   1) Security Administration
	   2) System Administrator
	   3) Exit "
      read option
      case $option in
	  1) secadmin ;;
	  2) sysadmin ;;
	  3) exit ;;
      esac
    done
}
	   
mainmenu
    
