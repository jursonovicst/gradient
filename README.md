# gradient
10-BIT DISPLAY TEST SEQUENCE

I had always trouble finding good test sequences for verifying 10-bit support of new UHD TV sets, so I just created one. Feel free to use it under cc.

As the source of the video file I used the following 16-bit source image. There are four with 8-bit and other four with 16 bit blue/red/gray gradient.

![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 1")

Looping and encoding this image with hevc in yuv420p10le color space results the following UHD mp4 file: [gradient.mp4](https://www.github.com). If you play this file on a 10-bit UHD display then 10-bit gradients should be very smooth in contrast with 8-bit ones, where 15 pixel wide vertical bars should appear.
