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
  echo "${txtgrn}Use: ${txtylw}./encode_raw.sh ${txtpur}{source_image_poth}${txtrst}"
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
export tl_name=$(basename $1).tl.mov
echo "${txtgrn}Source image path exits and is correct"
echo "will export timelapse to ${txtylw}$tl_name"
echo "${txtcyn}--------"

read -p "How many frames per second (fps you need)?: "
if ! [[ "$REPLY" =~ ^[0-9]+$ ]]; then
   exec >&2; 
   echo "${txtgrn}error: Not a number"; 
   echo ${txtrst}
   exit 1
fi
export fps=$REPLY
echo ${txtrst}

echo "${txtcyn}--------"
echo "Renaming files for ffmpeg"
var=`python rename.py -p $1 | tail -n 1`
echo $var
if ! [[ $var == 'ok' ]]; then
  echo "${txtrst}"
  exit 1
fi
echo "${txtrst}"
ffmpeg -v debug -report -y -r $fps -i $1/frame%04d.jpg -sameq -vcodec copy $tl_name
# ffmpeg -v debug -report -y -i $tl_name -sameq -vcodec prores -profile 0 $tl_name.prores_proxy.mov
# ffmpeg -v debug -report -y -i $tl_name -sameq -vcodec prores -profile 2 $tl_name.prores.mov
echo "${txtcyn}Timelapse $tl_name encoded"
echo "--------${txtrst}"
