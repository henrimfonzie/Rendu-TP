#!/bin/sh

echo #################
echo                  
echo #################

# On met à jour le systeme pour pouvoir insaller

sudo apt update -y

#créer les dossiers de destination des disques
 sudo fdisk /dev/sdb

#creer une partition ext4 sur chacun des disques sdb

sudo mkfs.ext4 /dev/sdb1

# Installer le pré-requis Java 

sudo apt install openjdk-11-jdk

# Installer la version stable de Jenkins et ses prérequis en suivant la documentation officielle : https://www.jenkins.io/doc/book/installing/linux
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt-get -y update

sudo apt-get -y install jenkins

# Démarrage de Jenkins

sudo systemctl start jenkins

# Démarrage de Jenkins au démarrage de la machine

sudo systemctl enable jenkins

# Vérifier l'état du service Jenkins

sudo systemctl status jenkins

# Verification du démarrage en local

wget localhost

# Créer l'utilisateur user job

sudo adduser userjob

## Lui donner les permissions (via le fichier sudoers) d'utiliser apt (et seulement apt pas l'ensemble des droits admin)

sudo cp /etc/sudoers /etc/sudoers.old

# Permissions utilisation apt à userjob

sudo cat /etc/sudoers |
        sudo echo "userjob      ALL(ALL)/bin/apt," >> sudo tee -a /etc/sudoers

# Afficher à la fin de l'execution du script le contenu du fichier /var/jenkins_home/secrets/initialAdminPassword pour permettre de récupérer le mot de passe

sudo cat /var/jenkins_home/secrets/initialAdminPassword

# que le port utilisé pour la connexion ssh

sudo apt -y install ufw

#Installer un pare-feu (genre UFW)

echo y | sudo ufw enable

# Install iptables

sudo apt install -y iptables
 
# Ouvertures des ports 80 pour jenkins et 22 pour le connexion

sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# ouvrir le SSH

sudo ufw allow ssh

# Connexion ssh

sudo ufw allow ssh 

# Refuser le trafic entrant suivant les règles par défaut

sudo ufw default deny incoming

# status

sudo ufw status

# Afficher /var/jenkins_home/secrets/initialAdminPassword pour récuperer le mot de passe

sudo cat /var/lib/jenkins/secrets/initialAdminPassword 