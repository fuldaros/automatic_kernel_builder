#!/bin/bash
# by fuldaros
## FUNCTIONS START
# CLEAN TMP
function cleantmp {
rm -rf out/akb_"$device"/include/generated/compile.h
rm -f zImage
rm -f generated.info
rm -f author.prop
};
# CREATE VAR
function createvar {
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
loc=$(sed -n 18p make.prop);
gcc=$(sed -n 16p make.prop);
sha="0"
};
# EXPORT
function exportcm {
export ARCH="$arch"
export TARGET_ARCH="$arch"
export KBUILD_BUILD_USER="$author"
export KBUILD_BUILD_HOST="$bh"
};
# MAKE OTA PACK
function mkota {
echo -e "$g Собираем OTA пакет...$y"
cat outkernel/"$kernel" > otagen/zImage
cd otagen
echo "ZIP file is generated automatically by fuldaros's script on "$stamp"
Good luck!" > generated.info
echo -e "$g Генерируем author.prop...$y"
sleep 2
cat ../make.prop > author.prop
echo -e "# BUILD TIME" "\n""$stampt" >> author.prop
echo -e "# AKB ver. (DONT EDIT)""\n""$ver" >> author.prop
echo -e "#BUILD TYPE" "\n""$type" >> author.prop
echo -e "$g Сжимаем...$y"
sleep 3
zip -r ../outzip/"$otazip".zip *
};
## FUNCTIONS END
