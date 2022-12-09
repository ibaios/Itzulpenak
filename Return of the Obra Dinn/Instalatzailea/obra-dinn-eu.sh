#!/usr/bin/env bash

echo "Return of the Obra Dinn euskaraz - Instalatzen..."

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
path=~/.steam/steam/steamapps/common/ObraDinn/ObraDinn_Data/

if [[  ! -d "$path" ]]; then
	input=~/.steam/steam/config/libraryfolders.vdf
	while read -r line; do
		if [[ $line == \"path\"* ]]; then
			base=$(echo $line | cut -d '"' -f 4)
			path="$base"/steamapps/common/ObraDinn/ObraDinn_Data
			if [[ -d "$path" ]]; then
				break
			fi
		fi
	done < "$input"
fi

echo "Path: $path"

# Instalaziorako karpeta sortu
mkdir obra-dinn-eu-instalazioa
cd obra-dinn-eu-instalazioa

echo "Itzulpen-fitxategia deskargatzen..."

# Deskargatu ASSETS fitxategia
wget https://ibaios.eus/itzulpenak/obradinn/lang-$locale

echo "Deskargatuta."
echo "Itzulpena aplikatzen..."

# Aplikatu itzulpena
cp lang-$locale "$path/StreamingAssets/"

echo "Aplikatuta."
echo "Instalazioko fitxategiak ezabatzen..."
cd ..
rm -R obra-dinn-eu-instalazioa/

# Instalatuta!
echo "Instalazioa behar bezala burutu da. Orain Return of the Obra Dinn euskaraz izango duzu."
