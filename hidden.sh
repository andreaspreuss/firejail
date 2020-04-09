#!/bin/bash
# Es macht keinen Sinn den kompletten Verzeichnisbaum rekursiv zu behandeln
# und in jedes Unterverzeichnis eine .hidden Datei zu setzen. Aus diesem Grund
# schreibt dieses Script die .hidden Datei in die vordefinierten Verzeichnisse.
# Script ausführbar machen mit sudo chmod u+x hidden.sh - starten mit sudo ./hidden.sh
# Andreas Preuß - 08.04.2020
# exceptDirs= proc sys
# Farben definieren
cred='\e[1;31m'
cgreen='\033[1;32m'
cblue='\033[36m'
cdefault='\033[0m'


# Vordefinierte Verzeichnisse, die selber und deren Inhalt versteckt werden soll.
dir_array='
.cache
/usr/bin
/boot 
/dev
/etc
/home
/usr/lib
/usr/lib32
/usr/lib64 
/usr/libx32
/lost+found
/media
/mnt
/QMC
/opt 
/root
/run
/sbin 
/tmp
/usr
/usr/sbin
/var 
/var/opt
/var/opt/thinlinc
/var/opt/thinlinc/sessions
/var/opt/thinlinc/sessions/charles01
/var/opt/thinlinc/sessions/charles02
/var/opt/thinlinc/sessions/charles03
/var/opt/thinlinc/sessions/charles04
/var/opt/thinlinc/sessions/charles05
/var/opt/thinlinc/sessions/charles06
/var/opt/thinlinc/sessions/charles07
/var/opt/thinlinc/sessions/charles08
/var/opt/thinlinc/sessions/charles09
/var/opt/thinlinc/sessions/charles10
/var/opt/thinlinc/sessions/charles11
/var/opt/thinlinc/sessions/charles12
/var/opt/thinlinc/sessions/charles13
/var/opt/thinlinc/sessions/charles14
/var/opt/thinlinc/sessions/charles15
/var/opt/thinlinc/sessions/charles16
/var/opt/thinlinc/sessions/charles17
/var/opt/thinlinc/sessions/charles18
/var/opt/thinlinc/sessions/charles19
/var/opt/thinlinc/sessions/charles20
/sys
/srv
/srv/opt
/srv/opt/thinlinc
'
# liest ein Verzeichnis ein und schreibt Inhalt zeilenweise in eine .hidden Datei
hidedir=$(ls -A > .hidden)

echo -e $cred
echo 
echo "-------- .hidden Dateien in Verzeichnisse schreiben --------"
echo 
echo -e $cdefault
cd /
startordner=$(pwd)
while true; do
    echo "  Skript um Dateien und Verzeichnisse fuer Thunar und Gnome zu verstecken "
    echo "Soll in die vorgegebenen Verzeichnisse eine .hidden Datei gespeichert werden?"
    echo
    echo "Bitte mit j oder n Bestaetigen!"
    echo "Oder alle .hidden Dateien loeschen mit l Bestaetigen"
    read -p "--> " jn
    echo -e $cgreen
    case $jn in
         [Jj]* ) 
         for i in ${dir_array[@]}; do
           echo -n "Datei wird geschrieben in:"
            echo $i
	    (cd "$i" && ls -A > .hidden)
           cd $startordner
	   done
	  echo -e $cgreen"-----------------"$cdefault
	  echo "Fertig"
	break;;
        	
	[Nn]* ) 
	 echo -e $cblue"Abgebrochen"$cdefault	
	exit;;
        
	[Ll]* )
	 cd $startordner
	  find ./* -type f -iname ".hidden" -exec rm -f {} \;
	  rm -f .hidden
	  echo -e $cred"Dateien geloescht"$cdefault
	exit;;
			
	* ) echo -e $cred"Bitte richtig Bestaetigen!"$cdefault;;
	esac
done


# alle .hidden Dateien wieder loeschen:
# sudo find ./* -type f -iname ".hidden" -exec rm -f {} \;
# sudo rm -f .hidden
#
# Obige Funktion grob in einer Zeile
# for d in /*/; do (cd "$d" && ls -A > .hidden); done
