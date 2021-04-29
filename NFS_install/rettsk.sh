#!/bin/bash
###########################
#	retention saves		  #
#	Tcherno, 29/04/2021   #
#	Version : v1.0		  #
###########################

#SUPPRIME LES SAUVEGARDES DE PLUS DE 7 JOURS
find /media/web/ -type f -mtime +7 -exec rm {} \;