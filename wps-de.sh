#!/bin/bash -x
# Skript zur automatischen Installation von WPS Office mit eigenen Firejail Profilen
# Install Kingsoft WPS-Office with firejail - chmod a+x wps-de.sh - ./wps-de.sh
# wget -O - https://raw.githubusercontent.com/andreaspreuss/firejail/master/wps-de.sh | sudo bash 
#
# Download newest Kingsoft WPS Office directly from china
wget -c http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/9126/wps-office_11.1.0.9126.XA_amd64.deb
dpkg -i wps-office_11.1.0.9126.XA_amd64.deb
apt-get install -f
# install german language for wps
apt-get install -y p7zip-full
wget https://github.com/andreaspreuss/firejail/raw/master/opt/kingsoft/wps-office/office6/mui/de_DE.7z
7za x de_DE.7z -y -o/opt/kingsoft/wps-office/office6/mui
# install german spellcheck for wps
mkdir -p /opt/kingsoft/wps-office/office6/dicts/spellcheck/de_DE
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/opt/kingsoft/wps-office/office6/dicts/spellcheck/de_DE/main.dic -P /opt/kingsoft/wps-office/office6/dicts/spellcheck/de_DE
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/opt/kingsoft/wps-office/office6/dicts/spellcheck/de_DE/main.aff -P /opt/kingsoft/wps-office/office6/dicts/spellcheck/de_DE
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/opt/kingsoft/wps-office/office6/dicts/spellcheck/de_DE/dict.conf -P /opt/kingsoft/wps-office/office6/dicts/spellcheck/de_DE
# install firejailing german desktop files 
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/opt/kingsoft/wps-office/desktops/wps-office-et.desktop -P /opt/kingsoft/wps-office/desktops
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/opt/kingsoft/wps-office/desktops/wps-office-pdf.desktop -P /opt/kingsoft/wps-office/desktops
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/opt/kingsoft/wps-office/desktops/wps-office-prometheus.desktop -P /opt/kingsoft/wps-office/desktops
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/opt/kingsoft/wps-office/desktops/wps-office-wpp.desktop -P /opt/kingsoft/wps-office/desktops
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/opt/kingsoft/wps-office/desktops/wps-office-wps.desktop -P /opt/kingsoft/wps-office/desktops
# install mime connections for firejailed wps office
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/applications/wps-office-et.desktop -P /usr/share/applications
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/applications/wps-office-pdf.desktop -P /usr/share/applications
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/applications/wps-office-prometheus.desktop -P /usr/share/applications
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/applications/wps-office-wpp.desktop -P /usr/share/applications
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/applications/wps-office-wps.desktop -P /usr/share/applications
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/applications/qmcneu.desktop -P /usr/share/applications
# install ms fonts
# mkdir -p /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/WEBDINGS.TTF -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/WINGDNG2.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/WINGDNG3.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/symbol.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/wingding.ttf -P /usr/share/fonts/wps-fonts
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/usr/share/fonts/wps-fonts/mtextra.ttf -P /usr/share/fonts/wps-fonts
chmod 644 /usr/share/fonts/wps-fonts/*
fc-cache -fs
# install firejail wps profiles working with thinlinc
apt-get install -y firejail firejail-profiles firetools
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/wps.profile -P /etc/firejail/
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/wpspdf.profile -P /etc/firejail/
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/wpp.profile -P /etc/firejail/
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/et.profile -P /etc/firejail/
# wine should not start with firejail
sed -i '470 s/^/# /' /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
rm -v /etc/firejail/wine*
# add wps applications in firejail
echo "et" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "wps" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "wpspdf" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "wpp" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
# echo "$USER" >> /etc/firejail/firejail.users
# firejail initialisation desktop Integration
firecfg
# ln -s /usr/bin/wps /usr/local/bin/wps
# ln -s /usr/bin/wpp /usr/local/bin/wpp
# ln -s /usr/bin/wpspdf /usr/local/bin/wpspdf
# delete unnecassary directories as user
# username="$( echo $1 | awk '{ print $6 }' )"
rm -rf /home/$USER/模板
rm -rf /home/$USER/.kingsoft
# EULA accepted true
mkdir -p /home/$USER/.config/Kingsoft
wget -N https://raw.githubusercontent.com/andreaspreuss/firejail/master/home/username/.config/Kingsoft/Office.conf -P /home/$username/.config/Kingsoft/
chmod 644 /home/$username/.config/Kingsoft/*
# delete unnecessay files & packages
rm -rf de_DE.7z 
rm -rf wps-office_11.1.0.9126.XA_amd64.deb
apt-get remove -y p7zip-full 
# cleanup
apt-get -y autoremove
apt-get clean all
