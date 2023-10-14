#!/bin/bash

itzultool_filename=itzultool-0.3-linux-x64

echo "Nine Sols Demo euskaraz - Instalatzen..."

# Bilatu jokoaren kokalekua
path="~/.steam/steam/steamapps/common/Nine Sols Demo/NineSols_Data/"

if [[  ! -d "$path" ]]; then
	input=~/.steam/steam/config/libraryfolders.vdf
	while read -r line; do
		if [[ $line == \"path\"* ]]; then
			base=$(echo $line | cut -d '"' -f 4)
			path="$base/steamapps/common/Nine Sols Demo/NineSols_Data/"
			if [[ -d "$path" ]]; then
				break
			fi
		fi
	done < "$input"
fi

echo "Path: $path"

# Instalaziorako karpeta sortu
mkdir nine-sols-demo-eu-instalazioa
cd nine-sols-demo-eu-instalazioa

echo "ItzulTool deskargatzen..."

# Deskargatu ItzulTool
wget https://github.com/ibaios/itzultool/releases/download/v0.3/"$itzultool_filename"

chmod +x ./"$itzultool_filename"

echo "Deskargatuta."

echo ".Net 6.0 frameworka instalatzen..."

# .Net 6.0 instalatu
wget https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --runtime dotnet --version 6.0.0

echo "Instalatuta."
echo "EMIP itzulpen-fitxategia deskargatzen..."

# Deskargatu EMIP fitxategia
wget https://github.com/ibaios/Itzulpenak/raw/master/Nine%20Sols%20Demo/Instalatzailea/nine-sols-demo-eu.emip

echo "Deskargatuta."
echo "Itzulpena aplikatzen..."

# Aplikatu itzulpena
export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" applyemip nine-sols-demo-eu.emip "$path"

echo "Aplikatuta."
echo "Instalazioko fitxategiak ezabatzen..."
cd ..
rm -R nine-sols-demo-eu-instalazioa/

# Instalatuta!
echo "Instalazioa behar bezala burutu da. Orain Nine Sols Demo euskaraz izango duzu."
