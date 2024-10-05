#!/bin/bash -evx

sudo nmcli connection add type ethernet con-name $1 ifname eth0 ip4 $2/24 gw4 $3
nmcli connection show
nmcli connection reload
nmcli connection show