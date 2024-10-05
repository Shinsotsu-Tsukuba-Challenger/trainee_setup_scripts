#!/bin/bash -evx

sudo apt install -y chrony

sudo timedatectl set-timezone Asia/Tokyo

sudo bash -c 'echo -e "\nserver 10.42.0.1 minpoll 0 maxpoll 5\nserver 192.168.12.12 minpoll 0 maxpoll 5\nmakestep 10 3" >> /etc/chrony/chrony.conf'

sudo systemctl restart chrony.service