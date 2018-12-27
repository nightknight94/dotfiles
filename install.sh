#!/bin/bash
# Using `sudo` to simplify which command needs root premissions

# TODO: Add sidebar customization
# TODO: Add night light customization
# TODO: Add bitbake syntax to vim (copy vim config)
# TODO: Split to multiple scripts (run by root and user)

# Update and upgrade
sudo apt update && sudo apt full-upgrade -y

# Copy and set wallpaper
sudo cp ./wallpaper/earth.jpg /usr/share/backgrounds/
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/earth.jpg
gsettings set org.gnome.desktop.screensaver picture-uri file:///usr/share/backgrounds/earth.jpg

# Installing packages
packages=(git wget cmake firefox terminator curl)

for package in "${packages[@]}" 
do
	echo "[info] Installing: ${package}"
	sudo apt install -y &>/dev/null
done

# Install VS Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code -y &>/dev/null

# Install VS Code extensions
code --install-extension ms-vscode.cpptools
code --install-extension twxs.cmake
code --install-extension EugenWiens.bitbake
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension jdinhlife.gruvbox

# Configure terminator
cp -v terminator/config $HOME/.config/terminator/config

# Configure VS Code
cp -v vscode/settings.json $HOME/.config/Code/User/settings.json
