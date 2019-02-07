# 10 bit test sequences

For the best quality, try first the video files with **gbrp10le** color space (which encodes the gradient with native RGB colors).

Unfortunately, not all devices support them, so in case of a playback issue, fall back to **yuv444p10**, or to **yuv420p10** (which may reduces the horizontal spatial resolution).

For smaller resoutions, the gradients are splitted into multiple parts to allow wider stripes and easier indentification.

| Target         | Resolution | Gradient split | Color spaces |
|----------------|------------|----------------|--------------|
| UHD TV         | 3840x2160  | 0%-100%        | [gbrp10le](test_sequences/3840x2160/gradient_3840-2160_0-100_gbrp10le_x265.mp4),  [yuv444p10](test_sequences/3840x2160/gradient_3840-2160_0-100_yuv444p10_x265.mp4),  [yuv420p10](test_sequences/3840x2160/gradient_3840-2160_0-100_yuv420p10_x265.mp4) |
|||||
| HD TV, monitor | 1920x1080  | 0%-25%         | [gbrp10le](test_sequences/1920x1080/gradient_1920-1080_0-25_gbrp10le_x265.mp4),   [yuv444p10](test_sequences/1920x1080/gradient_1920-1080_0-25_yuv444p10_x265.mp4),   [yuv420p1](test_sequences/1920x1080/gradient_1920-1080_0-25_yuv420p10_x265.mp4) |
|                |            | 25%-50%        | [gbrp10le](test_sequences/1920x1080/gradient_1920-1080_25-50_gbrp10le_x265.mp4),  [yuv444p10](test_sequences/1920x1080/gradient_1920-1080_25-50_yuv444p10_x265.mp4),  [yuv420p1](test_sequences/1920x1080/gradient_1920-1080_25-50_yuv420p10_x265.mp4) |
|                |            | 50%-75%        | [gbrp10le](test_sequences/1920x1080/gradient_1920-1080_50-75_gbrp10le_x265.mp4),  [yuv444p10](test_sequences/1920x1080/gradient_1920-1080_50-75_yuv444p10_x265.mp4),  [yuv420p1](test_sequences/1920x1080/gradient_1920-1080_50-75_yuv420p10_x265.mp4) |
|                |            | 75%-100%       | [gbrp10le](test_sequences/1920x1080/gradient_1920-1080_75-100_gbrp10le_x265.mp4), [yuv444p10](test_sequences/1920x1080/gradient_1920-1080_75-100_yuv444p10_x265.mp4), [yuv420p1](test_sequences/1920x1080/gradient_1920-1080_75-100_yuv420p10_x265.mp4) |
|||||
| Smartphone     | 3120x1440  | 0%-50%         | [gbrp10le](test_sequences/3120x1440/gradient_3120-1440_0-50_gbrp10le_x265.mp4),   [yuv444p10](test_sequences/3120x1440/gradient_3120-1440_0-50_yuv444p10_x265.mp4),   [yuv420p10](test_sequences/3120x1440/gradient_3120-1440_0-50_yuv420p10_x265.mp4) |
|                |            | 50%-100%       | [gbrp10le](test_sequences/3120x1440/gradient_3120-1440_50-100_gbrp10le_x265.mp4), [yuv444p10](test_sequences/3120x1440/gradient_3120-1440_50-100_yuv444p10_x265.mp4), [yuv420p10](test_sequences/3120x1440/gradient_3120-1440_50-100_yuv420p10_x265.mp4) |

