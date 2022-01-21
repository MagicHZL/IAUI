#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
xcodebuild -target CreatView -destination "platform=macOS" -configuration Release
cppath=$(cd ..; pwd)
cp $basepath/build/Release/CreatView  $cppath/SC/CreatView

