#!/bin/bash
###########################
#	retention saves		  #
#	Tcherno, 29/04/2021   #
#	Version : v2.0		  #
###########################

#SUPPRIME LES SAUVEGARDES DE PLUS DE 7 JOURS
find /nfs/web/ -type f -mtime +7 -exec rm {} \;
find /nfs/server_ic/ -type f -mtime +7 -exec rm {} \;