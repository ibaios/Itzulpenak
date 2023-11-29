#!/bin/bash

itzultool_version=0.4
itzultool_filename=itzultool-"$itzultool_version"-linux-x64

echo "Hollow Knight euskaraz - Instalatzen..."

# Aukeratu gainidatziko den hizkuntza
while true; do
	read -p "Zein hizkuntza gainidatzi nahi duzu?
	1: Gaztelania
	2: Frantsesa
	(idatzi 1 edo 2 eta sakatu SARTU tekla)
	" esfr
	case $esfr in
		1 ) locale='es'; break;;
		2 ) locale='fr'; break;;
		* ) echo "
		OKERREKO AUKERA. Idatzi 1 (Gaztelania) edo 2 (Frantsesa) eta sakatu SARTU tekla.
		";;		
	esac
done

# Bilatu jokoaren kokalekua
path=~/.steam/steam/steamapps/common/Hollow\ Knight/hollow_knight_Data/

if [[  ! -d "$path" ]]; then
	input=~/.steam/steam/config/libraryfolders.vdf
	while read -r line; do
		if [[ $line == \"path\"* ]]; then
			base=$(echo $line | cut -d '"' -f 4)
			path="$base"/steamapps/common/Hollow\ Knight/hollow_knight_Data
			if [[ -d "$path" ]]; then
				break
			fi
		fi
	done < "$input"
fi

echo "Path: $path"

# Instalaziorako karpeta sortu
mkdir hollow-knight-eu-instalazioa
cd hollow-knight-eu-instalazioa

echo "UABE Avalonia deskargatzen..."

echo "ItzulTool deskargatzen..."

# Deskargatu ItzulTool
wget https://github.com/ibaios/itzultool/releases/download/v"$itzultool_version"/"$itzultool_filename"

chmod +x ./"$itzultool_filename"

echo "Deskargatuta."

echo "EMIP itzulpen-fitxategia deskargatzen..."

# Deskargatu EMIP fitxategia
wget https://ibaios.eus/itzulpenak/hollowknight/hollow-knight-eu-$locale.emip

echo "Deskargatuta."
echo "Itzulpena aplikatzen..."

# Aplikatu itzulpena
./"$itzultool_filename" applyemip hollow-knight-eu-$locale.emip "$path"

echo "Aplikatuta."
echo "Instalazioko fitxategiak ezabatzen..."
cd ..
rm -R hollow-knight-eu-instalazioa/

# Instalatuta!
echo "Instalazioa behar bezala burutu da. Orain Hollow Knight euskaraz izango duzu."
