user=$(whoami)
wd=$(pwd)
# Installing stuff
#
#
#
#
echo "Installing stuff"
echo "Stuff that doesn't use apt"
echo "Antidot"
cd ~/Downloads

wget -O antidot https://github.com/doron-cohen/antidot/releases/latest/download/antidot_0.6.3_Linux_x86_64
chmod +x antidot 
echo "Moving antidot to a folder in PATH"
mv antidot ~/.local/bin


