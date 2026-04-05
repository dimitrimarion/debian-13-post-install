#!/bin/sh

sudo apt update
sudo apt upgrade -y

# https://wiki.debian.org/Xorg
sudo apt install -y xorg i3 picom
mkdir -p ~/.config/i3
cp config/i3/* ~/.config/i3
sudo dpkg-reconfigure keyboard-configuration

wget https://github.com/JezerM/web-greeter/releases/download/3.5.3/web-greeter-3.5.3-debian.deb
sudo mv web-greeter-3.5.3-debian.deb /tmp
sudo apt install -y lightdm
sudo apt install -y /tmp/web-greeter-3.5.3-debian.deb
sudo cp config/web-greeter.yml /etc/lightdm/
sudo cp config/lightdm.conf /etc/lightdm/
sudo systemctl enable lightdm

cp config/user-dirs.dirs ~/.config/user-dirs.dirs
mkdir ~/data
mkdir ~/data/Documents
mkdir ~/data/Downloads
mkdir ~/data/Pictures
mkdir ~/data/Music
mkdir ~/data/Videos
mkdir ~/Desktop
mkdir ~/Templates
mkdir ~/Public

# TODO: show volume indicator with keyboard
# TODO: font
# TODO: laptop power management
# TODO: printer
# TODO: copy file type associations

## Network
sudo apt install -y network-manager-gnome

# Sound
#sudo apt install -y pavucontrol pulseaudio pulseaudio-utils pasystray paprefs pulseaudio-module-zeroconf
sudo apt install -y pipewire-audio pasystray pulseaudio-utils pavucontrol
systemctl --user enable pipewire pipewire-pulse wireplumber


# Bluetooth 
sudo apt install -y blueman 

# Hack nerd fonts
sudo apt install -y curl unzip zip
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip
mkdir -p ~/.local/share/fonts
unzip Hack.zip -d ~/.local/share/fonts/
fc-cache
sudo apt install fonts-noto


# st terminal
sudo apt install -y xorg-dev build-essential git
git clone https://github.com/dimitrimarion/st-flexipatch.git
cd st-flexipatch
sudo make clean install
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/st 40
sudo update-alternatives --set x-terminal-emulator /usr/local/bin/st
cd -

# wezterm
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
sudo apt update
sudo apt install -y wezterm
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/wezterm 60
sudo update-alternatives --set x-terminal-emulator /usr/bin/wezterm 
cp config/wezterm.lua ~/.wezterm.lua


# vim
sudo apt install -y vim-gtk3
cp config/vimrc ~/.vimrc
sudo update-alternatives --set editor /usr/bin/vim.basic

# file manager
sudo apt install -y pcmanfm

# image viewer
sudo apt install -y nsxiv
sudo cp bin/cnsxiv /usr/local/bin
#sudo chmod +x /usr/local/bin
mkdir -p ~/.local/share/applications
cp applications/* ~/.local/share/applications
cp config/mimeapps.list ~/.config

# mail
# gmail sign in with app passwords: https://support.google.com/mail/answer/185833?hl=en
#sudo apt install -y sylpheed sylpheed-plugins
sudo apt install -y thunderbird

# pdf
sudo apt install -y zathura
mkdir ~/.config/zathura
cp config/zathurarc ~/.config/zathura/zathurarc

# video player
sudo apt install -y mpv

# screenshot
sudo apt install -y flameshot

# pager
sudo apt install -y most
sudo update-alternatives --set pager /usr/bin/most

# password manager
sudo apt install -y keepassxc

# docker
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker $USER


# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# vscode
sudo apt install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg
sudo cp config/vscode.sources /etc/apt/sources.list.d/
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code # or code-insiders



# gtk2 theme for pcmanfm and sylpheed
sudo apt install -y lxappearance greybird-gtk-theme
cp config/.gtkrc-2.0 ~/.gtkrc-2.0
cp -R config/gtk-3.0 ~/.config

# autostart X at login
#cp config/.profile ~/.profile

# Deactivate laptop monitor if external connected 
# https://wiki.archlinux.org/title/xrandr #Toggle_external_monitor
#sudo vim /usr/share/sddm/scripts/Xsetup # deactivate laptop monitor

###
sudo apt install -y tldr-py xsel htop firefox-esr feh arandr

# wallpapers
mkdir ~/data/Pictures/wallpapers
git clone https://gitlab.com/dwt1/wallpapers.git ~/data/Pictures/wallpapers
rm ~/data/Pictures/wallpapers/README.md

# starship
curl -sS https://starship.rs/install.sh | sh
echo "eval "'"$(starship init bash)"'"" >> ~/.bashrc

# update locale
# might be not necessary if you want to use the same locale for everything
sudo update-locale LC_TIME=fr_FR.utf8 LC_PAPER=fr_FR.utf8 LC_NAME=fr_FR.utf8 LC_ADDRESS=fr_FR.utf8 LC_TELEPHONE=fr_FR.utf8 LC_MEASUREMENT=fr_FR.utf8


# Configure git
echo "Configuring git"
read -p "Git user name: " git_user_name
git config --global user.name $git_user_name
read -p "Git email: " git_email
git config --global user.email $git_email
git config --global init.defaultBranc "master"

# Github cli
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install -y gh


# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo mv google-chrome-stable_current_amd64.deb /tmp
sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb 
sudo updates-alternatives --set x-www-browser /usr/bin/google-chrome-stable

sudo apt install -y nextcloud-desktop

# firewall
sudo apt install -y ufw
sudo ufw enable

echo "disable power management on lid switch"
echo " uncomment #HandleLidSwitch=ignore in /etc/systemd/logind.conf"


