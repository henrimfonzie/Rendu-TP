#!/bin/bash
###########################
#	montage web			  #
#	Tcherno, 28/04/2021   #
#	Version : beta		  #
###########################

#AVERTISSEMENT PRIVILEGES
[ "$UID" -eq 0 ] || { echo "Necessite une elevation."; exit 1;}  #vérifie qu'on lance en admin

#INSTALLATION NFS CLIENT
apt-get -y install nfs-common

#CONFIGURATION DES DOSSIER ET DES DROITS
if [[ ! -d /media/web/ ]];then
	mkdir /media/web/
	if [[ $? == 0 ]];then
		echo -e "Creation dossier OK\nConfiguration des droits"
		sleep 1
		chmod 777 /media/web/
		if [[ $? == 0 ]];then
			echo -e "Configration dossier OK\n"
			sleep 1
		fi
	else
		echo -e "Erreur lors de la creation des partages"; exit 1
	fi
else
	if stat -c "%a" /media/web/ != 777;then
		chmod 777 /media/web/
	fi
fi

#CONFIGURATION DU JOB DE SAUVEGARDE (LANCEMENT DU SCRIPT)

echo "0 * * * * /usr/bin/backuptsk.sh >> /var/log/backup_web.log 2>&1" > /tmp/schdtsk
crontab /tmp/schdtsk
if [[ $? == 0 ]];then
	rm /tmp/schdtsk
	echo -e "Configration taches OK\n"
else
	echo "Erreur lors de la configuration crontab"; exit 1
fi

#CONFIGURATION DU POINT DE MONTAGE

if  grep -i -q "/media/web/" /etc/fstab;then  #evite d'insérer plusieurs fois la ligne en cas de tests multiples.
		echo -e "Configration OK\n"; exit 0
	else
		sed -i "/#VAGRANT-BEGIN$/i 192.168.0.13:/nfs/web/ /media/web/ nfs defaults,user,auto,_netdev,bg 0 0" /etc/fstab  #insert une ligne avant #VAGRANT-BEGIN
		echo -e "Configration montage OK"
fi