# Gradient
10-BIT DISPLAY TEST SEQUENCE

I had always trouble finding good test sequences for verifying the 10-bit color depth support of new UHD TV sets (and new smartphones), so I just created some. Feel free to use it under cc.

Simply navigate to the [github pages](http://jursonovicst.github.io/gradient/) of this repository, and open the linked video files, or download the content of the [test sequences](https://github.com/jursonovicst/gradient/tree/master/test_sequences) folder to a pendrive, and open the files on your device.

Check, how many vertical bars you see. If your display supports 10-bit color depth, you should see 4 times more stripes in 10 bit gradients, than on the 8 bit gradients. Look closely, they may be only 3 pixel wide (the stripe borders are marked with white lines).


# How I made this test sequence

Check the [prepareraw](https://github.com/jursonovicst/gradient/blob/master/prepareraw) script.

I used ImageMagick to create the following 16-bit, 3840×2160 (UHD) png image with four 256 step and four 1024 step gradients. The 10-bit gradients have very thin bars, so I added an extra gray gradient at the bottom with less steps to produce wider bars.

![gradient](https://raw.githubusercontent.com/jursonovicst/gradient/master/gradient.png)

(if you view this image on your computer, your display probably will not show a difference due to the lack of 10-bit color depth support...)

Looping and encoding this png file with ffmpeg, x265, and x264 in yuv420p10le color space resulted raw h265 and h264 files, which were put into mp4 container by GPAC.

If you want to recreate or modify these files, make sure, that you build x265 with HIGH_BIT_DEPTH enabled in cmake to support  10-bit mode.
