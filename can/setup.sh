#!/bin/bash -evx

sudo apt -y install can-utils python3-can python3-websockets python3-qrcode

config_text="[all]
dtoverlay=mcp2515-can1,oscillator=16000000,interrupt=25
dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=23
dtoverlay=spi-bcm2835-overlay"

config_file="/boot/firmware/config.txt"

if grep -q "dtoverlay=mcp2515-can1,oscillator=16000000,interrupt=25" "$config_file" && \
    grep -q "dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=23" "$config_file" && \
    grep -q "dtoverlay=spi-bcm2835-overlay" "$config_file"; then
    echo "The configuration already exists. No changes made."
else
    echo "$config_text" | sudo tee -a "$config_file" > /dev/null
    echo "Configuration has been added."
fi

sudo cp can0up.service /etc/systemd/system/can0up.service
sudo systemctl daemon-reload
sudo systemctl enable can0up.service
sudo systemctl restart can0up.service

read -p "Is it okay to reboot the system? (y/n): " answer

while true; do
    read -p "Is it okay to reboot the system? (y/n): " answer

    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        echo "Rebooting the system..."
        sudo reboot
        break
    elif [[ "$answer" == "n" || "$answer" == "N" ]]; then
        echo "Reboot canceled."
        break
    else
        echo "Invalid input. Please enter 'y' or 'n'."
    fi
done