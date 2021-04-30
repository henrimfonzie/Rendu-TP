#!/bin/bash
###########################
#	montage jenkins		  #
#	Tcherno, 28/04/2021   #
#	Version : Beta R1.0	  #
###########################

echo "ATTENTION : Beta Release !"

#AVERTISSEMENT PRIVILEGES
[ "$UID" -eq 0 ] || { echo "Necessite une elevation."; exit 1;}  #vérifie qu'on lance en admin

#INSTALLATION NFS CLIENT
apt-get -y install nfs-common

#CONFIGURATION DES DOSSIER ET DES DROITS
if [[ ! -d /media/server_ic/ ]];then	#vérifie que le dossier n'existe pas
	mkdir /media/server_ic/
	if [[ $? == 0 ]];then
		echo -e "Creation dossier OK\nConfiguration des droits"
		sleep 1
		chmod 777 /media/server_ic/		#donne des droits permissifs pour pouvoir écrire dedans
		if [[ $? == 0 ]];then
			echo -e "Configration dossier OK\n"
			sleep 1
		fi
	else
		echo -e "Erreur lors de la creation des partages"; exit 1
	fi
else
	if stat -c "%a" /media/server_ic/ != 777;then  #Si le dossier existe déjà, vérifier/appliquer les droits
		chmod 777 /media/server_ic/
	fi
fi

#CONFIGURATION DU JOB DE SAUVEGARDE (LANCEMENT DU SCRIPT)

echo "0 * * * * /usr/bin/backuptsk.sh >> /var/log/backup_jenkins.log 2>&1" > /tmp/schdtsk  #écrit la tâche dans un fichier temporaire
crontab /tmp/schdtsk	#crée la tâche via le fichier
if [[ $? == 0 ]];then
	rm /tmp/schdtsk
	echo -e "Configration taches OK\n"
else
	echo "Erreur lors de la configuration crontab"; exit 1
fi

#CONFIGURATION DU POINT DE MONTAGE

if  grep -i -q "/media/server_ic/" /etc/fstab;then  #evite d'insérer plusieurs fois la ligne en cas de tests multiples.
		echo -e "Configration OK\n"; exit 0
	else
		sed -i "/#VAGRANT-BEGIN$/i 192.168.0.13:/nfs/server_ic/ /media/server_ic/ nfs defaults,user,auto,_netdev,bg 0 0" /etc/fstab  #insert une ligne avant #VAGRANT-BEGIN
		echo -e "Configration montage OK"
fi

