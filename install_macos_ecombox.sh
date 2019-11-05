#!/bin/sh
# Ce script lance des scripts qui automatisent l'installation des éléments nécessaires 
# à l'installation de l'application e-comBox sur Mac OS

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

ERREUR()
{
        echo -e "$COLERREUR"
        echo -e "ERREUR! Vous avez décidé de ne pas configurer e-comBox. Vous pouvez reprendre la procédure quand vous voulez"
	echo -e "$1"
        echo -e "$COLTXT"
        exit 1
}



POURSUIVRE()
{
        REPONSE=""
        while [ "$REPONSE" != "o" -a "$REPONSE" != "O" -a "$REPONSE" != "n" ]
        do
          echo -e "$COLTXT"
	  echo -e "Peut-on poursuivre (o par défaut) ? (${COLCHOIX}o/n${COLTXT}) $COLSAISIE\c"
	  read REPONSE
          if [ -z "$REPONSE" ]; then
	     REPONSE="o"
	  fi
        done
        if [ "$REPONSE" != "o" -a "$REPONSE" != "O" ]; then
	   ERREUR
	fi
}

#Gestion du proxy
echo -e "$COLTXT"
echo -e "Si vous disposez d'un proxy, veuillez saisir son adresse : $COLSAISIE\c"
echo -e "(Laisser vide et validez si pas de proxy sinon saisir ip-proxy:port) :"
read ADRESSE_PROXY

echo -e "$COLINFO"
echo -e "Vous vous apprêtez à utiliser les paramètres suivants:"
echo -e "Proxy :	$ADRESSE_PROXY"
echo -e "$COLCMD"

POURSUIVRE

if [ "$ADRESSE_PROXY" != "" ]; then
   echo -e "$COLDEFAUT"
   echo -e "Congiguration de GIT pour le proxy"
   sleep 2
   echo -e "$COLCMD\c"
   git config --global http.proxy http://$ADRESSE_PROXY
   git config --global https.proxy https://$ADRESSE_PROXY

   echo -e "export ALL_PROXY=$ADRESSE_PROXY" >> ~/.bash_profile
   export ALL_PROXY=$ADRESSE_PROXY
else
    echo -e "$COLINFO"
    echo "Aucun proxy configuré sur le système"
    echo -e "$COLCMD"
    git config --global --unset http.proxy
fi

clear
echo -e "$COLTITRE"
echo "************************************************************"
echo "*                 INSTALLATION DE L'ENVIRONNEMENT          *"
echo "************************************************************"

if [ "$ADRESSE_PROXY" != "" ]; then
    ruby -e "$(curl -x $ADRESSE_PROXY -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Installation de Docker et Docker-Compose
curl -fsSL https://raw.githubusercontent.com/siollb/e-comBox_scriptsMacOS/master/install_docker_docker-compose.sh -o install_docker_docker-compose.sh
bash install_docker_docker-compose.sh

#Installation d'e-comBox
curl -fsSL https://raw.githubusercontent.com/siollb/e-comBox_scriptsLinux/master/configure_application.sh -o configure_application.sh
bash configure_application.sh
