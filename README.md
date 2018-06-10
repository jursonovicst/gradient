# Gradient
10-BIT DISPLAY TEST SEQUENCE

I had always trouble finding good test sequences for verifying the 10-bit color depth support of new UHD TV sets, so I just created one. Feel free to use it under cc.

Simply download the [gradient.mp4](https://github.com/jursonovicst/gradient/blob/master/gradient.mp4?raw=true "with h265 codec") (or the [gradient_x264.mp4](https://github.com/jursonovicst/gradient/blob/master/gradient_x264.mp4?raw=true "with h264 codec")) mp4 file to an USB drive, plug it into your TV, play the video, and check, how many vertical bars you see. If your display supports 10-bit color depth, you should see 1024 different stripes. Look closely, they are only 3 pixel wide (the stripe borders are marked with black lines).


# How I made this test sequence

Check the [prepareraw](https://github.com/jursonovicst/gradient/blob/master/prepareraw) script.

I used ImageMagick to create the following 16-bit, 3840×2160 (UHD) png image with four 256 step and four 1024 step gradients. The 10-bit gradients have very thin bars, so I added an extra gray gradient at the bottom with less steps to produce wider bars.

![gradient](https://raw.githubusercontent.com/jursonovicst/gradient/master/gradient.png)

(if you view this image on your computer, your display probably will not show a difference due to the lack of 10-bit color depth support...)

Looping and encoding this png file with ffmpeg, x265, and x264 in yuv420p10le color space resulted raw h265 and h264 files, which were put into mp4 container by GPAC.

If you want to recreate or modify this image, make sure, that you build x265 with HIGH_BIT_DEPTH enabled in cmake to support  10-bit mode.
