#!/bin/bash
# Hydrate Kali with my personal preferences and pentest repos

# ----- Set up directories -----
if [[ -d "/usr/bin/HackRepo" ]]
then
    echo "HackRepo directory already exists! Skipping..."
else
mkdir /usr/bin/HackRepo;
fi

if [[ -d "/root/TryHackMe" ]]
then
    echo "TryHackMe directory already exists! Skipping..."
else
mkdir /root/TryHackMe;
fi

if [[ -d "/usr/bin/pip" ]]
then
    echo "Pip directory already exists! Skipping..."
else
mkdir /usr/bin/pip;
fi


# ----- Configure .bashrc profile -----
cd /root;
if [[ -f "/root/.bashrc_BAK" ]]
then
    echo ".bashrc already configured. Skipping..."
else mv /root/.bashrc /root/.bashrc_BAK && cp /root/bashrc_configured /root/.bashrc
fi

# ----- Install packages -----
apt-get update && apt-get upgrade -y
apt-get install mingw-w64 -y
apt-get install pure-ftpd -y
apt-get install shellter -y
apt-get install rinetd -y
apt-get install gcc-9-base libgcc-9-dev libc6-dev -y
apt-get install terminator -y
apt-get install seclists -y
apt-get update && apt-get upgrade -y

# ----- Tidy up -----
apt autoremove -y

# ----- Clone git repositories -----
cd /usr/bin/HackRepo;
git clone https://github.com/pentestmonkey/windows-privesc-check.git;
git clone https://github.com/21y4d/nmapAutomator;
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git;
git clone https://github.com/rapid7/ssh-badkeys.git;
git clone https://github.com/samratashok/nishang.git;
git clone https://github.com/huntergregal/mimipenguin.git;
git clone https://github.com/DominicBreuker/pspy.git;
git clone https://github.com/OWASP/joomscan.git;
git clone https://github.com/CoreSecurity/impacket.git;

# ----- Set executable permissions on git repos -----
chmod +x /usr/bin/HackRepo/nmapAutomator/nmapAutomator.sh

# ----- Set up Pip Installer -----
cd /usr/bin/pip;
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py;
python get-pip.py;

# ----- Pip Install Respositories -----
pip install pycryptodome;

# ----- Set up Lolcat -----
if [[ -d "/usr/bin/lolcat" ]]
then
    echo "Lolcat directory already exists! Skipping..."
else
mkdir /usr/bin/lolcat;
fi

cd /usr/bin/lolcat;
wget https://github.com/busyloop/lolcat/archive/master.zip;
unzip master.zip;
cd lolcat-master/bin;
gem install lolcat;

# ----- Copy Terminator Config -----
mkdir /root/.config/terminator
cp /root/kali-hydration/terminator_config /root/.config/terminator/config

# ----- Set Wallpaper -----
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual1/workspace0/last-image -s /root/kali-hydration/wallpaper.jpg
