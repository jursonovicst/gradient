#!/bin/bash

cd 3840x2160
rm -f *
../../prepareraw.sh 3840 2160 0 100
../../prepareraw.sh 3840 2160 0 50
../../prepareraw.sh 3840 2160 50 100
cd ..

cd 3120x1440
rm -f *
../../prepareraw.sh 3120 1440 0 50
../../prepareraw.sh 3120 1440 50 100
cd ..

cd 1920x1080
rm -f *
../../prepareraw.sh 1920 1080 0 25
../../prepareraw.sh 1920 1080 25 50
../../prepareraw.sh 1920 1080 50 75
../../prepareraw.sh 1920 1080 75 100
cd ..
