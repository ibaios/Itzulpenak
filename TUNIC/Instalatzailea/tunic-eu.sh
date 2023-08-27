#!/bin/bash

itzultool_filename=itzultool-0.3-linux-x64

echo "TUNIC euskaraz - Instalatzen..."

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

# Aukeratu bundlea konprimatu edo ez
while true; do
	read -p "Amaieran bundlea konprimatu? Diskoan leku gutxiago hartuko du, baina konprimatzeko prozesua motela da (5min inguru).
	1: Bai
	2: Ez
	(idatzi 1 edo 2 eta sakatu SARTU tekla)
	" c
	case $c in
		1 ) compress=true; break;;
		2 ) compress=false; break;;
		* ) echo "
		OKERREKO AUKERA. Idatzi 1 (BAI) edo 2 (EZ) eta sakatu SARTU tekla.
		";;		
	esac
done

# Aukeratu jatorrizko bundlearen backupa gorde edo ez
while true; do
	read -p "Jatorrizko bundlea gorde? Diskoan lekua hartuko du, eta Steam edo GOG moduko denda gehienetan erraza da jokoa berrinstalatzea arazoren bat badago.
	1: Bai
	2: Ez
	(idatzi 1 edo 2 eta sakatu SARTU tekla)
	" k
	case $k in
		1 ) keeporiginal=true; break;;
		2 ) keeporiginal=false; break;;
		* ) echo "
		OKERREKO AUKERA. Idatzi 1 (BAI) edo 2 (EZ) eta sakatu SARTU tekla.
		";;		
	esac
done

# Bilatu jokoaren kokalekua
path=~/.steam/steam/steamapps/common/TUNIC/Tunic_Data/

if [[  ! -d "$path" ]]; then
	input=~/.steam/steam/config/libraryfolders.vdf
	while read -r line; do
		if [[ $line == \"path\"* ]]; then
			base=$(echo $line | cut -d '"' -f 4)
			path="$base"/steamapps/common/TUNIC/Tunic_Data
			if [[ -d "$path" ]]; then
				break
			fi
		fi
	done < "$input"
fi

echo "Path: $path"

# Instalaziorako karpeta sortu
mkdir tunic-eu-instalazioa
cd tunic-eu-instalazioa

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
wget https://ibaios.eus/itzulpenak/tunic/tunic-eu-$locale.emip

echo "Deskargatuta."
echo "Itzulpena aplikatzen. Honek luze jo dezake..."

# Aplikatu itzulpena
export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" decompress "$path"/data.unity3d
export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" extractassets "$path"/data.unity3d.decomp resources.assets
export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" applyemip tunic-eu-$locale.emip "$path"

# Garbitu
rm "$path"/resources.assets.bak0000

export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" replaceassets  "$path"/data.unity3d.decomp "$path"/resources.assets

# Garbitu eta bundlearen backupa sortu (hala hautatu badu)
rm "$path"/resources.assets

if [[ "$keeporiginal" = true ]]; then
	mv "$path"/data.unity3d "$path"/data.unity3d.bak
else
	rm "$path"/data.unity3d
fi

# Konprimatu (hala hautatu badu)
if [[ "$compress" = true ]]; then
	export DOTNET_ROOT=~/.dotnet/ && ./"$itzultool_filename" compress "$path"/data.unity3d.decomp "$path"/data.unity3d
	rm "$path"/data.unity3d.decomp
else
	mv "$path"/data.unity3d.decomp "$path"/data.unity3d
fi

echo "Aplikatuta."
echo "Instalazioko fitxategiak ezabatzen..."
cd ..
rm -R tunic-eu-instalazioa/

# Instalatuta!
echo "Instalazioa behar bezala burutu da. Orain TUNIC euskaraz izango duzu."
