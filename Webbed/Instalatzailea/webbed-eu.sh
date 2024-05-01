#!/bin/bash

echo "Webbed euskaraz - Instalatzen..."

# Bilatu jokoaren kokalekua
path="~/.steam/steam/steamapps/common/Webbed/"

if [[  ! -d "$path" ]]; then
	input=~/.steam/steam/config/libraryfolders.vdf
	while read -r line; do
		if [[ $line == \"path\"* ]]; then
			base=$(echo $line | cut -d '"' -f 4)
			path="$base"/steamapps/common/Webbed/
			echo "Checking path $path ..."
			if [[ -d "$path" ]]; then
				echo "Path $path exists!"
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
wget https://ibaios.eus/itzulpenak/webbed/webbed-eu-en.csv

echo "Deskargatuta."
echo "Itzulpena aplikatzen..."

# Aplikatu itzulpena
mv "$path"/translations.csv "$path"/translations.csv.bak
cp ./webbed-eu-en.csv "$path"/translations.csv

echo "Aplikatuta."
echo "Instalazioko fitxategiak ezabatzen..."
cd ..
rm -R webbed-eu-instalazioa/

# Instalatuta!
echo "Instalazioa behar bezala burutu da. Orain Webbed euskaraz izango duzu."
