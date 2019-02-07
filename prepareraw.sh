#!/bin/bash

usage () {
  echo "usage: $0 WIDTH HEIGHT GRADFROM GRADTO
Creates a WIDTH x HEIGHT 16bit png test image with red-green-blue-gray gradients from GRADFROM % to GRADTO %, then converts it to a 10 seconds long, 10bit test video sequences with yuv420p10, yuv444p10, gbrp10le color spaces."
}

##############################################
#
# This script creates a 16bit png test image,
# and converts it to a 10bit test video to
# test the color depth support of displays.
#
# command specifications
ffmpeg="ffmpeg"
#
if [ $# -ne 4 ]; then
  usage
  exit -1
fi
#
# video size in pixel
if [ "$1" -le 0 ]; then
  usage
  exit -1
fi
if [ "$2" -le 0 ]; then
  usage
  exit -1
fi
width=$1
height=$2
#
# gradient range in procent (0 to 100)
if [ "$3" -lt 0 ]; then
  usage
  exit -1
fi
if [ "$4" -lt 0 ]; then
  usage
  exit -1
fi
if [ "$3" -gt 100 ]; then
  usage
  exit -1
fi
if [ "$4" -gt 100 ]; then
  usage
  exit -1
fi

gradfrom=$3
gradto=$4
#
##############################################


# check dependencies
hash convert 2>/dev/null || { echo >&2 "This script requires ImageMagic but it's not installed.  Aborting."; exit 1; }

hash $ffmpeg 2>/dev/null || { echo >&2 "This script requires ffmpeg but it's not installed.  Aborting."; exit 1; }
$ffmpeg -pix_fmts 2>&1 |grep yuv444p10 >/dev/null || { echo >&2 "It seems to me, that ffmpeg was not built with 10bit support.  Aborting."; exit 1; }


# check TMPDIR
if [ ! -d "$TMPDIR" ]; then
  TMPDIR="./"
fi


# calculate parameters
filename=gradient_$width-${height}_$gradfrom-$gradto

gradheight=$(($height / 8))       #round down

gradbarnum8=$((256 * ($gradto - $gradfrom) / 100))    #to avoid
gradbarnum10=$(($gradbarnum8 * 4))

gradbarwidth10=$(($width / $gradbarnum10))
gradbarwidth8=$(($gradbarwidth10 * 4))

gradfrom8=$(($gradfrom * 256 / 100))
gradto8=$(($gradto * 256 / 100))

gradfrom10=$(($gradfrom * 1024 / 100))
gradto10=$(($gradto * 1024 / 100))


# check if gradient.png exists, if not, create it
if [ -f $filename.png ]; then
  echo "skip gradient creation, $filename.png file does exist"

else
  echo "creating empty canvas with size of ${width}x${height} pixel"
  convert -depth 16 -size ${width}x${height} xc:white $filename.png

  echo "8 bit $gradfrom% to $gradto% gradient:
 number of color bars: $gradbarnum8
 bar width: $gradbarwidth8 pixel
            $((1106 / $gradbarnum8)) mm on a 50\" TV
            $((140 / $gradbarnum8)) mm on a 6\" phone

10 bit $gradfrom% to $gradto% gradient:
 bar width: $gradbarwidth10 pixel
            $((1106 / $gradbarnum10)) mm on a 50\" TV
            $((140 / $gradbarnum10)) mm on a 6\" phone
"

  COLORMASK=("#%04x00000000" "-" "#0000%04x0000" "-" "#00000000%04x" "-" "#%04x%04x%04x")
  COLORNAME=("red" "-" "green" "-" "blue" "-" "gray")

  for gradnum in $(seq 0 2 5); do

    echo "creating ${COLORNAME[$gradnum]} 8 bit gradient"
    command="convert -depth 16 $filename.png "
    for i in $(seq 0 $(($gradbarnum8 - 1))); do
      color1ch=$((256 * $gradfrom / 100 * 256 + 256 * $i))
      color=$(printf ${COLORMASK[$gradnum]} $color1ch)
      x1=$(($i * gradbarwidth8))
      y1=$(($gradheight * $gradnum + 3))
      x2=$(($x1 + gradbarwidth8 - 1))
      y2=$(($gradheight * ( $gradnum + 1 ) - 1))
      #echo $color $x1 $y1 $x2 $y2
      command=$command"-fill \"$color\" -draw \"rectangle $x1,$y1 $x2,$y2\" -fill \"#ffffff\" -draw \"line $x2,$y1 $x2,$(($y1 + 10))\" "
      colorname=$(printf %04x $color1ch)
      command=$command"-fill \"#ffffffffffff\" -pointsize 10 -annotate +$x1+$(($y1 + 9)) '$colorname' "
    done
    command=$command"-fill \"#ffffffffffff\" -pointsize 36 -annotate +50+$(($y1 + 110)) '8bit ${COLORNAME[$gradnum]} $gradfrom% to $gradto% gradient (you should see $gradbarnum8 vertical bars)' "
    command=$command"$filename.png"
    eval  $command

    echo "creating ${COLORNAME[$gradnum]} 10 bit gradient"
    command="convert -depth 16 $filename.png "
    for i in $(seq 0 $(($gradbarnum10 - 1))); do
      color1ch=$((256 * $gradfrom / 100 * 256 + 64 * $i))
      color=$(printf ${COLORMASK[$gradnum]} $color1ch)
      x1=$(($i * gradbarwidth10))
      y1=$(($gradheight * ( $gradnum + 1 ) + 1))
      x2=$(($x1 + gradbarwidth10 - 1))
      y2=$(($gradheight * ( $gradnum + 2 ) - 3))
      #echo $color $x1 $y1 $x2 $y2
      command=$command"-fill \"$color\" -draw \"rectangle $x1,$y1 $x2,$y2\" -fill \"#ffffff\" -draw \"line $x2,$(($y2 - 10)) $x2,$y2 \" "
      colorname=$(printf %04x $color1ch)
      command=$command"-fill \"#ffffffffffff\" -pointsize 10 -annotate +$x1+$y2 '$colorname' "
    done
    command=$command"-fill \"#ffffffffffff\" -pointsize 36 -annotate +50+$(($y1 + 110)) '10bit ${COLORNAME[$gradnum]} gradient (you should see $gradbarnum10 vertical bars, if your display supports 10-bit color depth)' "
    command=$command"$filename.png"
    eval  $command

  done

  gradnum=6

  echo "creating ${COLORNAME[$gradnum]} 8 bit gradient"
  command="convert -depth 16 $filename.png "
  for i in $(seq 0 $(($gradbarnum8 - 1))); do
    color1ch=$((256 * $gradfrom / 100 * 256 + 256 * $i))
    color=$(printf ${COLORMASK[$gradnum]} $color1ch $color1ch $color1ch)
    x1=$(($i * gradbarwidth8))
    y1=$(($gradheight * $gradnum + 3))
    x2=$(($x1 + gradbarwidth8 - 1))
    y2=$(($gradheight * ( $gradnum + 1 ) - 1))
    #echo $color $x1 $y1 $x2 $y2
    command=$command"-fill \"$color\" -draw \"rectangle $x1,$y1 $x2,$y2\" -fill \"#ffffff\" -draw \"line $x2,$y1 $x2,$(($y1 + 10))\" "
    colorname=$(printf %04x $color1ch)
    command=$command"-fill \"#000000000000\" -pointsize 10 -annotate +$x1+$(($y1 + 9)) '$colorname' "
  done
  command=$command"-fill \"#000000000000\" -pointsize 36 -annotate +50+$(($y1 + 110)) '8bit ${COLORNAME[$gradnum]} $gradfrom% to $gradto% gradient (you should see $gradbarnum8 vertical bars)' "
  command=$command"$filename.png"
  eval  $command

  echo "creating ${COLORNAME[$gradnum]} 10 bit gradient"
  command="convert -depth 16 $filename.png "
  for i in $(seq 0 $(($gradbarnum10 - 1))); do
    color1ch=$((256 * $gradfrom / 100 * 256 + 64 * $i))
    color=$(printf ${COLORMASK[$gradnum]} $color1ch $color1ch $color1ch)
    x1=$(($i * gradbarwidth10))
    y1=$(($gradheight * ( $gradnum + 1 ) + 1))
    x2=$(($x1 + gradbarwidth10 - 1))
    y2=$(($gradheight * ( $gradnum + 2 ) - 3))
    #echo $color $x1 $y1 $x2 $y2
    command=$command"-fill \"$color\" -draw \"rectangle $x1,$y1 $x2,$y2\" -fill \"#ffffff\" -draw \"line $x2,$(($y2 - 10)) $x2,$y2 \" "
    colorname=$(printf %04x $color1ch)
    command=$command"-fill \"#000000000000\" -pointsize 10 -annotate +$x1+$y2 '$colorname' "
  done
  command=$command"-fill \"#000000000000\" -pointsize 36 -annotate +50+$(($y1 + 110)) '10bit ${COLORNAME[$gradnum]} gradient (you should see $gradbarnum10 vertical bars, if your display supports 10-bit color depth)' "
  command=$command"$filename.png"
  eval  $command

  convert -depth 16 $filename.png -fill "#ffffffffffff" -pointsize 16 -gravity SouthEast -annotate +0+30 'gradient v1.2 - http://jursonovics.com - This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/.' $filename.png

fi


# encode and package video with x265 10-bit support...
if [ ! -f ${filename}_yuv420p10_x265.mp4 ]; then
  $ffmpeg -y -loop 1 -t 10 -framerate 5 -i $filename.png -f mp4 -c:v libx265 -x265-params lossless=1:range=full -pix_fmt yuv420p10 -preset veryslow -tag:v hvc1 -movflags faststart ${filename}_yuv420p10_x265.mp4
fi

if [ ! -f ${filename}_yuv444p10_x265.mp4 ]; then
  $ffmpeg -y -loop 1 -t 10 -framerate 5 -i $filename.png -f mp4 -c:v libx265 -x265-params lossless=1:range=full -pix_fmt yuv444p10 -preset veryslow -tag:v hvc1 -movflags faststart ${filename}_yuv444p10_x265.mp4
fi

if [ ! -f ${filename}_gbrp10le_x265.mp4 ]; then
  $ffmpeg -y -loop 1 -t 10 -framerate 5 -i $filename.png -f mp4 -c:v libx265 -x265-params lossless=1:range=full -pix_fmt gbrp10le  -preset veryslow -tag:v hvc1 -movflags faststart ${filename}_gbrp10le_x265.mp4
fi

# encode and package video with x264 10-bit support...
#if [ -f ${filename}_x264.mp4 ]; then
#
#  echo "skip x264 encoding, ${filename}_x264.mp4 file does exist"
#
#else
#
#  echo "converting png to h264 and packaging video file"
#  $ffmpeg -y -loop 1 -t 10 -framerate 5 -i $filename.png -f mp4 -c:v libx264 -crf 0 -pix_fmt yuv420p10 -preset veryslow -movflags faststart ${filename}_yuv420p10_x264.mp4
#  $ffmpeg -y -loop 1 -t 10 -framerate 5 -i $filename.png -f mp4 -c:v libx264 -crf 0 -pix_fmt yuv444p10 -preset veryslow -movflags faststart ${filename}_yuv444p10_x264.mp4
#fi



