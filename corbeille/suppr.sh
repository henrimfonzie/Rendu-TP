###########################
#	Utilitaire corbeille  #
#	Tcherno, 26/04/2021   #
#	Version : alpha		  #
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
        elif [[ -d $1 ]];then           #si c'est un dossier
                absrep=`readlink -f $1`
                mv $1 $corbeille                #prend en compte le cas d'un dossier non vide
                ficnom="$1"     #récupère le nom du fichier (cas où un chemin d'accès est fourni)
                echo $ficnom
                info="${ficnom/%\//}.info" #épure le chemin d'accès en virant le "/" final
                echo $info
                echo $absrep
                echo $absrep > "$corbeille/.$info"      #crée le fichier .info
        else
                echo -e "Chemin invalide"
        fi

}
#FONCTION D'INVENTAIRE
trash()
{
	ls $corbeille
}

#FONCTION DE RESTAURATION
restore()


#PROGRAMME PRINCIPAL
#le programme principal vérifie l'entrée utilisateur

if [[ $? == 0 || -z $arg1 || -z $arg2 ]];then
	echo -e "Parametre invalide" 
fi	
	
case $arg1 in
	--rm)
		rem $arg2
	;;
	--trash)
		trash
	;;
	--restore)
		restore $arg2
	;;
	*)
		echo -e "Parametre invalide"
esac