#!/bin/bash
# Using `sudo` to simplify which command needs root premissions

# Update and upgrade
# sudo apt update && sudo apt full-upgrade -y

# Copy and set wallpaper
sudo cp ./wallpaper/earth.jpg /usr/share/backgrounds/
gsettings set org.gnome.desktop.background picture-uri file:///usr/share/backgrounds/earth.jpg
gsettings set org.gnome.desktop.screensaver picture-uri file:///usr/share/backgrounds/earth.jpg

# Installing packages
packages=(git wget cmake firefox terminator)

for package in "${packages[@]}" 
do
	echo "[info] Installing: ${package}"
	# sudo apt install -y &>/dev/null
done

# Install VS Code
# for now there is minor bug with snap version (might need manual installation from .deb)
# sudo snap install --classic vscode

# Install VS Code extensions
# vscode --install-extension ms-vscode.cpptools
# vscode --install-extension twxs.cmake
# vscode --install-extension EugenWiens.bitbake
# vscode --install-extension CoenraadS.bracket-pair-colorizer
