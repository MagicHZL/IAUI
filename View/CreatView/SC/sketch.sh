#!/bin/bash

basepath=$(cd `dirname $0`; pwd)

echo $basepath

cp $1 $2.zip
mkdir $2
unzip $2.zip -d $2
cd $2/pages

count=0
first=''

for file in *.json
do
    ((count++))
    if [ $count == 1 ]
    then
        first=$file
    fi
    
done

echo $first

cp $first $basepath/OR/orJson.json

echo '===成功得到源文件===='
cd $basepath
rm $2.zip
rm -rf $2
#./CreatView
#xcodebuild -target CreatView -destination "platform=macOS" -configuration Release
