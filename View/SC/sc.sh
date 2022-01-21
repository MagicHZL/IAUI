
#用法示例： ./sc.sh CCC.sketch ccc
#!/bin/bash

basepath=$(cd `dirname $0`; pwd)

echo $basepath
echo $1.zz
cd $basepath
ls $basepath
cp $1 cname.zip
mkdir cname
unzip cname.zip -d cname
cd cname/pages

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
rm cname.zip
rm -rf cname
#./CreatView

