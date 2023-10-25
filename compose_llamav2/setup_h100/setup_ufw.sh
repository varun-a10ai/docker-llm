#!/bin/bash

# Reset all ufw rules
ufw --force reset

# Install ufw-docker 
mkdir -p /usr/local/bin
sudo wget -O /usr/local/bin/ufw-docker https://github.com/chaifeng/ufw-docker/raw/master/ufw-docker
sudo chmod +x /usr/local/bin/ufw-docker
ufw enable
ufw-docker install

# Block ICMP
sed -i '/ufw-before-input.*icmp/s/ACCEPT/DROP/g' /etc/ufw/before.rules

# Set default policies and other settings
ufw default deny incoming
ufw default allow outgoing
ufw default deny routed
ufw logging low

# Allow specific IP addresses and ranges for SSH (port 22)
ufw allow from 76.226.87.0 to any port 22 proto tcp
ufw allow from 52.33.194.38 to any port 22 proto tcp
#ufw allow from 66.135.10.208 to any port 22 proto tcp
#ufw allow from 66.135.24.21 to any port 22 proto tcp

# Allow all traffic from 10.0.0.0/8 (New AWS Network)
ufw allow from 10.0.0.0/8

# Allow all traffic from 172.28.0.0/14 (Legacy AWS Network)
ufw allow from 172.28.0.0/14

# Enable ufw
ufw --force enable
