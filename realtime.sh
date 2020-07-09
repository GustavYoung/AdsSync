#!/bin/bash
# Actualizacion para anuncioe en nueva version uxmal realtime.
# Version Alpha 0.4 bugfix 001
#
#(C) 2020 Gustavo Santana
#For internal use only
#
#tput setab [1-7] Set the background colour using ANSI escape
#tput setaf [1-7] Set the foreground colour using ANSI escape
black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
white=`tput setaf 7`
bg_black=`tput setab 0`
bg_red=`tput setab 1`
bg_green=`tput setab 2`
bg_white=`tput setab 7`
ng=`tput bold`
reset=`tput sgr0`
#echo "${red}red text ${green}green text${reset}"
configfile='/home/uslu/AdsSync/sync.cfg'
configfile_secured='/tmp/sync.cfg'

# Elemento de seguridad previene el envenenamiento del archivo de configuracion
if egrep -q -v '^#|^[^ ]*=[^;]*' "$configfile"; then
    echo "El archivo de configuracion fue alterado, limpiando..." >&2
# Filtrar el contenido peligroso :S :P
    egrep '^#|^[^ ]*=[^;&]*'  "$configfile" > "$configfile_secured"
    configfile="$configfile_secured"
fi

# Ahora con todo limpio se puede continuar :)
. "$configfile"
echo "Leyendo configuración" >&2
echo "Version ${red}202${reset}" >&2
echo "Usuario del cliente en FTP:${green} $client_user${reset}" >&2
echo "Velocidad en kb/s: ${green}$ancho_banda${reset}" >&2

currsh=$0
currpid=$$
runpid=$(lsof -t $currsh| paste -s -d " ")
if [[ $runpid == $currpid ]]
then
        touch /home/uslu/realtime.lock
          ((sleep 3; echo "Ram OK") \
         & while !  rsync -avh -e "ssh -i /home/uslu/.ssh/id_rsa -p65522" --exclude "*.m3u" --include-from "/home/uslu/gstool/extensions.dll" --partial --bwlimit=1000 --delete --progress --log-file=/home/uslu/gstool/updatelogs/$(date +%Y%m%d)_realt.log uxm3@uxmde.uxmalstream.com:/home/uxm3/users/$client_user/ftp/ /home/uslu/gsign/imgs/dia/;
           do
               echo "Todo listo";
               exit;
           done )
      rm /home/uslu/realtime.lock
      exit;
else
    echo -e "\nPID($runpid)($currpid) ::: At least one of \"$currsh\" is running !!!\n"
    false
    exit 1
fi
