#!/bin/bash
# by fuldaros
# Хрень какай-то
source ./tools/func.sh
ver=$(sed -n 2p tools/akb.prop);
clear
e="\x1b[";c=$e"39;49;00m";y=$e"93;01m";cy=$e"96;01m";r=$e"1;91m";g=$e"92;01m";m=$e"95;01m";
echo -e "
$cy****************************************************
$cy*           Automatic kernel builder v"$ver"          *
$cy*                   by fuldaros                    *
$cy****************************************************
$y";
sleep 3
# Прерываем выполнение при появлении пошибки 
set -e
# Создание переменных
createvar;
# Тип сборки (бесполезная хрень)
if [[ "$sha" != "1" ]]
then
type="USER";
else
type="OFFICIAL";
fi
# Еще переменная
kernel="$imgt"_akb_"$stamp";
# Экспортируем необходимые значения из make.prop
exportcm;
# Вывод информации о сборки
echo -e "$cy******************************$y"
echo -e "$g   Build info";
echo -e "$y User: "$usr"
 Host: "$bh"
 ARCH: "$arch"
 CPU: "$cpu"
 Device: "$device"
 Build time: "$stamp"
 Kernel location: "$loc"
 Build type: "$type"";
echo -e "$cy******************************$y"
sleep 4
# Экспортируем gcc из make.prop
export CROSS_COMPILE="$PWD"/tools/"$gcc"
cd sources/
echo -e "$g Начинаем сборку ядра...$y"
strt=$(date +"%s")
# Сборка ядра :3
make -j3 O=../out/akb_"$device" "$imgt" > ../outkernel/"$logb"
clear
echo -e "
$cy****************************************************
$cy*           Automatic kernel builder v"$ver"          *
$cy*                   by fuldaros                    *
$cy****************************************************
$y";  
echo -e "$g Сборка завершена!
 Переносим ядро в outkernel... $y"
sleep 3
# Перенос ядра в папку outkernel
cat ../out/akb_"$device"/arch/"$arch"/boot/"$imgt" > ../outkernel/"$kernel"
rm -rf ../out/akb_"$device"/arch/"$arch"/boot/
cd ../
mkota;
echo -e "$g Удаление временных фаилов...$y"
# Отчистка tmp фаилов
sleep 1
cleantmp;
echo -e "$g Готово! Имя OTA пакета: "$otazip".zip$y"
# Вывод времени сборки
end=$(date +"%s")
diff=$(( $end - $strt ))
echo Операция выполнена успешно!
sleep 2
echo -e "$m Компиляция заняла "$diff" секунд!"
####### script v09 (beta)
