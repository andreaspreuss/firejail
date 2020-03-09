#!/bin/bash -x
echo "Installation von Freeoffice"
wget -c https://www.softmaker.net/down/softmaker-freeoffice-2018_974-01_amd64.deb
dpkg -i softmaker-freeoffice-2018_974-01_amd64.deb
apt-get -y install qpdfview
# install firejail
apt-get install -y firejail firejail-profiles firetools
wget -c https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/softmaker-common.inc -P /etc/firejail/
wget -c https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/textmaker.profile -P /etc/firejail/
wget -c https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/presentations.profile -P /etc/firejail/
wget -c https://raw.githubusercontent.com/andreaspreuss/firejail/master/etc/firejail/planmaker.profile -P /etc/firejail/
echo "textmaker" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "presentations" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
echo "planmaker" >> /usr/lib/x86_64-linux-gnu/firejail/firecfg.config
# creating symlinks
ln -s /usr/share/freeoffice2018/textmaker /usr/bin/textmaker
ln -s /usr/share/freeoffice2018/planmaker /usr/bin/planmaker
ln -s /usr/share/freeoffice2018/presentations /usr/bin/presentations
# echo "$USER" >> /etc/firejail/firejail.users
# firejail initialisation desktop Integration
firecfg
# delete unused files
rm -rf softmaker-freeoffice-2018_974-01_amd64.deb
apt-get -y autoremove
apt-get -y clean all
