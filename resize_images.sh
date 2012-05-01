# !/bin/bash
# Text color variables
export txtund=$(tput sgr 0 1)    # Underline
export txtbld=$(tput bold)       # Bold
export txtred=$(tput setaf 1)    # Red
export txtgrn=$(tput setaf 2)    # Green
export txtylw=$(tput setaf 3)    # Yellow
export txtblu=$(tput setaf 4)    # Blue
export txtpur=$(tput setaf 5)    # Purple
export txtcyn=$(tput setaf 6)    # Cyan
export txtwht=$(tput setaf 7)    # White
export txtrst=$(tput sgr0)       # Text reset
echo ""
echo "${txtcyn}--------"
echo "Checking for source image path"
echo "${txtrst}"
if [ $# -eq 0 ]; then
  echo "Please provide source image path as an argument"
  echo ""
  echo "${txtgrn}Use: ${txtylw}./resize_images.sh ${txtpur}{source_image_poth}${txtrst}"
  echo "${txtgrn}--------"
  echo "${txtcyn}--------${txtrst}"
  exit 1;
fi
if ! [[ -d "$1" && ! -L $1 ]]; then
  echo ""
  echo "${txtylw}$1${txtrst} doesn't exits or it's not a valid folder"
  echo "${txtcyn}--------${txtrst}"
  echo ""
  exit 1;
fi
export targetdir=$1
echo "${txtgrn}Source image path exits and is correct"
echo "will resize"
echo "${txtcyn}--------"

mkdir ${targetdir}/resized

cd ${targetdir}
convert '*.jpg' -resize 1920x1080^ -gravity center -crop 1920x1080+0+0 resized/frame%04d.jpg
mv resized ../${targetdir}_sized
cd ..
echo "${txtcyn}All images resized to ${targetdir}/"
echo "--------${txtrst}"