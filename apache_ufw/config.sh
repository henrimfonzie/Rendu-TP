#!/bin/bash
###########################
#	config pare-feu		  #
#	Tcherno, 27/04/2021   #
#	Version : v1.0		  #
###########################

#AVERTISSEMENT PRIVILEGES
[ "$UID" -eq 0 ] || { echo "Necessite une elevation."; exit 1;}

#INSTALLATION DU PAQUET UFW
apt-get install ufw

ufw allow ssh	#autorise la connexion ssh pour ne pas être définitivement éjecté
ufw allow in from any proto tcp to any port 80,443  #autorise le traffic http et https
ufw default deny		#refuse tout ce qui n'est pas autorisé
echo "y" | ufw enable
ufw status verbose
echo "Configuration pare-feu OK"