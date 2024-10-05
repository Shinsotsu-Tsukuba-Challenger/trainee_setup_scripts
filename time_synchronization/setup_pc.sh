#!/bin/bash -evx

sudo apt install -y chrony

sudo bash -c 'echo -e "\nlocal stratum 10\nallow 192.168.12/24\nallow 10.42/24" >> /etc/chrony/chrony.conf'

sudo systemctl restart chrony.service