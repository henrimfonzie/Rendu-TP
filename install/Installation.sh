#!/usr/bin/env bash

#parametre

set -u # en cas de variable non définie, arreter le script
set -e # en cas d'erreur (code de retour non-zero) arreter le script

# Installation python3.9

sudo apt -y update

sudo apt -y upgrade

# Installation python3-pip

sudo apt -y update

sudo apt install -y python3-pip

# Installation python3-dev

sudo apt -y update

sudo apt install -y python3-dev

# Installation git

sudo apt -y update

sudo apt-get install git

# Installation  visual studio code

sudo apt -y update

# Tout d'abord, mettez à jour l'index des packages
sudo apt update sudo apt install software-properties-common apt-transport-https wget

#importation de la clé Microsoft GPG à l'aide de la commande wget suivante
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

# activez le référentiel de code Visual Studio
sudo add-apt-repository "deb https://packages.microsoft.com/repos/vscode stable main"

# installation de  la dernière version de Visual Studio

sudo apt install code

# mise a jour

sudo apt list --upgradable