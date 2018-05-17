#!/bin/bash
#
# Zotero installer
# Copyright 2011-2013 Sebastiaan Mathot
# <http://www.cogsci.nl/>
#
# Ce fichier est une partie de qnotero.
#
# qnotero est un logiciel libre: Il peut être diffuser, utiliser et modifier selon les termes 
# de la GNU General Public License publiée par
# la Free Software Foundation, dans version 3 (ou la dernière selon votre choix).
#
# qnotero is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with qnotero.  If not, see <http://www.gnu.org/licenses/>.

VERSION="5.0.45"
if [ `uname -m` == "x86_64" ]; then
	ARCH="x86_64"
else
	ARCH="i686"
fi
TMP="/tmp/zotero.tar.bz2"
DEST_FOLDER=zotero
EXEC=zotero

echo ">>> Ce script va téléchargé et installé la version standalone de zotero sur votre système."
echo ">>> Voulez--vous continuer?"
echo ">>> o/n (defaut=o)"
read INPUT
if [ "$INPUT" = "n" ]; then
	echo ">>> Abandon de l'installation"
	exit 0
fi

echo ">>> Voulez-vous installer Zotero globalement, pour tous les utilisateurs (g) ou localement c'est à dire pour la personne l'installant seulement (l)?"
echo ">>> Les droits d'administration sont requis pour une installation globale."
echo ">>> g/l (defaut=l)"
read INPUT
if [ "$INPUT" != "g" ]; then
	echo ">>> Installation locale"
	DEST="$HOME"
	MENU_PATH="$HOME/.local/share/applications/zotero.desktop"
	MENU_DIR="$HOME/.local/share/applications"
else
	echo ">>> Installation globale"
	DEST="/opt"
	MENU_PATH="/usr/share/applications/zotero.desktop"
	MENU_DIR="/usr/share/applications"
fi


echo ">>> Merci de préciser le numéro de version à installer de Zotero."
echo ">>> (default=$VERSION)"
read INPUT
if [ "$INPUT" != "" ]; then
	VERSION=$INPUT
fi

echo ">>> Merci de préciser l'architecture de votre système (i686 ou x86_64)."
echo ">>> (default=$ARCH)"
read INPUT
if [ "$INPUT" != "" ]; then
	ARCH=$INPUT
fi

URL="https://download.zotero.org/client/release/${VERSION}/Zotero-${VERSION}_linux-${ARCH}.tar.bz2"

echo ">>> Téléchargement de Zotero standalone $VERSION pour $ARCH"
echo ">>> URL: $URL"

wget $URL -O $TMP
if [ $? -ne 0 ]; then
	echo ">>> Échec du téléchargement de Zotero"
	echo ">>> Abandon de l'installation, désolé!"
	exit 1
fi

if [ -d $DEST/$DEST_FOLDER ]; then
	echo ">>> Le répertoire de destination ($DEST/$DEST_FOLDER) existe déjà. Voulez-vous le supprimer?"
	echo ">>> o/n (default=n)"
	read INPUT
	if [ "$INPUT" = "o" ]; then
		echo ">>> Effacement de l'ancienne version de zotero"
		rm -Rf $DEST/$DEST_FOLDER
		if [ $? -ne 0 ]; then
			echo ">>> Échec de suppression de l'ancienne version"
			echo ">>> Abandon de l'installation, désolé!"
			exit 1
		fi
	else
		echo "Abandon de l'installation, désolé!"
		exit 0
	fi
fi

echo ">>> Extraction en cours de Zotero"
echo ">>> Répertoire cible: $DEST/$DEST_FOLDER"

tar -xpf $TMP -C $DEST
if [ $? -ne 0 ]; then
	echo ">>> Échec d'extraction de Zotero"
	echo ">>> Abandon de l'installation, désolé!"
	exit 1
fi

mv $DEST/Zotero_linux-$ARCH $DEST/$DEST_FOLDER
if [ $? -ne 0 ]; then
	echo ">>> Échec de déplacement de zotero vers $DEST/$DEST_FOLDER"
	echo ">>> Abandon de l'installation, désolé!"
	exit 1
fi

if [ -f $MENU_DIR ]; then
	echo ">>> Création du menu $MENU_DIR"
	mkdir $MENU_DIR
fi

echo ">>> Création de l'entrée de menu en cours…"
echo "[Desktop Entry]
Name=Zotero
Comment=Gestionnaire de références documentaires et bibliographique (version standalone)
Exec=$DEST/$DEST_FOLDER/zotero
Icon=$DEST/$DEST_FOLDER/chrome/icons/default/default48.png
Type=Application
StartupNotify=true" > $MENU_PATH
if [ $? -ne 0 ]; then
	echo ">>> Échec de la création de l'item dans le menu des applications"
	echo ">>> Abandon de l'installation, désolé!"
	exit 1
fi

echo ">>> Terminé!"
echo
echo ">>> Don't forget to check out Qnotero, the Zotero sidekick!"
echo ">>> URL: http://www.cogsci.nl/qnotero"
