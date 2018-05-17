# Zotero standalone installer for Linux (Installeur de Zotero Standalone pour Gu/linux)

Copyright 2011-2018 Sebastiaan Mathôt
Francisation MagicVince

- <http://www.cogsci.nl/smathot>
- <http://www.cogsci.nl/qnotero>

## A propos

Ceci est un installateur automatisé déploiera Zotero sur un système Linux. Un paquetage pour Ubuntu basé sur cet installeur est disponible (mais dans sa version originale, non traduite par mes soins)

## Utilisation de l'installeur

Télécharger le script zotero_installer.sh et l'exécuter. Il se chargera de télécharger la version "Standalone" de Zotero pour l'extraire dans le répertoire /opt/zotero (installation globale pour tous les utilisateurs du postes) ou /home/[user]/zotero (installation locale, juste pour l'utilisateur installant). L'installeur créera aussi les entrées dans le menu de l'interface graphique du système.

	wget https://raw.github.com/smathot/zotero_installer/master/zotero_installer.sh -O /tmp/zotero_installer.sh
	chmod +x /tmp/zotero_installer.sh
	/tmp/zotero_installer.sh

## Utilisation d'un PPA pour Ubuntu (et dérivées)

Les utilisateurs·utilisatrices d'Ubuntu peuvent installer la version "Standalone" de Zotero en ajoutantle PPA <https://launchpad.net/~smathot/+archive/cogscinl>  depuis le dépôt de Cogsci.nl . Le paquet debian est un simple emballage de l'installeur automatisé, mais facilite peut-être la notification des mises à jours des nouvelles versions de zotero.

Pour installer la version "Standalone " de Zotero depuis son PPA, merci de suivre les commandes suivantes dans un terminal:

	sudo add-apt-repository ppa:smathot/cogscinl
	sudo apt-get update
	sudo apt-get install zotero-standalone

## Licence

Cet installeur est sous General Public License v3. Pour plus d'informations, voir le fichier `COPYING` ou visiter <http://www.gnu.org/licenses/gpl.html>.
