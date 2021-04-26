###########################
#	Utilitaire corbeille  #
#	Tcherno, 26/04/2021   #
#	Version : alpha		  #
###########################

#INITIALISATION DE LA CORBEILLE
#Si c'est la première fois que le script est lancé, la corbeille n'existe pas
corbeille="$HOME/.corbeille/"
if [[ ! -d "$corbeille" ]];then
	mkdir $corbeille
fi
#FONCTION DE SUPPRESSION
rem()
{
	if [[ -f $2 ]];then		#si c'est un fichier
		mv $2 $corbeille
		ficnom="$2/${1##*/}"	#récupère le nom du fichier (cas où un chemin d'accès est fourni)
		ficnom=ficnom+".info"
		echo $ficnom > $corbeille/$ficnom	#crée le fichier .info
	elif [[ -d $2 ]];then		#si c'est un dossier
		mv - $2 $corbeille		#prend en compte le cas d'un dossier non vide
		ficnom="$2/${1##*/}"	#récupère le nom du fichier (cas où un chemin d'accès est fourni)
		ficnom=ficnom+".info"
		echo $ficnom > $corbeille/$ficnom	#crée le fichier .info
	else
		echo -e "Chemin invalide"
	fi
}
#FONCTION D'INVENTAIRE
trash()
{
	ls -l $corbeille
}

#FONCTION DE RESTAURATION