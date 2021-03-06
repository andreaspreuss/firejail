# Firejail profile for softmaker-common
# This file is overwritten after every install/update
# Persistent local customizations
include softmaker-common.local
# Persistent global definitions
# added by caller profile
#include globals.local

# The offical packages install the desktop file under /usr/local/share/applications
# with an absolute Exec line. These files are NOT handelt by firecfg,
# therefore you must manualy copy them in you home and remove '/usr/bin/'.
# textmaker18free
# planmaker18free
# presentations18free

noblacklist ${HOME}/SoftMaker

include /etc/firejail/disable-common.inc
include /etc/firejail/disable-devel.inc
# include /etc/firejail/disable-exec.inc
# include /etc/firejail/disable-interpreters.inc
include /etc/firejail/disable-passwdmgr.inc
# include /etc/firejail/disable-programs.inc

# whitelist /usr/share/office2018
# whitelist /usr/share/freeoffice2018
include /etc/firejail/whitelist-common.inc
# include /etc/firejail/whitelist-var-common.inc

blacklist /mnt
blacklist /media

# apparmor
caps.drop all
# ipc-namespace
net none
# nodbus
nodvd
# nogroups
nonewprivs
noroot
notv
novideo
seccomp
shell none
tracelog

private-bin freeoffice-planmaker,freeoffice-presentations,freeoffice-textmaker,planmaker18,planmaker18free,presentations18,presentations18free,sh,textmaker18,textmaker18free,textmaker,presentations,planmaker
private-cache
private-dev
private-etc ca-certificates,fonts,ld.so.cache,ld.so.conf,ld.so.conf.d,ld.so.preload,machine-id,nsswitch.conf,pki,SoftMaker,ssl
private-tmp

# memory-deny-write-execute
# noexec ${HOME}
# noexec /tmp
# name firejailed-softmakeroffice
# join-or-start /usr/bin/ %f
