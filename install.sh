#!/bin/sh
user=$(whoami)
wd=$(pwd)
# Installing stuff
#
#
#
#
echo "Downloading config files first"
cd ~/Downloads/
git clone --depth=1 https://github.com/DNM1008/Dots && cd Dots
cp -r .config/* ~/.config/
mkdir -p ~/.local/bin/scripts/
cp -r .local/ ~/.local/
echo "Installing stuff"

echo "Installing dependencies"
sudo apt install git python3-pip

echo "Apt stuff"
echo "fastfetch"

sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo apt update

sudo apt install fastfetch alacritty rofi xwallpaper thunar i3lock udiskie neovim fortune-mod eza curl git

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

echo "Nerd fonts"
declare -a fonts=(
    BitstreamVeraSansMono
    CodeNewRoman
    DroidSansMono
    FiraCode
    FiraMono
    Go-Mono
    Hack
    Hermit
    JetBrainsMono
    Meslo
    Noto
    Overpass
    ProggyClean
    RobotoMono
    SourceCodePro
    SpaceMono
    Ubuntu
    UbuntuMono
)

version='2.1.0'
fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
    zip_file="${font}.zip"
    download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    echo "Downloading $download_url"
    wget "$download_url"
    unzip "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

echo "Fira Mono font - alacritty font"
cp Fira_Mono/* $fonts_dir

echo "Ubuntu Nerd font - bar font"
cp Ubuntu/* $fonts_dir

fc-cache -fv

echo "GTK theme"

cd ~/.local/share/themes

# Set the root URL
export ROOT_URL="https://https://github.com/catppuccin/gtk/releases/download"

# Change to the tag you want to download
export RELEASE="v1.0.3"
  
# Change to suite your flavor / accent combination
export FLAVOR="macchiato"
export ACCENT="rosewater"
curl -LsS "${ROOT_URL}/${RELEASE}/catppuccin-${FLAVOR}-${ACCENT}-standard+default.zip"

# Extract the catppuccin zip file
unzip catppuccin-${FLAVOR}-${ACCENT}-standard+default.zip

# Set the catppuccin theme directory
export THEME_DIR="$HOME/.local/share/themes/catppuccin-${FLAVOR}-${ACCENT}-standard+default"

# Optionally, add support for libadwaita
mkdir -p "${HOME}/.config/gtk-4.0" && 
ln -sf "${THEME_DIR}/gtk-4.0/assets" "${HOME}/.config/gtk-4.0/assets" &&
ln -sf "${THEME_DIR}/gtk-4.0/gtk.css" "${HOME}/.config/gtk-4.0/gtk.css" &&
ln -sf "${THEME_DIR}/gtk-4.0/gtk-dark.css" "${HOME}/.config/gtk-4.0/gtk-dark.css"

echo "System configs"

echo "source /home/$user/.config/bash/bash_profile" | sudo tee -a /etc/bash.bashrc
echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee -a /etc/environment



echo "Installing rofi theme"
cd ~/Downloads/
git clone https://github.com/catppuccin/rofi.git
cd rofi/basic && ./install.sh



echo "Cleaning up"
cd

source .config/bash/bash_profile

sudo rm -r .bash_history .bash_profile .bash_logout .bashrc
sudo rm -r .gnupg/
sudo rm -r go/
yay -Scc --noconfirm

sudo rm -r  ~/go
antidot update
antidot clean
eval "$(antidot init)"
