#!/bin/bash
if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit
fi
#Assign existing hostname to $hostn
hostn=$(cat /etc/hostname)

#Display existing hostname
echo "Existing hostname is $hostn"

#Ask for new hostname $newhost
echo "Enter new hostname: "
read newhost
fullname=$newhost.shris.local

#change hostname in /etc/hosts & /etc/hostname
sudo sed -i "s/$hostn/$newhost  $fullname/g" /etc/hosts
sudo sed -i "s/$hostn/$newhost/g" /etc/hostname
#add A record of domain controller
echo "192.168.1.5 dc01.shris.local" >> /etc/hosts

#display new hostname
echo "Your new hostname is $newhost"
echo "Your nameserver is : $(cat /etc/resolv.conf | grep nameserver | awk '{print  $2}')"
echo "nameserver 192.168.1.5" > /etc/resolv.conf
hostnamectl set-hostname $newhost
