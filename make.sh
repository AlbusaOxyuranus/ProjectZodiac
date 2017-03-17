clear
currentFolder=$PWD
buildFolder="build"
sourceFolder="source"
buildPath="$currentFolder/$buildFolder"
sourcePath="$currentFolder/$sourceFolder"
mainFileName="main";
NameFileEntryPoint="EntryPoint.ld"
NameBootFileELF="Boot.elf"
NameBootFileBIN="Boot.bin"
mainFileNameCpp=$mainFileName.cpp;
mainFileNameObj=$mainFileName.o;
NameBootFileIMG="Zodiac.img"
PathCodeHeader="$currentFolder/header"
echo "================== Начинаем сборку ================== "
echo 
echo " * Переменные * "
echo " currentFolder=$currentFolder"
echo " buildPath=$buildPath"
echo " PathCodeHeader=$PathCodeHeader"

getSize()
{
	echo
	echo " * Get Size * "
	FILESIZE=$(stat -c%s "$1/$2")
	echo " Size of $2 = $FILESIZE bytes."
	echo
}

if [[ ! -d $buildPath ]]; then
	#
	echo 
	echo " * Папка не найдена $buildFolder"
	echo " * Создаем папку $buildFolder"
	mkdir $buildFolder
	echo 
else
	echo 
	echo " * Очистка папки от старых файлов"
	rm  -v $buildPath/*.elf $buildPath/*.o $buildPath/*.bin $buildPath/*.img 
	echo " * Папка очищена"
	echo 
fi

echo " Компиляция исходного кода на C++ "
g++ -I $PathCodeHeader -c -g -Os -march=x86-64 -ffreestanding -Wall -Werror $sourcePath/$mainFileNameCpp -o $buildPath/$mainFileNameObj -m32
ls $buildPath

echo
echo "  = Компиляция исходного кода на ASM = "
ld -static -T$sourcePath/$NameFileEntryPoint -nostdlib --nmagic -o $buildPath/$NameBootFileELF $buildPath/$mainFileNameObj -m elf_i386
ls $buildPath


echo
echo "  = Перевод файлов в папке Build в бинарный файл"
objcopy -O binary $buildPath/$NameBootFileELF $buildPath/$NameBootFileBIN
getSize $buildPath $NameBootFileELF
ls $buildPath


echo "\r\n  = Создание дискеты = \r\n"
dd if=/dev/zero of=$buildPath/$NameBootFileIMG bs=512 count=2880
getSize $buildPath $NameBootFileIMG
ls $buildPath


echo "\r\n  = Запись $NameBootFileBIN на образ дискеты  $NameBootFileIMG = \r\n"
dd if=$buildPath/$NameBootFileBIN of=$buildPath/$NameBootFileIMG 
FILESIZE=$(stat -c%s "$buildPath/$NameBootFileIMG")
getSize $buildPath $NameBootFileIMG
ls $buildPath


echo
echo "================== сборка успешно завершена ====================="
echo