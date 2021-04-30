#!/bin/sh

#créer les dossiers de destination des disques
(echo n
echo p
echo
echo
echo
echo t
echo
echo 83
echo w)| sudo fdisk /dev/sdb

#creer une partition ext4 sur chacun des disques sdb

sudo mkfs.ext4 /dev/sdb1

# On met à jour le systeme pour pouvoir insaller
sudo apt update -y

# Installer le pré-requis Java 

sudo apt install openjdk-11-jdk -y

#Installation de gnup

sudo apt -y install gnupg

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

sudo useradd userjob

## Lui donner les permissions (via le fichier sudoers) d'utiliser apt (et seulement apt pas l'ensemble des droits admin)

sudo cp /etc/sudoers /etc/sudoers.old

# Permissions utilisation apt à userjob
sudo cp /etc/sudoers /etc/sudoers.old
sudo su -c "echo 'userjob  ALL=/usr/bin/apt' >> /etc/sudoers"

# Afficher à la fin de l'execution du script le contenu du fichier /var/jenkins_home/secrets/initialAdminPassword pour permettre de récupérer le mot de passe

sudo cat /var/jenkins_home/secrets/initialAdminPassword

# que le port utilisé pour la connexion ssh

sudo apt -y install ufw
 
#Installer un pare-feu (genre UFW)

echo y | sudo ufw enable

# allow port 8080
sudo ufw allow 8080

# allow port 22
sudo ufw allow 22

# ouvrir le SSH

sudo ufw allow OpenSSH

# Connexion ssh

sudo ufw allow ssh 

# Refuser le trafic entrant suivant les règles par défaut

sudo ufw default deny

# status

sudo ufw status

# Afficher /var/jenkins_home/secrets/initialAdminPassword pour récuperer le mot de passe

sudo cat /var/lib/jenkins/secrets/initialAdminPassword 