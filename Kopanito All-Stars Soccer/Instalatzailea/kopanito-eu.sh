#!/usr/bin/env bash

steamfolder=Kopanito\ All-Stars\ Soccer
subdir=
repourl=https://ibaios.eus/itzulpenak/kopanito
l10nprefix=kopanito-eu
tempfolder=kopanito-eu-instalazioa
gamename="KOPANITO All-Stars Soccer"
email=ibaios@disroot.org

ascii=$(cat <<'END'

 █████   ████    ███████    ███████████    █████████   ██████   █████ █████ ███████████    ███████   
░░███   ███░   ███░░░░░███ ░░███░░░░░███  ███░░░░░███ ░░██████ ░░███ ░░███ ░█░░░███░░░█  ███░░░░░███ 
 ░███  ███    ███     ░░███ ░███    ░███ ░███    ░███  ░███░███ ░███  ░███ ░   ░███  ░  ███     ░░███
 ░███████    ░███      ░███ ░██████████  ░███████████  ░███░░███░███  ░███     ░███    ░███      ░███
 ░███░░███   ░███      ░███ ░███░░░░░░   ░███░░░░░███  ░███ ░░██████  ░███     ░███    ░███      ░███
 ░███ ░░███  ░░███     ███  ░███         ░███    ░███  ░███  ░░█████  ░███     ░███    ░░███     ███ 
 █████ ░░████ ░░░███████░   █████        █████   █████ █████  ░░█████ █████    █████    ░░░███████░  
░░░░░   ░░░░    ░░░░░░░    ░░░░░        ░░░░░   ░░░░░ ░░░░░    ░░░░░ ░░░░░    ░░░░░       ░░░░░░░    
                                                                                                     
===============================  A L L - S T A R S       S O C C E R  ===============================
                                                                                                     
END
)

endascii=$(cat <<'END'
                ...................                                             
            ...............................                                     
        ......................................                                  
      ............................................                              
     ................................................                           
   ....................................................                         
  .......................................................                       
...........................................................                     
.............................................................                   
...............................................................                 
................................................................                
...............................         .........................               
........................                     ......................             
.....................                           ....................            
...................                                ..................           
.................                                    .................          
................                                       ................         
...............                        .,,,....  ..     ...............         
..............                   'lxOO0KKKKOl:'. .;dOxl'  ..............        
.............                .lkKNNWWloOK00x;.. .:odk0KKOdc,.............       
.............              ,kXXXKKKXXXXXXXKKOxooKKKKKKK000Okxc'..........       
.............            ,xKK0O0OO00KKKKKKKXXXKKKKKKKKK000OOkxl..........       
.............           oOOO00OxO00KKKKKXXXXXXXXXNXXXXKKKKK0Ok'  ........       
.............         ,0c'''.'cO00KKKKXXXXXNNNNWNNWNNNXXXXKKK0k   ........      
.............        ,d;      '0KKKKXXXNNNNNNNWXxok0NWNNNXXKKK0.    ......      
..............      .:.        oKKKXXXNNNNWWNO:     .ckNWNNNXKOl;   .....       
..............      '.         .k0KXNNWWWWXd.           lXNXXXXKKOl  ....       
...............     ,;       .oOKXXNNNNNNX'   ....       dWNNNNXXXKkc....       
................   .::.     l0XXNNNNNWWWWWX'',,'....     0WNNNNNXXX0k...        
 ................   .';ll:'c0XXXNNNNNWWWWWWX'ldxdl:'    cWWWWNNNXXK0k...        
  ................  .,:lk00kKXXNNNNNNWWWWWMMK.,lxkd;   ;NMWWWWNNXXK0d..         
   ..................,:ldx0KKXXNNNNNNNWWWWWMWXOO0000KKXNWWWWWNNNXKKK,..         
    .................':codkKXKXXNNNNNNNWWWWWWMMMWWMWWWWWWNWWWNNNKxXo..          
     .................';coxOXNK0XXNNNNNNNWNWWWWWWWWWWWWWWWNX0ko:  o..           
       .................;cox0X:.;cdxkOOOKXNWWWWWWWWWWWWWWWNx      ..            
         ................':oko          .ONNWWWWWWWWWWWWWXo     ...             
           ................'lxl.          dXNNWNNNNNNNX0o.    ...               
              ................'cc:.        ;XXNNNNNNXXKx;.......                
                ..................:clddcldk0000OOkkxdoc,......                  
                    ...................',,;;;;,,'..........                     
                       .................................                        
                          ...........................                           
                               ...................                              
                                      . .......                                 
END
)

# FUNTZIOAK

# Hemen Steam / GOG / Beste bat galdetzekoa faltako litzateke

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
    path="$path/$subdir"
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

    wget $repourl/$l10nprefix.tar.xz || ok=0

    handle_error

    echo "Deskargatuta."
}

apply_l10n() {
    echo ""
    echo "Itzulpena aplikatzen. Honek luze jo dezake..."

    # Aplikatu itzulpena
    tar -xvf $l10nprefix.tar.xz -C "$path"

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

get_game_path "${1:-}"

create_temp_folder

download_l10n

apply_l10n

final_message

exit 0
