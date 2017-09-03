#!/bin/sh

# exit on errors
set -o errexit
set -o nounset

usage="Usage: ./`basename $0` [-h] [-ip] [-a] [-n name]\n
\n
generate icns and png files from the svg files located in ./vectors\n
\n
where:\n
\t    -h  show this help text\n
\t    -i  generate icns files\n
\t    -a  generate files for all vectors\n
\t    -n  generate files for specified vector\n
\t    -f  replace files if they already exists
\n
examples:\n
\t    generate icns and png files for all vectors\n
\t    ./`basename $0` -a -i\n
\n
\t    generate only png files for all vectors\n
\t    ./`basename $0` -a\n
\n
\t    generate icns and png files for a specific vector\n
\t    ./`basename $0` -n firefox -i\n"

# constants
PNG_DIR="./pngs"
ICNS_DIR="./icns"
SVG_DIR="./vectors"
SVG_FILES="${SVG_DIR}/*.svg"
TOTAL_ICONS=`ls -l ${SVG_DIR} | grep -e "\.svg$" | wc -l | tr -d '[:space:]'`

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

current_icon=0

# Functions
generate_icons() {
  if [ $gen_all = 'true' ]; then
    current_icon=$(($current_icon+1))
    progress=$(($current_icon*100/$TOTAL_ICONS))
    echo "${Blue}Building files for ${1}${Color_Off} - ${current_icon}/${TOTAL_ICONS} ${progress}%"
  else
    echo "${Blue}Building files for ${1}${Color_Off}"
  fi

  generate_png "$1"

  if [ "$gen_icns" = "true" ]; then
    generate_icns "$1"
  fi
}

generate_icns() {
  if [ -f "$ICNS_DIR/$1.icns" ]; then
    if [ $gen_force = "true" ]; then
      echo "${Blue}Removing old Icon for $1"
      rm "$ICNS_DIR/$1.icns"
    else
      echo "$1.icns does already exists, skipping, use -f to replace."
      return 1
    fi
  fi

  echo "${Blue}Generating $1.icns${Color_Off}"

  files_missing="FALSE"

  for SIZE in 16 32 128 256 512 1024; do
    filename="$1@${SIZE}.png"
    if [ ! -f "${PNG_DIR}/$1/${filename}" ]; then
      files_missing="TRUE"
      break
    fi
  done

  if [ $files_missing = "FALSE" ]; then
    imgdir="${PNG_DIR}/$1"
    png2icns "${ICNS_DIR}/$1.icns" "${imgdir}/$1@16.png" "${imgdir}/$1@32.png" "${imgdir}/$1@128.png" "${imgdir}/$1@256.png" "${imgdir}/$1@512.png" "${imgdir}/$1@1024.png"
  else
    echo "${Red}Required PNG files does not exists, skipping $1${Color_Off}"
  fi
}

generate_png() {
  output_dir="${PNG_DIR}/$1/"
  if [ -d "$output_dir" ]; then
    if [ $gen_force = "true" ]; then
      echo "${Blue}Removing old PNGs for $1"
      rm -rf "$PNG_DIR/$1/"
    else
      echo "PNGs for $1 does already exists, skipping, use -f to replace.${Color_Off}"
      return 1
    fi
  fi

  mkdir -p "${output_dir}"
  for SIZE in 16 32 128 256 512 1024; do
    filename="$1@${SIZE}.png"
    output_file="${output_dir}/${filename}"

    echo "${Cyan}Generating png, ${filename}${Color_Off}"
    convert -resize ${SIZE} -background none "${SVG_DIR}/$1.svg" "${output_file}"
  done
}

# flags
gen_icns="false"
gen_all="false"
gen_name=""
gen_force="false"
show_usage="false"

while getopts "ipan:fh" flag; do
  case $flag in
    i) gen_icns="true" ;;
    a) gen_all="true" ;;
    n) gen_name="$OPTARG" ;;
    f) gen_force="true" ;;
    h) show_usage="true" ;;
    *) echo "${Red}Unexpected option $flag, type -h for help.${Color_Off}"; exit ;;
  esac
done

# Check if help flag is set
if [ "$show_usage" = "true" ]; then
  echo $usage
  exit
fi

# Check if either all or name is set
if [ "$gen_all" = "false" ] && [ -z "$gen_name" ]
then
  echo "Either -a or -n have to be set."
  exit
fi

# Make required directories
mkdir -p $PNG_DIR
if [ "$gen_icns" = "true" ]; then
  mkdir -p $ICNS_DIR
fi

if [ "$gen_all" = "true" ]; then
  # If -a is set
  for icon in $SVG_FILES; do
    basename=${icon##*/}
    basename=${basename%.svg}
    generate_icons "$basename"
  done
else
  # if -n is set
  generate_icons "$gen_name"
fi
