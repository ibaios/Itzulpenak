#!/usr/bin/env bash

steamfolder=Untitled\ Goose\ Game/Untitled_Data
repourl=https://ibaios.eus/itzulpenak/untitledgoosegame
tempfolder=untitled-goose-game-eu-instalazioa
gamename="Untitled Goose Game"
email=ibaios@disroot.org

ascii=$(cat <<'END'
                                          
o    o         o   o   o  8             8 
8    8         8       8  8             8 
8    8 odYo.  o8P o8  o8P 8 .oPYo. .oPYo8 
8    8 8' `8   8   8   8  8 8oooo8 8    8 
8    8 8   8   8   8   8  8 8.     8    8 
`YooP' 8   8   8   8   8  8 `Yooo' `YooP' 
:.....:..::..::..::..::..:..:.....::.....:
::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::
                                                                  
.oPYo.                               .oPYo.                       
8    8                               8    8                       
8      .oPYo. .oPYo. .oPYo. .oPYo.   8      .oPYo. ooYoYo. .oPYo. 
8   oo 8    8 8    8 Yb..   8oooo8   8   oo .oooo8 8' 8  8 8oooo8 
8    8 8    8 8    8   'Yb. 8.       8    8 8    8 8  8  8 8.     
`YooP8 `YooP' `YooP' `YooP' `Yooo'   `YooP8 `YooP8 8  8  8 `Yooo' 
:....8 :.....::.....::.....::.....::::....8 :.....:..:..:..:.....:
:::::8 :::::::::::::::::::::::::::::::::::8 ::::::::::::::::::::::
:::::..:::::::::::::::::::::::::::::::::::..::::::::::::::::::::::

END
)

endascii=$(cat <<'END'
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::;;:::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::,''''''',;:::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::;''''''''''',::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::,'''''''''''''';::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::,'''''',kl''''''';:::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::;''''''';KMWx''''''',::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::;'''''''lNMMMM0;'''''',:::::::::::::::::::::::::::::
:::::::::::::::::::::::::::,'''''''dWMMMMMMN:''''''';:::::::::::::::::::::::::::
::::::::::::::::::::::::::,'''''''xWMMMMMMMMNc''''''';::::::::::::::::::::::::::
:::::::::::::::::::::::::''''''';KMMMMMMMMMMMWd''''''',:::::::::::::::::::::::::
:::::::::::::::::::::::;''''''':NMMMMMMMMNNMMMMO,'''''',::::::::::::::::::::::::
::::::::::::::::::::::,'''''''lWMMMMMMMd.  .:dKWK;''''''':::::::::::::::::::::::
:::::::::::::::::::::,'''''''xMMMMMMMMx ..:oxxOMMNc''''''';:::::::::::::::::::::
::::::::::::::::::::''''''',0MMMMMMMMMk  xMMMMMMMMWd''''''';::::::::::::::::::::
::::::::::::::::::;''''''';XMMMMMMMMMMMx..;OMMMMMMMMk''''''',:::::::::::::::::::
:::::::::::::::::;'''''''lNMMMMMMMMMMWNKd...;NMMMMMMM0;'''''''::::::::::::::::::
::::::::::::::::,'''''''xWMNodkOOdc;...  ....'WMMMMMMMNc''''''';::::::::::::::::
:::::::::::::::''''''''OMMMWl... ........... 'WMMMMMMMMWl''''''',:::::::::::::::
:::::::::::::;''''''';KMMMMMMX:............ ;NMMMMMMMMMMWx''''''',::::::::::::::
::::::::::::;'''''''cNMMMMMMMMM0..........:OMMMMMMMMMMMMMMO,'''''',:::::::::::::
:::::::::::,'''''''dWMMMMMMMMMMMK. .',''kWMMMMMMMMMMMMMMMMMX:''''''';:::::::::::
::::::::::,'''''''OMMMMMMMMMMMMMMWdoMMO;KNWMMMMMMMMMMMMMMMMMWo''''''';::::::::::
::::::::;''''''';0MMMMMMMMMMMMMMMMN'looddolXMMMMMMMMMMMMMMMMMWd''''''',:::::::::
:::::::;'''''''cNMMMMMMMMMMMMMMMMMMXoOOWMMMMMMMMMMMMMMMMMMMMMMMO,'''''',::::::::
:::::::,'''''';kOOOOOOOOOOOOOOOOOOOOkOOOOOOOOOOOOOOOOOOOOOOOOOOOd'''''''::::::::
:::::::;''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''',::::::::
::::::::;''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''',:::::::::
::::::::::;,,'''''''''''''''''''''''''''''''''''''''''''''''''''''',;:::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
END
)

# FUNTZIOAK

# Hemen Steam / GOG / Beste bat galdetzekoa faltako litzateke

choose_overridden_lang() {
    if [[ "$1" == "es" || "$1" == "fr" ]]; then
        locale="$1"
    else
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
    fi
}

get_steam_path() {
    echo "STEAM dendako jokoaren instalazioa bilatzen..."	
    steamconfigpath=~/.steam/steam/config/libraryfolders.vdf
    if [[ ! -f "$steamconfigpath" ]]; then
        steamconfigpath=~/.var/app/com.valvesoftware.Steam/.local/share/Steam/config/libraryfolders.vdf
        if [[ ! -f "$steamconfigpath" ]]; then
            steamconfigpath=""
            echo "EZIN IZAN DA STEAM-EKO KONFIGURAZIO FITXATEGIA AURKITU."
        fi
    fi

    if [[ ! -z "$steamconfigpath" ]]; then
        while read -r line; do
            if [[ $line == \"path\"* ]]; then
                base=$(echo $line | cut -d '"' -f 4)
                optpath="$base"/steamapps/common/$steamfolder
                if [[ -d "$optpath" ]]; then
                    paths+=("$optpath")
                    #echo "Konfigurazioan $optpath aurkitu da..."
                fi
            fi
        done < "$steamconfigpath"

        if [[ ${#paths[@]} > 0 ]]; then
            if [[ ${#paths[@]} == 1 ]]; then
                path=${paths[0]}
            else
                # Galdetu erabiltzaileari
                echo "Jokoarentzako karpeta posible bat baino gehiago aurkitu dira. Zein da jokoaren benetako karpeta?"
                select selpath in "${paths[@]}"; do
                    if [[ -z "$selpath" ]]; then
                        printf 'Okerreko aukera.\n' "$selpath" >&2
                    else
                        path="$selpath"
                        break
                    fi
                done
            fi
        fi
    fi
}

set_path_manually() {
    read -p "Ez da jokoaren karpeta aurkitu. Idatzi eskuz non dagoen.
    (adb. /home/erabiltzailea/.steam/steam/steamapps/common/$steamfolder)
    Kokalekua: " path
    while [[ ! -d "$path" ]]; do
        read -p "Sartutako kokalekua ez da existitzen. Saiatu berriz.
        (adb. /home/erabiltzailea/.steam/steam/steamapps/common/$steamfolder)
        Kokalekua: " path
    done
}

get_game_path() {
    path="$1"
    paths=()

    if [[ -z "$path" ]]; then
        get_steam_path
        if [[ -z "$path" ]]; then
            set_path_manually
        fi
    fi

    echo "Path: $path"
}

create_temp_folder() {
    mkdir $tempfolder
    cd $tempfolder
}

handle_error() {
    if [[ $ok == 0 ]]; then
        echo "Huts egin du."
        echo "Instalazioko fitxategiak ezabatzen..."
        cd ..
        rm -R $tempfolder/

        # Errorea
        echo ""
        echo "✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗"
        echo "✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗"
        echo ""
        echo "Arazoren bat gertatu da '$gamename' jokoaren euskaratzea instalatzean. Saiatu berriro edo idatzi $email helbidera lagun zaitzadan."
        
        exit 1
    fi
}

download_l10n() {
    echo ""
    echo "Itzulpen-fitxategiak deskargatzen..."

    wget $repourl/eu-$locale.json || ok=0

    handle_error

    echo "Deskargatuta."
}

apply_l10n() {
    echo ""
    echo "Itzulpena aplikatzen. Honek luze jo dezake..."

    # Aplikatu itzulpena
    if [[ $locale == "es" ]]; then
        locfile="spanish"
    else
        locfile="french"
    fi

    stringtablespath="$path/StreamingAssets/StringTables"
    mv "$stringtablespath/$locfile.json" "$stringtablespath/$locfile.json.bak" || ok=0
    mv ./eu-$locale.json "$stringtablespath/$locfile.json" || ok=0

    handle_error
}

final_message() {
    echo ""
    echo "Instalazioko fitxategiak ezabatzen..."
    cd ..
    rm -R $tempfolder/
    echo "Eginda."

    # Instalatuta!
    echo ""
    echo "$endascii"
    echo ""
    echo "✔  Instalazioa behar bezala burutu da."
    echo "   Orain, '$gamename' euskaraz izango duzu."
}

# HASIERA
echo "$ascii"

echo "$gamename euskaraz - Instalatzen..."

ok=1

choose_overridden_lang "${1:-}"

get_game_path "${2:-}"

create_temp_folder

download_l10n

apply_l10n

final_message

exit 0
