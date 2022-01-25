#!/bin/bash
#Copyright 2018 Gustavo Santana
#(C) Mirai Works LLC
#Desactivamos el puto cursor >P
sleep 35;
# Como han eliminado el crontab de la rasp este lanzador va a mantener los anuncios frescos 
# Va a ser lanzado por un crotnab al comienzo de la carga del sistema operativo y ya liberada la carga
# deberia convertirse en un elemento persistente en la operacion del sistema operativo
# en caso de que esto no funcione se convertira en un servicio con ayuda de systemd
# Nombre de instancia para que no choque con la de uxmalstream
SERVICE="Elements_v7_launch";

# infinite loop!
while true; do
        if ps ax | grep -v grep | grep $SERVICE > /dev/null
        then
        sleep 10;
else
        sudo bash /home/uslu/AdsSync/adssync_main.sh;
        date;
        sleep 600;
#       done
fi
done
