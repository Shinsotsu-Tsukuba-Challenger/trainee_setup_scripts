#!/bin/bash -evx

export ET_NIC_NAME=$(ip -o link show | awk -F': ' '/^[0-9]+: en[opsx]/ && /state UP/ {print $2}')
export WL_NIC_NAME=$(ip -o link show | awk -F': ' '/^[0-9]+: wl[opsx]/ && /state UP/ {print $2}')
sudo iptables -t nat -A POSTROUTING -o $WL_NIC_NAME -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $ET_NIC_NAME -o $WL_NIC_NAME -j ACCEPT