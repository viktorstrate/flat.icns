#!/bin/sh

# constants
BASEDIR=$(dirname "$0")

ICNS_DIR="${BASEDIR}/icns"
ICNS_FILES="${ICNS_DIR}/*.icns"
FILEICON_DIR="${BASEDIR}/libs/fileicon.sh"

ICON_PATH=(
  "/Applications"
  "$HOME/Applications"
)

# Colors
Color_Off='\033[0m'       # Text Reset
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

set_icons() {
  request_sudo
  echo "Installing icons..."
  for icon in $ICNS_FILES; do
    basename=${icon##*/}
    basename=${basename%.icns}

    for path in ${ICON_PATH}; do
      if [ -d "${path}/${basename}.app" ]; then
        echo "Setting icon for ${Red}${basename}${Color_Off} at ${path}/${basename}.app"

        sudo bash ${FILEICON_DIR} set "${path}/${basename}.app" "${ICNS_DIR}/${basename}.icns"

      fi
    done
  done
}

clear_icons() {
  request_sudo
  echo "Restoring icons..."
  for icon in $ICNS_FILES; do
    basename=${icon##*/}
    basename=${basename%.icns}

    for path in ${ICON_PATH}; do
      if [ -d "${path}/${basename}.app" ]; then
        echo "Restoring original icon for ${Red}${basename}${Color_Off} at ${path}/${basename}.app"

        sudo bash ${FILEICON_DIR} rm "${path}/${basename}.app"

      fi
    done
  done
}

request_sudo() {
  if [[ $EUID > 0 ]]; then
    echo "You may be asked to enter your password, this is required to change some system icons"
    sudo echo ""
  fi
}

echo $#

if [ $# -ge 1 ]; then
  case $1 in
    "help")
      echo "Usage: $0 [option]"
      echo "\t$0 install - to install icons"
      echo "\t$0 restore - to restore original icons"
      echo "\t$0 help - show this help"
    ;;
    "install") set_icons ;;
    "restore") clear_icons ;;
    *) echo "For help write: $0 help" ;;
  esac
else
  set_icons
fi