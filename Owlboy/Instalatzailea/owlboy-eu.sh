#!/usr/bin/env bash

gamename="Owlboy"
author="ibaios"
email="ibaios@disroot.org"

steamfolder="Owlboy"
gogfolder="Owlboy"
subdir="Data"

tempfolder=owlboy-eu-instalazioa

l10n_file="https://ibaios.eus/itzulpenak/owlboy/owlboy-eu.zip"

ascii=$(cat <<'END'

    ...    .::    .   .::::::     :::::::.      ...  .-:.     ::-.
 .;;;;;;;. ';;,  ;;  ;;;' ;;;      ;;;'';;'  .;;;;;;;.';;.   ;;;;'
,[[     \[[,'[[, [[, [['  [[[      [[[__[[\.,[[     \[[,'[[,[[['  
$$$,     $$$  Y$c$$$c$P   $$'      $$""""Y$$$$$,     $$$  c$$"    
"888,_ _,88P   "88"888   o88oo,.___88o,,od8P"888,_ _,88P,8P"`     
  "YMMMMMP"     "M "M"   """"YUMMM""YUMMMP"   "YMMMMMP"mM"        
                                                               
END
)

endascii=$(cat <<'END'
                                                                               
              o;.                                      .:c                     
              do:cc.                                .cc;x:                     
              .k   ;oc.                          .co;   0.                     
               O. xc..lo.                      .ol..cd ,d                      
               'k ,KKo..ll.                  .oc..dKK' 0.                      
                ll :XXKd..x;                co..dXXK; d;                       
                 dc :KKXK: :d             .x; cKXXK; lc                        
                  co '0XXXd .k.          ,x..xXXXO. dc                         
                   'k. dXXXO..k.  ....  ,x .0XXXo .x.                          
                     dc ,OXXO .kc:;,,;:lk .0XXO' lo                            
                      ,d, c0Xk .,coddoc' .0X0; ,d'                             
                        :d. cKxOkkkkkkkkkk0: 'd;                               
                         oc ;Okkkkkkkkkkkkk' dl                                
                        oc lOkkkkkkxxkkkkkkO; oc                               
                       ;d cOkkkkx,... ,kkkkkO' k'                              
                       O .Okkkkd .x;;x..xkkkkk .0                              
                      cl lkkkkx .O.  .k. kOOO0c x,                             
                      0. 0O00K' O.    .k ;XXXXO 'k                             
                     .K .XXXX0 .k      O. KXXXX. 0                             
                   .:l; :XXXXx cl      d, kXXXX, :l::.                         
                 .oc..ckXXXXXd lc      o: xXXXXKk:..l0                         
                cd .dKXXXXXXXx :o      x, OXXXXXXXKd.                          
                .d; ;xKXXXXXX0 .O      0 .KXXXXXXKx,                           
                  ;oc..;o0XXXX: d;    ;l lXXXXOl,..co;                         
                    .:ll 'XXXX0. O'  'k .KXXXK. ol:.                           
                       d; xXXXX0' cccc ,KXXXXl lc                              
                        O..OXXXXKd;..,xXXXXXd ,k                               
                        .k..kXXXXXXXXXXXXXXo 'O.                               
                         .d; :0XXXXXXXXXXO, co                                 
                           :d. ;d0KXXX0o, ,d,                                  
                             :oc'......,ll,                                    
                                ';::::;.                                       
                                                    
END
)

# FUNTZIOAK

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
    echo "Itzulpen-fitxategia deskargatzen..."

    varname="l10n_file"
    wget "${!varname}" -O l10n.zip || ok=0

    handle_error

    echo "Deskargatuta."
}

apply_l10n() {
    echo ""
    echo "Itzulpena deskonprimatzen..."

    python3 -m zipfile -e l10n.zip "$path" || ok=0

    handle_error
}

final_message() {
    echo ""
    echo "Instalazioko fitxategiak ezabatzen..."
    cd ..
    rm -R $tempfolder/
    echo "Eginda."

    echo ""
    echo "$endascii"
    echo ""
    echo "✔  Instalazioa behar bezala burutu da."
    echo "   Orain, '$gamename' euskaraz izango duzu."
}

# EXEKUZIOA

echo ""
echo "$ascii"
echo ""
echo "Itzultzailea: $author"
echo ""
echo "$gamename euskaraz - Instalatzen..."

ok=1

get_game_path "${2:-}"

create_temp_folder

download_l10n

apply_l10n

final_message

exit 0