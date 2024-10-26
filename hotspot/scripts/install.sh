#!/bin/bash -e

if [ -z "$HOTSPOT_SSID" ]
then
    echo "HOTSPOT_SSID is not set."
    echo "Pease run export HOTSPOT_SSID=trainee"
    echo "Exiting..."
    exit 1
fi

sudo apt-get install -y dnsmasq hostapd iw network-manager
git clone https://github.com/oblique/create_ap
cd create_ap
sudo make install
cd -
rm -rf create_ap

sudo cp $(ros2 pkg prefix --share trainee_setup_scripts)/hotspot/service/hotspot.service /etc/systemd/system/hotspot.service
sudo sed -i "s/HOTSPOT_SSID_NAME/$HOTSPOT_SSID/g" /etc/systemd/system/hotspot.service
sudo systemctl daemon-reload
sudo systemctl enable hotspot.service
sudo systemctl restart hotspot.service
