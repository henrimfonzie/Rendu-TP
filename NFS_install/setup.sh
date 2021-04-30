#!/bin/bash
###########################
#	setup NFS			  #
#	Tcherno, 28/04/2021   #
#	Version : Beta R1.0	  #
###########################

echo "ATTENTION : Beta Release !"
#AVERTISSEMENT PRIVILEGES
[ "$UID" -eq 0 ] || { echo "Necessite une elevation."; exit 1;}  #vérifie qu'on lance en admin

#INSTALLATION NFS SERVEUR
apt-get -y install nfs-kernel-server
if [[ $? == 0 ]];then
	echo -e "Installation OK\nDebut configuration"
else
	echo -e "Erreur lors de l installation"; exit 1
fi

#CONFIGURATION DES DOSSIER ET DES DROITS
mkdir -p /nfs/web/ && mkdir /nfs/server_ic/
if [[ $? == 0 ]];then
	echo -e "Creation dossiers OK\nConfiguration des droits"
	sleep 1
	chmod 777 /nfs/web/ && chmod 777 /nfs/server_ic/
	if [[ $? == 0 ]];then
		echo -e "Configration dossiers OK\n"
		sleep 1
	fi
else
	echo -e "Erreur lors de la creation des partages"; exit 1
fi

#CONFIGURATION DU FICHIER DE PARTAGE
ok=0
echo "/nfs/web/ 192.168.0.11/24(rw,all_squash,anonuid=1000,anongid=1000,sync,no_subtree_check)" >> /etc/exports
if [[ $? == 0 ]];then
	echo -e "Configration partage web OK\n"
	((ok+=1))
fi
echo "/nfs/server_ic/ 192.168.0.12/24(rw,all_squash,anonuid=1000,anongid=1000,sync,no_subtree_check)" >> /etc/exports
if [[ $? == 0 ]];then
	echo -e "Configration partage Jenkins OK\n"
	((ok+=1))
fi
exportfs -ra
systemctl reload nfs-kernel-server.service
if [[ $ok == 2 ]];then
	echo -e "Configration service OK\n"
else
	echo -e "Erreur lors de la configuration du service nfs"
	exit 1
fi

#CONFIGURATION DU JOB DE SAUVEGARDE (LANCEMENT DU SCRIPT)

echo "35 0 */7 * * /usr/bin/rettsk.sh >> /var/log/retention_job.log" > /tmp/schdtsk
crontab /tmp/schdtsk
if [[ $? == 0 ]];then
	rm /tmp/schdtsk
	echo -e "Configration taches OK\n"
else
	echo "Erreur lors de la configuration crontab"; exit 1
fi