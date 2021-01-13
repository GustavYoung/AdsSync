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

#Variables para carpetas
uxmal2_native='/home/uslu/uxmalstream/streamer/'
uxmal2_mgrtd='/home/uslu/uxmal_2.0/'
virtual_native='/home/uslu/uxmalstream/streamer/uploads/ads/ad1'
virtual_mgrtd='/home/uslu/uxmal_2.0/uploads/ads/ad1'
lv_imgflot_nat='/home/uslu/uxmalstream/streamer/uploads/pngads'
lv_imgflot_mgt='/home/uslu/uxmal_2.0/uploads/pngads'
lv_adsflot_nat='/home/uslu/uxmalstream/streamer/uploads/floatingads'
lv_adsflot_mgt='/home/uslu/uxmal_2.0/uploads/floatingads'
target_fix='/home/uslu/uxmalstream/streamer/uploads'
i_native=0
i_native_ok=0
i_mgrtd=0
i_mgrtd_ok=0

#Comprobacion de carpetas 10/09/2020
if [ -d "$uxmal2_mgrtd" ]; then
  echo "App migrada :S revisando foldets y link virtual"
#Comprobacion de Link virtual memorias migradas.
while [ $i_mgrtd_ok -lt 5 ]
do
  target_fix='/home/uslu/uxmal_2.0/uploads'
  echo "Intentos: $i_mgrtd"
  ((i_mgrtd++));
  if [ ! -L "${virtual_mgrtd}" ]
  then
     echo "%ERROR: El link ${virtual_mgrtd} no es valido!" >&2
     echo "Reparando link virtual"
     sudo rm -rf /home/uslu/uxmal_2.0/uploads/ads/ad1;
     sudo ln -s /home/uslu/elements/Spots_con_audio/ /home/uslu/uxmal_2.0/uploads/ads/ad1;
     else
     echo "Link ad1 Valido!!!";
     i_mgrtd_ok=11;
  fi
  if [ ! -L "${lv_imgflot_mgt}" ]
  then
     echo "%ERROR: El link ${lv_imgflot_mgt} no es valido!" >&2
     echo "Reparando link virtual"
     sudo rm -rf /home/uslu/uxmal_2.0/uploads/floatingads;
     sudo ln -s /home/uslu/elements/imagenes-flotantes/ /home/uslu/uxmal_2.0/uploads/pngads;
     else
     echo "Link imagenes flotantes Valido!!!";
     i_mgrtd_ok=11;
  fi     
  if [[ "$i_mgrtd_ok" == '11' ]]; then
    break
  fi
  if [ ! -L "${lv_adsflot_mgt}" ]
  then
     echo "%ERROR: El link ${lv_adsflot_mgt} no es valido!" >&2
     echo "Reparando link virtual"
     sudo rm -rf /home/uslu/uxmal_2.0/uploads/floatingads;
     sudo ln -s /home/uslu/elements/Spots_sin_audio/ /home/uslu/uxmal_2.0/uploads/floatingads;
     else
     echo "Link imagenes flotantes Valido!!!";
     i_mgrtd_ok=11;
  fi     
  if [[ "$i_mgrtd_ok" == '11' ]]; then
    break
  fi
done
  clear;
fi
if [ -d "$uxmal2_native" ]; then
  echo "App nativa :)";
  #Comprobacion de Link virtual memorias nativas.
while [ $i_native_ok -lt 5 ]
do
  target_fix='/home/uslu/uxmalstream/streamer/uploads'
  echo "Intentos: $i_native"
  ((i_native++));
  if [ ! -L "${virtual_native}" ]
  then
     echo "%ERROR: El link ${virtual_native} no es valido!" >&2
     echo "Reparando link virtual"
     sudo rm -rf /home/uslu/uxmalstream/streamer/uploads/ads/ad1;
     sudo ln -s /home/uslu/elements/Spots_con_audio/ /home/uslu/uxmalstream/streamer/uploads/ads/ad1;
     else
     echo "Link ad1 Valido!!!";
     i_native_ok=11;
  fi
  if [ ! -L "${lv_imgflot_nat}" ]
  then
     echo "%ERROR: El link ${lv_imgflot_nat} no es valido!" >&2
     echo "Reparando link virtual"
     sudo rm -rf /home/uslu/uxmalstream/streamer/uploads/floatingads;
     sudo ln -s /home/uslu/elements/imagenes-flotantes/ /home/uslu/uxmalstream/streamer/uploads/pngngads;
     else
     echo "Link imagenes flotantes Valido!!!";
     i_mgrtd_ok=11;
  fi      
  if [[ "$i_native_ok" == '11' ]]; then
    break
  fi
  if [ ! -L "${lv_adsflot_nat}" ]
  then
     echo "%ERROR: El link ${lv_adsflot_nat} no es valido!" >&2
     echo "Reparando link virtual"
     sudo rm -rf /home/uslu/uxmalstream/streamer/uploads/floatingads;
     sudo ln -s /home/uslu/elements/Spots_sin_audio/ /home/uslu/uxmalstream/streamer/uploads/floatingads;
     else
     echo "Link imagenes flotantes Valido!!!";
     i_mgrtd_ok=11;
  fi      
  if [[ "$i_native_ok" == '11' ]]; then
    break
  fi
done
  clear;
fi

# crea carpetas nuevas 

mkdir $target_fix/parallelads/pl1/
mkdir $target_fix/parallelads/pl1/defaultpngs/
clear;

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
echo "Version ${red}204 10/09/2020${reset}" >&2
echo "Usuario del cliente en FTP:${green} $client_user${reset}" >&2
echo "Velocidad en kb/s: ${green}$ancho_banda${reset}" >&2

currsh=$0
currpid=$$
runpid=$(lsof -t $currsh| paste -s -d " ")
if [[ $runpid == $currpid ]]
then
        touch /home/uslu/AdsSync.lock
        RC=1 
        while [[ $RC -ne 0 ]]
        do
        rsync -avh -e "ssh -i /home/uslu/.ssh/id_rsa -p65522" --exclude "*.m3u" --exclude "/home/uslu/uxmalstream/streamer/uploads/genres" --include-from "/home/uslu/gstool/extensions.dll" --partial --bwlimit="$ancho_banda" --delete --progress --log-file=/home/uslu/AdsSync/updatelogs/$(date +%Y%m%d)_realt.log uxm3@uxmde.uxmalstream.com:{/home/uxm3/users/$client_user/contenidos/Spots_con_audio,/home/uxm3/users/$client_user/contenidos/Spots_sin_audio,/home/uxm3/users/$client_user/contenidos/imagenes-flotantes} /home/uslu/elements/;
        RC=$?
        if [[ $RC -eq 23  ]] || [[ $RC -eq 20 ]]
        then RC=0
        fi
        done
        echo "Anuncios sin/con audio e imagenes flotantes OK";
        RC=1 
        while [[ $RC -ne 0 ]]
        do
        rsync -avh -e "ssh -i /home/uslu/.ssh/id_rsa -p65522" --exclude "*.m3u" --include-from "/home/uslu/gstool/extensions.dll" --partial --bwlimit="$ancho_banda" --delete --progress --log-file=/home/uslu/AdsSync/updatelogs/$(date +%Y%m%d)_realt.log uxm3@uxmde.uxmalstream.com:/home/uxm3/users/$client_user/contenidos/Banners/ $target_fix/parallelads/pl1/defaultpngs/;
        RC=$?
        if [[ $RC -eq 23  ]] || [[ $RC -eq 20 ]]
        then RC=0
        fi
        done
        echo "Banners OK";
        RC=1 
        while [[ $RC -ne 0 ]]
        do
        rsync -avh -e "ssh -i /home/uslu/.ssh/id_rsa -p65522" --exclude "*.m3u" --exclude 'defaultpng*' --include-from "/home/uslu/gstool/extensions.dll" --partial --bwlimit="$ancho_banda" --delete --progress --log-file=/home/uslu/AdsSync/updatelogs/$(date +%Y%m%d)_realt.log uxm3@uxmde.uxmalstream.com:/home/uxm3/users/$client_user/contenidos/Video_chico/ $target_fix/parallelads/pl1/;
        RC=$?
        if [[ $RC -eq 23  ]] || [[ $RC -eq 20 ]]
        then RC=0
        fi
        done
        echo "Video chico OK";
        echo "Todo listo";
      rm /home/uslu/AdsSync.lock
      exit;
else
    echo -e "\nPID($runpid)($currpid) ::: At least one of \"$currsh\" is running !!!\n"
    false
    exit 1
fi