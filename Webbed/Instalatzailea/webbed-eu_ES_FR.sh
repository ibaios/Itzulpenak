#!/bin/bash

echo "Webbed euskaraz - Instalatzen..."

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
path="~/.steam/steam/steamapps/common/Webbed"

if [[  ! -d "$path" ]]; then
	input=~/.steam/steam/config/libraryfolders.vdf
	while read -r line; do
		if [[ $line == \"path\"* ]]; then
			base=$(echo $line | cut -d '"' -f 4)
			path="$base/steamapps/common/Webbed"
			if [[ -d "$path" ]]; then
				break
			fi
		fi
	done < "$input"
fi

echo "Path: $path"

# Instalaziorako karpeta sortu
mkdir webbed-eu-instalazioa
cd webbed-eu-instalazioa

echo "Itzulpen-fitxategia deskargatzen..."

# Deskargatu itzulpen-fitxategia
wget https://ibaios.eus/itzulpenak/webbed/webbed-eu-$locale.csv

echo "Deskargatuta."
echo "Itzulpena aplikatzen..."

# Aplikatu itzulpena
mv "$path/translations.csv" "$path/translations.csv.bak"
cp ./webbed-eu-$locale.csv "$path/translations.csv"

echo "Aplikatuta."
echo "Instalazioko fitxategiak ezabatzen..."
cd ..
rm -R webbed-eu-instalazioa/

# Instalatuta!
echo "Instalazioa behar bezala burutu da. Orain Webbed euskaraz izango duzu."
