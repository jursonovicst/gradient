# Gradient
10-BIT DISPLAY TEST SEQUENCE

I had always trouble finding good test sequences for verifying the 10-bit color depth support of new UHD TV sets (and new smartphones), so I just created some. Feel free to use it under cc.

Simply navigate to the [github pages](http://jursonovicst.github.io/gradient/) of this repository, open the linked video files or download the content of the [test sequences](https://github.com/jursonovicst/gradient/tree/master/test_sequences) folder to a pendrive, plug it into your device, and play the video files.

Check, how many vertical bars you see. If your display supports 10-bit color depth, you should see 4 times more stripes in 10 bit gradients, than on the 8 bit gradients. Look closely, they may be only 3 pixel wide (the stripe borders are marked with white lines).


# How I made these sequences?

Check the [prepareraw.sh](prepareraw.sh) script.

I used ImageMagick to create a 16-bit png image with four gradients according to 8 bit colors values, and four gradients  according to 10 bit color values.

![gradient](https://raw.githubusercontent.com/jursonovicst/gradient/master/test_sequences/1920x1080/gradient_1920-1080_25-50.png)

(if you view this image on your computer, your display may not show a difference due to the lack of 10-bit color depth support...)

Looping and encoding this png file with ffmpeg, using the x265 encoder with resulted mp4 video files, which you can play on the target device.

During encoding, I used the following settings:

 - 5 fps to limit the size of the video files,
 - lossless encoding to allow exact color comparison,
 - full color range to have proper color steps at both ends of the gradient,
 - gbrp10le color space for native RGB color encoding, but yuv444p10 and yuv420p10 are also provided for better compatibility.
 
