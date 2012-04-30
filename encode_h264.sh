# !/bin/bash
if [ $# -eq 0 ]; then
  echo "Please provide video path as an argument"
  echo ""
  echo "${txtgrn}Use: ${txtylw}./encode_h264.sh ${txtpur}{source_video_path}${txtrst}"
  echo "${txtgrn}--------"
  echo "${txtcyn}--------${txtrst}"
  exit 1;
fi
if ! [[ -f "$1" ]]; then
  echo ""
  echo "${txtylw}$1${txtrst} doesn't exits"
  echo "${txtcyn}--------${txtrst}"
  echo ""
  exit 1;
fi
ffmpeg -v debug -report -y -i $1 -vf crop=1920:1080:0:0 -pass 1 -vcodec libx264 -vpre slower_firstpass $1.h264.mov

# ffmpeg -v debug -report -y -i 12-01-22-17-45-45.tl.mov -vf crop=1920:1080:0:100 -an -pass 1 -threads 2 -vcodec libx264 -b 4M -flags +loop+mv4 -cmp 256 -partitions +parti4x4+parti8x8+partp4x4+partp8x8+partb8x8 -me_method hex -subq 7 -trellis 1 -refs 5 -bf 3 -flags2 +bpyramid+wpred+mixed_refs+dct8x8 -coder 1 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -qmin 10 -qmax 51 -qdiff 4 12-01-22-17-45-45.tl.mov.h264.mov