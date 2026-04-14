#!/bin/bash

echo "Start NAT setup"

# Install iptables
dnf install -y iptables-services

# Enable service
systemctl enable iptables
systemctl start iptables

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

# Detect primary interface automatically
IFACE=$(ip route | grep default | awk '{print $5}')

# Apply NAT
iptables -t nat -A POSTROUTING -o $IFACE -j MASQUERADE

# Allow forwarding
iptables -A FORWARD -i $IFACE -o $IFACE -j ACCEPT
iptables -A FORWARD -o $IFACE -m state --state RELATED,ESTABLISHED -j ACCEPT

# Save rules
iptables-save > /etc/sysconfig/iptables

echo "NAT setup completed"
