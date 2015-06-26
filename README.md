# gradient
10-BIT DISPLAY TEST SEQUENCE

I had always trouble finding good test sequences for verifying 10-bit support of new UHD TV sets, so I just created one. Feel free to use it under cc.

As the source of the video file I used the following 16-bit source image. There are four with 8-bit and other four with 16 bit blue/red/gray gradient.

![gradient](https://raw.githubusercontent.com/jursonovicst/gradient/master/gradient.png "16-bit Gradient")

(if you view this image on your computer, your display probably will not show a difference due to the lack of 10-bit color depth support...)

Looping and encoding this image with hevc in yuv420p10le color space results the following UHD mp4 file: [gradient.mp4](https://github.com/jursonovicst/gradient/blob/master/gradient.mp4). If you play this file on a 10-bit UHD display then 10-bit gradients should be very smooth in contrast with 8-bit ones, where 15 pixel wide vertical bars should appear.
