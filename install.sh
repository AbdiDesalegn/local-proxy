#!/bin/bash

# Check if running as root
if [[ $(id -u) -ne 0 ]]; then
    echo "Please run as root"
    exit
fi

# Update and install required packages
apt-get update
apt-get install -y squid curl jq

# Backup original squid.conf
cp /etc/squid/squid.conf /etc/squid/squid.conf.bak

# Download new squid.conf from GitHub
curl -sLJO https://raw.githubusercontent.com/myusername/local-proxy/main/squid.conf

# Get local IP address
IP=$(hostname -I | awk '{print $1}')

# Update squid.conf with local IP address
sed -i "s/localhost/$IP/g" squid.conf

# Move updated squid.conf to /etc/squid/
cp squid.conf /etc/squid/

# Start squid service
systemctl start squid

# Add squid service to startup
systemctl enable squid

echo "Local proxy setup complete"
