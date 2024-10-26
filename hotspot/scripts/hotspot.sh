#!/bin/bash -e

sleep 10
if [ -n "$(ip a | grep ap0)" ]; then
 iw dev ap0 del
fi
iw dev wlan0 interface add ap0 type __ap
create_ap -c 9 --freq-band 2.4 --no-virt ap0 wlan0 $1
