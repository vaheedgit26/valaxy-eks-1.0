#!/usr/bin/env bash
echo " start of the nat_user_data.sh script"
###########################################
sudo yum install iptables-services -y
sudo systemctl enable iptables
sudo systemctl start iptables
sudo sysctl -w net.ipv4.ip_forward=1
sudo /sbin/iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE
# sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo /sbin/iptables -F FORWARD
############################################
echo " reached end of the nat_user_data.sh script"
