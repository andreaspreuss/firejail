## Firejail Profildatei fuer WPS Office 2019 (11.2.0.9107)
## Description: Kostenlose chinesische Bürosoftware der Kingsoft Corporation
## Diese Datei wird nach jeder Installation/Aktualisierung überschrieben !!!
## Persistente lokale Anpassungen
include wps.local
## Persistente globale Definitionen
include globals.local
## Name: Andreas Preuss
## 13.05.2020
## Version 1.0
## ---------------------------------------------------------------
## Zugriff deaktivieren
# Zugangsverbot zu Systemmanagement Werkzeugen (sudo, mount, etc.) 
# muss bei Verwendung von Thinlinc Server deaktiviert bleiben!
include /etc/firejail/disable-common.inc 

# Zugangsverbot zu Systemprogrammen ${HOME} 
include /etc/firejail/disable-programs.inc 

# Zugangsverbot zu Passwort Manager Dateien 
include /etc/firejail/disable-passwdmgr.inc 

# Zugangsverbot zu Entwickler Werkzeugen
include /etc/firejail/disable-devel.inc

# Zugangsverbot zu Interpretern
include /etc/firejail/disable-interpreters.inc

# Anwendung unabhängig vom Terminal gestellt
include /etc/firejail/disable-xdg.inc

# include whitelist-var-common.inc
# nix whitelist nur blacklist

# Erlaubte Pfade von WPS Office
noblacklist /usr/local/sbin
noblacklist /opt/kingsoft
noblacklist /usr/share/fonts/wps-fonts
noblacklist /usr/share/fonts/wps-office
noblacklist ${HOME}/.local/share/Kingsoft
noblacklist ${HOME}/.config/Kingsoft
noblacklist ${HOME}/.wps
noblacklist ${HOME}/.cache
noblacklist ${HOME}/.kingsoft
noblacklist ${DOCUMENTS}
noblacklist ${HOME}/Vorlage
noblacklist ${HOME}/.local/share/wineprefixes/qmc/drive_c/TMP/

# WPS - SCHREIBSCHUTZ
noblacklist ${HOME}

## Sicherheitsfilter 
# Schwarze Liste aller Linux-Funktionen
apparmor
# Root-Rechte werden unwiderruflich aufgegeben
caps.drop all 
# Stellt sicher, dass Child-Prozesse keine neuen Privilegien erhalten 
nonewprivs 
# Kein Root-Konto. Nur der aktuelle Benutzer
noroot 
# Zusätzliche Gruppen deaktivieren
nogroups
# Protokollfilter für Unix-Sockets und IPv4/IPv6
protocol unix
# Das Programm direkt, ohne eine Benutzershell, ausführen 
shell none 
# Standardmäßig den seccomp-Filter aktivieren und die Syscalls auf eine
#  schwarze Liste setzen - PID hängt allerdings wenn aktiviert!
seccomp

# kein Internet
net none                            

# Kein Sound
nosound

# Kein 3D
no3d

# Keine DVD Medien
nodvd

# Keine Videomedien
novideo

# Kein TV 
notv

# tracelog
nodbus

## Dateisystem
# Ein neues Heimverzeichnis erstellen, das nach Abschluss der Anwendung wieder gelöscht wird.
# Bei Aktivierung startet immer das WPS Lizenzpopup beim Start
# private 

# Erstellt neues /bin Verzeichnis. 
# Dadurch werden bestimmte Binärdateien in /usr/bin auf die Whitelist gesetzt und alles andere auf die schwarze Liste gesetzt.
private-bin bash,dirname,env,expr,file,grep,rm,sh,et,wps,wpp,wpspdf

# Einen leeren cache in einem temporären Dateisystem erzeugen
private-cache

# Dies stellt Dateien/Geräte unter /dev auf eine Whitelist und alles andere auf eine schwarze Liste
private-dev 

# Erstellet ein neues /etc-Verzeichnis in einem temporären Dateisystem
private-etc ssl

# Erstellet ein neues /lib-Verzeichnis 
# Muss bei Verwendung von Thinlinc-Server deaktiviert bleiben!
# private-lib libtinfo.so.6

# Ein leeres temporäres Dateisystem über dem Verzeichnis /tmp einhängen
private-tmp 

# Dadurch wird der Zugriff auf andere Laufwerke, einschließlich Wechselmedien unterbunden.
disable-mnt 

# Blacklist 
blacklist /boot 
blacklist /media 
blacklist /root 
blacklist ${HOME}/.local/share/Kingsoft/WPS Cloud Files
blacklist ~/.mozilla
blacklist ~/Dokumente
blacklist ~/Downloads
blacklist ~/Musik
blacklist ~/SoftMaker
blacklist ~/Öffentlich
blacklist ~/Schreibtisch
blacklist ${MUSIC}
blacklist ${VIDEOS}
blacklist ${DOWNLOADS}
blacklist ${DESKTOP}
blacklist ~/Bilder
blacklist ${PICTURES}
blacklist ~/Vorlagen

## Networking 
# Standardnetzwerkfilter für neu erstellte Netzwerk-Namensräume
# wird nicht benötigt weil ja keine Verbindung 
# netfilter

# Ausführen und Starten Verboten
noexec ${HOME}
noexec /tmp
name firejailed-wps
# join-or-start /usr/bin/wps %F
