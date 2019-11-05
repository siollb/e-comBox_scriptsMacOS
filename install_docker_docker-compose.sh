#!/bin/sh
# Ce script lance des scripts qui automatise l'installation de Docker et Docker-Compose

# Couleurs
COLTITRE="\033[1;35m"   # Rose
COLPARTIE="\033[1;34m"  # Bleu
COLTXT="\033[0;37m"     # Gris
COLCHOIX="\033[1;33m"   # Jaune
COLDEFAUT="\033[0;33m"  # Brun-jaune
COLSAISIE="\033[1;32m"  # Vert
COLCMD="\033[1;37m"     # Blanc
COLERREUR="\033[1;31m"  # Rouge
COLINFO="\033[0;36m"    # Cyan

clear
echo -e "$COLTITRE"
echo "************************************************************"
echo "*         INSTALLATION DE DOCKER ET DOCKER-COMPOSE         *"
echo "************************************************************"



# Installation de Docker
# Utilisation du script officiel fourni par Docker 
# https://github.com/docker/docker-install pour Docker

echo -e ""
echo -e "$COLPARTIE"
echo -e "Installation de Docker et Docker-Compose"
echo -e ""

echo -e "$COLCMD"
brew cask install docker

sleep 2
#On lance l'application Docker Desktop afin de démarrer le démon
open --background -a Docker

#On attend que la vm docker démmarre
sleep 50

echo -e ""
echo -e "$COLINFO"
echo -e "Docker et Docker-Compose sont installés"
echo -e "Le script va maintenant procéder à l'installation de e-comBox"
echo -e ""

echo -e "$COLCMD"


