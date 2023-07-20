#!/bin/bash

itzultool_filename=itzultool-0.1-linux-x64

echo "SIGNALIS euskaraz - Instalatzen..."

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
path=~/.steam/steam/steamapps/common/SIGNALIS/SIGNALIS_Data/

if [[  ! -d "$path" ]]; then
	input=~/.steam/steam/config/libraryfolders.vdf
	while read -r line; do
		if [[ $line == \"path\"* ]]; then
			base=$(echo $line | cut -d '"' -f 4)
			path="$base"/steamapps/common/SIGNALIS/SIGNALIS_Data
			if [[ -d "$path" ]]; then
				break
			fi
		fi
	done < "$input"
fi

echo "Path: $path"

# Instalaziorako karpeta sortu
mkdir signalis-eu-instalazioa
cd signalis-eu-instalazioa

echo "ItzulTool deskargatzen..."

# Deskargatu ItzulTool
wget https://github.com/ibaios/itzultool/releases/download/v0.1/"$itzultool_filename"

chmod +x ./"$itzultool_filename"

echo "Deskargatuta."

echo ".Net 6.0 frameworka instalatzen..."

# .Net 6.0 instalatu
wget https://dot.net/v1/dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --runtime dotnet --version 6.0.0

echo "Instalatuta."
echo "EMIP itzulpen-fitxategia deskargatzen..."

# Deskargatu EMIP fitxategia
wget https://ibaios.eus/itzulpenak/signalis/signalis-eu-$locale.emip

echo "Deskargatuta."
echo "Itzulpena aplikatzen. Honek luze jo dezake..."

# Aplikatu itzulpena
export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" decompress "$path"/data.unity3d
export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" extractassets "$path"/data.unity3d.decomp resources.assets
export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" applyemip signalis-eu-$locale.emip "$path"
# Garbitu
rm "$path"/resources.assets.bak0000
export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" replaceassets  "$path"/data.unity3d.decomp "$path"/resources.assets
# Garbitu eta bundlearen backupa sortu
rm "$path"/resources.assets
mv "$path"/data.unity3d "$path"/data.unity3d.bak
export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" compress "$path"/data.unity3d.decomp "$path"/data.unity3d
# Garbitu
rm "$path"/data.unity3d.decomp

echo "Aplikatuta."
echo "Instalazioko fitxategiak ezabatzen..."
cd ..
rm -R signalis-eu-instalazioa/

# Instalatuta!
echo "Instalazioa behar bezala burutu da. Orain SIGNALIS euskaraz izango duzu."
