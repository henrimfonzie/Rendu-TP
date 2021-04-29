#!/bin/bash
###########################
#	setup apache		  #
#	Tcherno, 27/04/2021   #
#	Version : v1.02		  #
###########################

ok=0
[ "$UID" -eq 0 ] || { echo "Necessite une elevation."; exit 1;}
#installation des paquets et dépendances
apt-get install -y apache2

#vérifie le service
systemctl enable apache2
if [[ $? == 0 ]];then
	echo -e "Configuration service OK\n"
	((ok+=1))
fi
sudo systemctl restart apache2
if [[ $? == 0 ]];then
	echo -e "Redemarrage service OK\n"
	((ok+=1))
fi

if [[ $ok == 2 ]];then
	echo -e "installation Apache OK\nDebut configuration"
	sleep 1
else
	echo -e "Erreur lors de l\'installation"
	exit 1
fi

#Ecriture de la index.html
ok=0
echo -e '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">\n<html>\n<head>\n<title>Ma première page avec du style</title>\n</head>\n<body>\n<!-- Menu de navigation du site -->\n<ul class="navbar">\n<li><a href="index.html">Home page</a>\n</ul>\n<!-- Contenu principal -->\n<h1>Ma première page avec du style</h1>\n<p>Bienvenue sur ma page avec du style!</p>\n' > /var/www/html/index.html
if [[ $? == 0 ]];then
	((ok+=1))
fi
echo -e "<p>Il lui manque des images, mais au moins, elle a du style. Et elle a des liens, même s'ils ne mènent nulle part...</p>\n" >> /var/www/html/index.html
if [[ $? == 0 ]];then
	((ok+=1))
fi
echo -e '&hellip;\n<p>Je devrais étayer, mais je ne sais comment encore.</p>\n' >> /var/www/html/index.html
if [[ $? == 0 ]];then
	((ok+=1))
fi
echo -e '<!-- Signer et dater la page, ' >> /var/www/html/index.html
if [[ $? == 0 ]];then
	((ok+=1))
fi
echo -e "c'est" >> /var/www/html/index.html
if [[ $? == 0 ]];then
	((ok+=1))
fi
echo -e 'une question de politesse! -->\n<address>Fait le 22 avril 2021<br>\npar moi.</address>\n</body>\n</html>' >> /var/www/html/index.html
if [[ $? == 0 ]];then
	((ok+=1))
fi
if [[ $ok == 6 ]];then
	echo -e "Page creee avec succes\n"
	sleep 1
else
	echo -e "Erreur lors de la creation de la page"
	exit 1
fi

#change le groupe sur le dossier web
ok=0
chgrp -fR www-data /var/www/html/
if [[ $? == 0 ]];then
	((ok+=1))
fi
chmod -fR 770 /var/www/html/
if [[ $? == 0 ]];then
	((ok+=1))
fi
if [[ $ok == 2 ]];then
	echo -e "Configuration droits /var/www/html/ OK\nConfiguration apache2 terminee"
else
	echo -e "Erreur lors de la configuration de /var/www/html/"
	exit 1
fi