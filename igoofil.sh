#!/bin/bash

#Author:  Mayuresh Mitkari
#Date:    22/04/2020
#Version: 1.0.0

echo -e "\n**************************************"
echo "*  _____                             *"
echo "* |_____|                   _        *"
echo "*   | |   __ _  ___   ___  / _(_) |  *"
echo "*   | |  / _  |/ _ \ / _ \| |_| | |  *"
echo "*   | |   (_| | (_) | (_) |  _| | |  *"
echo "*  _| |_ \__, |\___/ \___/|_| |_|_|  *"
echo "* |_____||___/                       *"
echo "*                                    *"
echo "*                                    *"
echo "* Igoofil Ver 1.0.0                  *"
echo "* Mayuresh Mitkari                   *"
echo "* mmayuresh12@protonmail.com         *"
echo -e "**************************************\n"

#Input the required fields

read -p "Enter domain (eg: google): " domain

read -p "Enter Top Level Domain (eg: com / org / net): " tld

read -p "Enter full domain name to be searched (eg: www.google.com): " fulldomain

echo -e "\nFinding Server!"

#get the index.html file from web

wget $fulldomain

#Output the subdomains

echo -e "\nThe subdomains of $fulldomain are: "
subdomains=("grep -o '[^/]*\.$domain\.$tld' index.html | sort -u")
eval ${subdomains}

echo -e "\n"

#Save if user wants

echo "Do you want to write these Subdoamins in a file?"

while read -p "Input [y/Y/Yes/yes or n/N/No/no]: " ch; 
do
	case $ch in

	[Yy]*) read -p "Enter filename: " filename
			filesave=("grep -o '[^/]*\.$domain\.$tld' index.html | sort -u > ${filename}")
			eval ${filesave}
			echo -e "\nDone!! \nCheck $filename" 
			break
			;;

	[Nn]*) echo -e "\nOk, exiting the program!"; 
			exit 0
			;;

		*) echo -e "\nPlease answer y/Y/Yes/yes or n/N/No/no:";;

	esac
done

#Check for IP of the hosts found

echo -e "\n\nNow checking for IP addresses of the hosts..\n"

#Output the IP
for url in $(cat $filename); do host $url; done 

echo -e "\n"

#Save IP's if user wants

echo "Do you want these IP's to be saved in a file?[Y/N]: "

while read -p "Input [y/Y/Yes/yes or n/N/No/no]: " ch1;  
do
	case $ch1 in

	[Yy]* ) read -p "Enter filename: " filenameip
			for url in $(cat $filename); do host $url; done | grep "has address" | cut -d " " -f 4  > $filenameip
			echo -e "\nDone!! \nCheck $filenameip"
			break
			;;

	[Nn]* ) echo -e "\nOk, exiting the program!"; 
			exit 0
			;;

		* ) echo -e "\nPlease answer y/Y/Yes/yes or n/N/No/no:";;

	esac
done
