#!/bin/bash

# TODO: Add night light customization

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

# Update and upgrade
apt update && apt full-upgrade -y

# Copy wallpapers
cp ./wallpaper/earth.jpg /usr/share/backgrounds/
cp ./wallpaper/stairs.jpg /usr/share/backgrounds/

# Set wallpaper and lockscreen
sudo -u $real_user gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/stairs.jpg
sudo -u $real_user gsettings set org.gnome.desktop.screensaver picture-uri file:///usr/share/backgrounds/stairs.jpg

# Show batery percentage
sudo -u $real_user gsettings set org.gnome.desktop.interface show-battery-percentage true

# Installing packages
packages=(
	         gcc g++ net-tools git wget cmake firefox
             terminator curl libavcodec-extra mc
         )

for package in "${packages[@]}" 
do
	echo "[info] Installing: ${package}"
	apt install -y ${package} &>/dev/null
done

# Install VS Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt update
apt install code -y &>/dev/null

# Install VS Code extensions
sudo -u $real_user code --install-extension ms-vscode.cpptools
sudo -u $real_user code --install-extension twxs.cmake
sudo -u $real_user code --install-extension EugenWiens.bitbake
sudo -u $real_user code --install-extension CoenraadS.bracket-pair-colorizer
sudo -u $real_user code --install-extension jdinhlife.gruvbox

# Overwrite .bashrc
cp -v bashrc $HOME/.bashrc

# Overwrite .gitconfig
chmod +x /usr/share/doc/git/contrib/diff-highlight/diff-highlight
cp -v gitconfig $HOME/.gitconfig

# Configure dircolors
cp -v dircolors $HOME/.dircolors

# Configure terminator
mkdir -p $HOME/.config/terminator/
cp -v terminator/config $HOME/.config/terminator/config

# Configure VS Code
mkdir -p $HOME/.config/Code/User/
cp -v vscode/settings.json $HOME/.config/Code/User/settings.json

# Configure gedit
mkdir -p $HOME/.local/share/gedit/styles/
cp -v gedit/gruvbox-dark.xml $HOME/.local/share/gedit/styles/gruvbox-dark.xml
sudo -u $real_user gsettings set org.gnome.gedit.preferences.editor scheme gruvbox-dark

# Configure Midnight Commander
mkdir -p $HOME/.config/mc/
cp -v mc/ini $HOME/.config/mc/ini
