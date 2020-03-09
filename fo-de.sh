#!/bin/sh
echo "Installation von Freeoffice"
wget -c https://www.softmaker.net/down/softmaker-freeoffice-2018_974-01_amd64.deb
dpkg -i softmaker-freeoffice-2018_974-01_amd64.deb
apt-get install -y qpdfview
# install firejail
apt-get install -y firejail firejail-profiles firetools
wget -c https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/softmaker-common.inc -P /etc/firejail/
wget -c https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/textmaker18free.profile -P /etc/firejail/
wget -c https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/presentations18free.profile -P /etc/firejail/
wget -c https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/planmaker18free.profile -P /etc/firejail/
echo "textmaker18free" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "presentations18free" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "planmaker18free" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "textmaker" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
# echo "$USER" >> /etc/firejail/firejail.users
# firejail initialisation desktop Integration
firecfg
# delete unused files
rm -rf softmaker-freeoffice-2018_974-01_amd64.deb
apt-get -y autoremove
apt-get clean all
