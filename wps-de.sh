#!/bin/bash
# Skript-Idee (ungetestet) zur automatischen Installation von WPS Office mit Firejail Profilen
# Install Kingsoft WPS-Office with firejail - chmod a+x wps-de.sh - ./wps-de.sh
wget -c http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/9080/wps-office_11.1.0.9080.XA_amd64.deb
apt-get install -y wps-office_11.1.0.9080.XA_amd64.deb
apt --fix-broken install
# install german language
apt-get install -y p7zip-full
wget https://github.com/andreaspreuss/firejail/raw/master/opt/kingsoft/wps-office/office6/mui/de_DE.7z
7za x de_DE.7z -o/opt/kingsoft/wps-office/office6/mui
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
# ln -s /usr/bin/wps /usr/local/bin/wpp
# ln -s /usr/bin/wps /usr/local/bin/wpspdf
# delete unnecessay files
rm de_DE.7z 
rm wps-office_11.1.0.9080.XA_amd64.deb
rm -r /home/$USER/.kingsoft
rm -r /home/$USER/模板
apt-get remove -y p7zip-full 
apt-get autoclean
