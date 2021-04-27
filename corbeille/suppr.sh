#!/bin/bash
###########################
#	Utilitaire corbeille  #
#	Tcherno, 26/04/2021   #
#	Version : v1.01		  #
###########################

#INITIALISATION DE LA CORBEILLE
#Si c'est la première fois que le script est lancé, la corbeille n'existe pas
corbeille="$HOME/.corbeille/"
arg1=$1
arg2=$2

if [[ ! -d "$corbeille" ]];then
	mkdir $corbeille
fi
#FONCTION DE SUPPRESSION
rem()
{
	if [[ -f $1 ]];then             #si c'est un fichier
                absrep=`readlink -f $1`	#lit le chemin absolut
                mv $1 $corbeille
                ficnom="${1##*/}"       #récupère le nom du fichier (cas où un chemin d'accès est four$
                info="$ficnom.info"
                echo $absrep > "$corbeille/.$info"      #crée le fichier .info
				if [[ $? == 0 ]];then
					echo -e "Fichier supprime"
				else
					echo -e "Erreur lors de la suppression"
				fi
        elif [[ -d $1 ]];then           #si c'est un dossier
                absrep=`readlink -f $1`
                mv $1 $corbeille                #prend en compte le cas d'un dossier non vide
                ficnom="$1"     #récupère le nom du fichier (cas où un chemin d'accès est fourni)
                info="${ficnom/%\//}.info" #épure le chemin d'accès en virant le "/" final
                echo $absrep > "$corbeille/.$info"      #crée le fichier .info
				if [[ $? == 0 ]];then
					echo -e "Dossier supprime"
				else
					echo -e "Erreur lors de la suppression"
				fi
        else
                echo -e "Parametre invalide"
        fi

}
#FONCTION D'INVENTAIRE
trash()
{
	ls $corbeille
}

#FONCTION DE RESTAURATION
restore()
{
	if [[ -e "$corbeille/$1" || -e "$corbeille/$1.info" ]];then  #si le fichier à restaurer existe
		info="$corbeille/.$1.info"			#on récupère le fichier *.info
		absrep=$(<$info)					#on récupère son contenu
		mv "$corbeille/$1" $absrep			#on restaure
		if [[ $? == 0 ]];then
			echo -e "Fichier restaure dans $absrep"
		else
			echo -e "Erreur lors de la restauration"
		fi
	else
		echo -e "Parametre invalide"
	fi
}

#PROGRAMME PRINCIPAL
#le programme principal vérifie l'entrée utilisateur

if [[ $# == 0 || -z $arg1 ]];then
	echo -e "Parametre invalide" 
fi	
	
case $arg1 in
	--rm)
		if [[ -z $arg2 ]];then
			echo -e "Parametre invalide"
		else	
			rem $arg2
		fi
	;;
	--trash)
		trash
	;;
	--restore)
	if [[ -z $arg2 ]];then
			echo -e "Parametre invalide"
		else	
			restore $arg2
		fi
	;;
	*)
		echo -e "Parametre invalide"
esac