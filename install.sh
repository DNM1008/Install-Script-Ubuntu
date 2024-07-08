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
