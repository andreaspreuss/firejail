#!/bin/bash -x
# Skript zur automatischen Installation von WPS Office mit eigenen Firejail Profilen
# Install Kingsoft WPS-Office with firejail - chmod a+x wps-de.sh - ./wps-de.sh
# wget -O - https://raw.githubusercontent.com/andreaspreuss/firejail/master/wps-de.sh | sudo bash 
#
# Download Kingsoft WPS Office
wget -c http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/9080/wps-office_11.1.0.9080.XA_amd64.deb
dpkg -i wps-office_11.1.0.9080.XA_amd64.deb
apt-get install -f
# install german language
apt-get install -y p7zip-full
wget https://github.com/andreaspreuss/firejail/raw/master/opt/kingsoft/wps-office/office6/mui/de_DE.7z
7za x de_DE.7z -y -o/opt/kingsoft/wps-office/office6/mui
# install ms fonts
# mkdir /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/WEBDINGS.TTF -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/WINGDNG2.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/WINGDNG3.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/symbol.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/wingding.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/mtextra.ttf -P /usr/share/fonts/wps-fonts
chmod 644 /usr/share/fonts/wps-fonts/*
fc-cache -vfs
# EULA accepted true
mkdir -p /home/$USER/.cache/Kingsoft
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/home/username/.config/Kingsoft/Office.conf -P /home/$USER/.config/Kingsoft/
chmod 644 /home/$USER/.config/Kingsoft/*
# delete unnecassary directories
rmdir -rfv /home/$USER/.kingsoft
rmdir -rfv /home/$USER/模板
# install firejail
apt-get install -y firejail firejail-profiles firetools
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/wps.profile -P /etc/firejail/
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/wpspdf.profile -P /etc/firejail/
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/wpp.profile -P /etc/firejail/
echo "wps" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "wpspdf" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "wpp" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
# echo "$USER" >> /etc/firejail/firejail.users
# firejail initialisation desktop Integration
firecfg
# ln -s /usr/bin/wps /usr/local/bin/wps
# ln -s /usr/bin/wpp /usr/local/bin/wpp
# ln -s /usr/bin/wpspdf /usr/local/bin/wpspdf
# delete unnecessay files
rm -f de_DE.7z 
rm -f wps-office_11.1.0.9080.XA_amd64.deb
apt-get remove -y p7zip-full 
apt-get clean
apt-get autoremove
