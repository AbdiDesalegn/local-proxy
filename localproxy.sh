#!/bin/bash

# Check if running as root
if [[ $(id -u) -ne 0 ]]; then
    echo "Please run as root"
    exit
fi

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 start|stop"
    exit
fi

if [[ "$1" == "start" ]]; then
    systemctl start squid
    echo "Local proxy started"
elif [[ "$1" == "stop" ]]; then
    systemctl stop squid
    echo "Local proxy stopped"
else
    echo "Usage: $0 start|stop"
fi
