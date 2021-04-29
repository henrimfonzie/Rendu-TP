#!/bin/bash
###########################
#	backup web			  #
#	Tcherno, 29/04/2021   #
#	Version : v1.0		  #
###########################

#PROGRAMME PRINCIPAL

nom="serveur_web_"
nom=$nom$(date +%d_%m_%Y) #pour le nom et la date du jour
nom="$nom.tar.gz"		#pour l'extension
tar czf /media/web/$nom /var/www/html  #compresse dans le dossier nfs
if [[ $? == 0 ]];then
	echo -e "Sauvegarde effectuee"
else
	echo -e "Erreur lors de la sauvegarde"
fi