#!/bin/bash
# by fuldaros
ver=$(sed -n 2p tools/akb.prop);
clear
e="\x1b[";c=$e"39;49;00m";y=$e"93;01m";cy=$e"96;01m";r=$e"1;91m";g=$e"92;01m";m=$e"95;01m";
echo -e "
$cy****************************************************
$cy*           Automatic kernel builder v"$ver"          *
$cy*                   by fuldaros                    *
$cy****************************************************
$r!!! Пожалуйста, уважайте чужой труд и не меняйте имя автора на свое <3 !!! $y";     
set -e
usr=$(sed -n 2p make.prop);
bh=$(sed -n 8p make.prop);
arch=$(sed -n 4p make.prop);
stamp=$(date +"%Y.%m.%d %H:%M");
stampt=$(date +"%d.%m.%Y-%H:%M");
logb=logb_"$stamp";
otazip=ota_akb_"$stamp";
device=$(sed -n 12p make.prop);
cpu=$(sed -n 10p make.prop);
imgt=$(sed -n 14p make.prop);
gcc=$(sed -n 16p make.prop);
kernel="$imgt"_akb_"$stamp";
export ARCH="$arch"
export TARGET_ARCH="$arch"
export KBUILD_BUILD_USER="$author"
export KBUILD_BUILD_HOST="$bh"
echo -e "$cy******************************$y"
echo -e "$g   Build info";
echo -e "$y User: "$usr"
 Host: "$bh"
 ARCH: "$arch"
 CPU: "$cpu"
 Device: "$device"
 Build time: "$stamp"";
echo -e "$cy******************************$y"
rm -rf out/paperplane/include/generated/compile.h
pwd > pwd.dat
read pwd < pwd.dat
rm -f pwd.dat
export CROSS_COMPILE="$pwd"/tools/"$gcc"
cd sources/
echo -e "$g Внимание, подождите. Наводим Тополь-M на Соедененные Штаты Америки.
 Терпения, друзья! :3$y"
strt=$(date +"%s")
make -j3 O=../out/paperplane "$imgt" > ../outkernel/"$logb"
clear
echo -e "
$cy****************************************************
$cy*           Automatic kernel builder v"$ver"          *
$cy*                   by fuldaros                    *
$cy****************************************************
$y";  
echo -e "$g Идет обратый отсчет.$y"
cat ../out/paperplane/arch/"$arch"/boot/"$imgt" > ../outkernel/"$kernel"
rm -rf ../out/paperplane/arch/"$arch"/boot/
cd ../
echo -e "$g Пуск. Тополь-М приближается к цели...$y"
rm -f otagen/zImage
cat outkernel/"$kernel" > otagen/zImage
cd otagen
echo "ZIP file is generated automatically by fuldaros script on "$stamp"" > generated.info
cat ../make.prop > author.prop
echo -e "//BUILD TIME" "\n""$stampt" >> author.prop
echo -e "// Automatic kernel builder ver. (DONT EDIT)" >> author.prop
echo -e "$ver" >> author.prop
zip -r ../outzip/"$otazip".zip *
echo -e "$g Поздравляем, Соедененные Штаты Америки стерты с лица земли.
 Подробности в этом архиве. "$otazip".zip$y"
rm -f zImage
rm -f generated.info
rm -f author.prop
end=$(date +"%s")
diff=$(( $end - $strt ))
echo Операция выполнена успешно!
echo -e "$m Полет Тополь-M до цели занял "$diff" секунд!"
