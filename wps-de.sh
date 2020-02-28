#!/bin/bash
# Skript-Idee (ungetestet) zur automatischen Installation von WPS Office mit Firejail Profilen
# Install Kingsoft WPS-Office with firejail
wget -c http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/9080/wps-office_11.1.0.9080.XA_amd64.deb
apt-get install -y wps-office_11.1.0.9080.XA_amd64.deb
apt --fix-broken install
# install german language
apt-get install -y p7zip-full
wget https://github.com/timxx/wps-office-mui/raw/master/mui/de_DE.7z
7za x de_DE.7z -o/opt/kingsoft/wps-office/office6/mui
# install ms fonts
mkdir /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/WEBDINGS.TTF -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/WINGDNG2.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/WINGDNG3.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/symbol.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/wingding.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/mtextra.ttf -P /usr/share/fonts/wps-fonts
chmod 644 /usr/share/fonts/wps-fonts/*
fc-cache -vfs
# EULA Accepted true
mkdir -p ~/.config/Kingsoft
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/home/username/.config/Kingsoft/Office.conf -P $HOME/$USER/.config/Kingsoft/
# install firejail
apt-get install -y firejail firejail-profiles
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/wps.profile -P /etc/firejail/
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/wpspdf.profile -P /etc/firejail/
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/wpp.profile -P /etc/firejail/
echo "wps" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "wpspdf" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "wpp" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
# initialize firejail
firecfg
firecfg --fix
rm de_DE.7z 
rm wps-office_11.1.0.9080.XA_amd64.deb
rm -r $HOME/.kingsoft
apt-get remove -y p7zip-full 
apt-get autoclean
