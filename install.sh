#!/bin/sh
user=$(whoami)
wd=$(pwd)
# Installing stuff
#
#
#
#
echo "Installing stuff"
echo "Installing dependencies"
sudo apt install git python3-pip

echo "Python externally-managed environment"
sudo rm /usr/lib/python3.12/EXTERNALLY-MANAGED



echo "Stuff that doesn't use apt"
echo "Antidot"
cd ~/Downloads

wget -O antidot https://github.com/doron-cohen/antidot/releases/latest/download/antidot_0.6.3_Linux_x86_64
chmod +x antidot 
echo "Moving antidot to a folder in PATH"
mv antidot ~/.local/bin

echo "Qtile and such"

pip install qtile qtile-extras psutil asyncio pulsectl-asyncio

echo "Desktop Entry for Qtile"
sudo cp $wd/qtile.desktop /usr/share/xsessions/qtile.desktop

echo "fastfetch"
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch

echo "Apt stuff"
sudo apt install fastfetch alacritty rofi xwallpaper thunar i3lock udiskie
