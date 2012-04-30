#! /bin/sh
NOW=`date +%y-%m-%d-%H-%M-%S`
killall PTPCamera
gphoto2 -F 10 -I 4 --capture-image-and-download
#gphoto2 -F 10 -I 4 --capture-image
mkdir $NOW
mv *.jpg $NOW/
