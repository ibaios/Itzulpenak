#!/bin/bash

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
			path="$base/steamapps/common/Hollow\ Knight/hollow_knight_Data"
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

# Deskargatu UABE Avalonia
wget https://github.com/nesrak1/UABEA/releases/download/v4/uabea_rel4_ubuntu_x64.zip

echo "Deskargatuta."
echo "UABE Avalonia erauzten..."

# Erauzi
unzip uabea_rel4_ubuntu_x64.zip -d uabea

echo "Erauzita."
echo ".Net 5.0 frameworka instalatzen..."

# .Net 5.0 instalatu
wget https://dot.net/v1/dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --runtime dotnet --version 5.0.0

echo "Instalatuta."
echo "EMIP itzulpen-fitxategia deskargatzen..."

# Deskargatu EMIP fitxategia
wget https://ibaios.eus/itzulpenak/hollowknight/hollow-knight-eu-$locale.emip

echo "Deskargatuta."
echo "Itzulpena aplikatzen..."

# Aplikatu itzulpena
export DOTNET_ROOT=~/.dotnet/ && uabea/net5.0/UABEAvalonia applyemip hollow-knight-eu-$locale.emip "$path"

echo "Aplikatuta."
echo "Instalazioko fitxategiak ezabatzen..."
cd ..
rm -R hollow-knight-eu-instalazioa/

# Instalatuta!
echo "Instalazioa behar bezala burutu da. Orain Hollow Knight euskaraz izango duzu."
