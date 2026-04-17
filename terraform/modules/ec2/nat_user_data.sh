#!/usr/bin/env bash
set -euxo pipefail

echo "==== NAT INSTANCE SETUP START ===="

# Install iptables (AL2023 uses nft backend but iptables wrapper works)
dnf install -y iptables-services

# Enable service
systemctl enable iptables
systemctl start iptables

# Enable IP forwarding (persistent)
cat <<EOF > /etc/sysctl.d/99-nat.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.default.rp_filter = 0
EOF

sysctl --system

# Get primary network interface
IFACE=$(ip route | awk '/default/ {print $5}')

# Replace with your VPC CIDR (VERY IMPORTANT)
VPC_CIDR="10.100.0.0/16"

echo "Using interface: $IFACE"
echo "Using VPC CIDR: $VPC_CIDR"

# Flush any existing rules (idempotent)
iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X

# NAT: Masquerade private subnet traffic to internet
iptables -t nat -A POSTROUTING -s $VPC_CIDR -o $IFACE -j MASQUERADE
# iptables -t nat -A POSTROUTING  -o $IFACE -j MASQUERADE

# Allow outbound traffic from private subnets
iptables -A FORWARD -s $VPC_CIDR -o $IFACE -j ACCEPT

# Allow return traffic
iptables -A FORWARD -d $VPC_CIDR -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Save rules
iptables-save > /etc/sysconfig/iptables

echo "==== NAT INSTANCE SETUP COMPLETE ===="
