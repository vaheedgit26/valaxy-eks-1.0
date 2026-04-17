#!/usr/bin/env bash
set -euxo pipefail

echo "==== NAT INSTANCE SETUP START ===="

dnf install -y iptables-services

systemctl enable iptables
systemctl start iptables

cat <<EOF > /etc/sysctl.d/99-nat.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.default.rp_filter = 0
EOF

sysctl --system

IFACE=$(ip route | awk '/default/ {print $5}')

VPC_CIDR="${vpc_cidr}"

echo "Using interface: $IFACE"
echo "Using VPC CIDR: $VPC_CIDR"

iptables -F
iptables -t nat -F
iptables -t mangle -F
iptables -X

iptables -t nat -A POSTROUTING -s $VPC_CIDR -o $IFACE -j MASQUERADE
iptables -A FORWARD -s $VPC_CIDR -o $IFACE -j ACCEPT
iptables -A FORWARD -d $VPC_CIDR -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

iptables-save > /etc/sysconfig/iptables

echo "==== NAT INSTANCE SETUP COMPLETE ===="
