#!/bin/sh

# custom st changing font size if hidpi laptop monitor
sudo cp bin/st-custom
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/st-custom 50

# handle monitor and dpi
cp config/.xsessionrc ~/.xsessionrc
cp config/.Xresources-hidpi ~/.Xresources-hidpi

# brightness control with Fn keys
sudo cp bin/brightness /usr/local/bin/brightness
sudo chmod +x /usr/local/bin/brightness
sudo cp 90-backlight.rules /etc/udev/rules.d/90-backlight.rules
