################################
#    A LIRE AVANT UTILISATION  #
#     (et jusqu'au bout)       #
################################

Les scripts sont chacun fournis avec une documentation :

/!\ LIRE INTEGRALEMENT LA DOCUMENTATION AVANT DE LANCER CHAQUE SCRIPT /!\

Nous n'avons pas eu le temps de faire un script capable gérer les déploiement de façon automatique, il faudra donc les lancer à la main.
Suivre les indications suivantes pour lancer les script dans l'ordre :

1) Serveur NFS :
_Récupérer le contenu de "NFS_install" sur le git
_placer "rettsk.sh" dans /usr/bin/
_lancer "setup.sh" 

2) Serveur web :
_Récupérer le contenu de "apache_install" sur le git
_Récupérer le contenu de "apache_UFW" sur le git
_Récupérer le contenu de "NFS_config_web" sur le git
_lancer "setup.sh"
_Lancer "config.sh"
_Placer "backuptsk.sh" dans /usr/bin/
_Lancer "nfsmount.sh"

3) Serveur Jenkins :
_Récupérer le contenu de "Server jenkins" sur le git
_Récupérer le contenu de "NFS_config_jenkins" sur le git
_Lancer "installjenkins.sh"
_Placer "backuptsk.sh" dans /usr/bin/
_Lancer "nfsmount.sh"

4) Poste de Dèv :
_Récupérer "Installation.sh" sur le git
_Récupérer le contenu de "corbeille" sur le git
_lancer "Installation.sh"
_Placer "suppr.sh" dans /usr/bin/
_Tester "suppr.sh"