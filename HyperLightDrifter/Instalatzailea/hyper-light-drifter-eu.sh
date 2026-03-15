#!/usr/bin/env bash

steamfolder=HyperLightDrifter
repourl=https://ibaios.eus/itzulpenak/hyperlightdrifter
l10nprefix=hyper-light-drifter-eu
tempfolder=hyper-light-drifter-eu-instalazioa
gamename="Hyper Light Drifter"
email=ibaios@disroot.org

ascii=$(cat <<'END'
  ██░ ██▓██   ██▓ ██▓███  ▓█████  ██▀███         ██▓     ██▓  ▄████  ██░ ██ ▄▄▄█████▓
 ▓██░ ██▒▒██  ██▒▓██░  ██▒▓█   ▀ ▓██ ▒ ██▒      ▓██▒    ▓██▒ ██▒ ▀█▒▓██░ ██▒▓  ██▒ ▓▒
 ▒██▀▀██░ ▒██ ██░▓██░ ██▓▒▒███   ▓██ ░▄█ ▒      ▒██░    ▒██▒▒██░▄▄▄░▒██▀▀██░▒ ▓██░ ▒░
 ░▓█ ░██  ░ ▐██▓░▒██▄█▓▒ ▒▒▓█  ▄ ▒██▀▀█▄        ▒██░    ░██░░▓█  ██▓░▓█ ░██ ░ ▓██▓ ░ 
 ░▓█▒░██▓ ░ ██▒▓░▒██▒ ░  ░░▒████▒░██▓ ▒██▒      ░██████▒░██░░▒▓███▀▒░▓█▒░██▓  ▒██▒ ░ 
  ▒ ░░▒░▒  ██▒▒▒ ▒▓▒░ ░  ░░░ ▒░ ░░ ▒▓ ░▒▓░      ░ ▒░▓  ░░▓   ░▒   ▒  ▒ ░░▒░▒  ▒ ░░   
  ▒ ░▒░ ░▓██ ░▒░ ░▒ ░      ░ ░  ░  ░▒ ░ ▒░      ░ ░ ▒  ░ ▒ ░  ░   ░  ▒ ░▒░ ░    ░    
  ░  ░░ ░▒ ▒ ░░  ░░          ░     ░░   ░         ░ ░    ▒ ░░ ░   ░  ░  ░░ ░  ░      
  ░  ░  ░░ ░                 ░  ░   ░               ░  ░ ░        ░  ░  ░  ░         
 ;       ░ ░                           ,                                
 ED.                                   Et                               
 E#Wi                                  E#t                            ,;   
 E###G.         j.            t        E##t                         f#i    j.         
 E#fD#W;        EW,           Ej       E#W#t      GEEEEEEEL       .E#t     EW,        
 E#t t##L       E##j          E#,      E#tfL.     ,;;L#K;;.      i#W,      E##j       
 E#t  .E#K,     E###D.        E#t      E#t           t#E        L#D.       E###D.     
 E#t    j##f    E#jG#W;       E#t   ,ffW#Dffj.       t#E      :K#Wfff;     E#jG#W;    
 E#t    :E#K:   E#t t##f      E#t    ;LW#ELLLf.      t#E      i##WLLLLt    E#t t##f   
 E#t   t##L     E#t  :K#E:    E#t      E#t           t#E       .E#L        E#t  :K#E: 
 E#t .D#W;      E#KDDDD###i   E#t      E#t           t#E         f#E:      E#KDDDD###i
 E#tiW#G.       E#f,t#Wi,,,   E#t      E#t           t#E          ,WW;     E#f,t#Wi,,,
 E#K##i         E#t  ;#W:     E#t      E#t           t#E           .D#;    E#t  ;#W:  
 E##D.          DWi   ,KK:    E#t      E#t            fE             tt    DWi   ,KK: 
 E#t                          ,;.      ;#t             :                
 L:                                     :;                              

END
)

endascii=$(cat <<'END'
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWMMMMMNOOkxO0NWONMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMxOXXkc.......'ccNMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMdc:'..........;cKMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMdcc',,,;'':::;;:oWMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMo,,.:cccc:cc:ccccXMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWc..,;cccccc:cccccNMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMX...;::::ccc:;;.dMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXd....,o;'llllcc.oMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK;........,:lodl,.'lXMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNk'.................'xWMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKl;,,'................:XMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0olllccc;,''......''...':lXMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWdlllllllllll:;,,''dOd'':lllxXWMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0lllllllllllllcc;;O0OklllllllXMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWklllllllllllc:'....lO0ollllllXMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXlldl;''',;,'.......;c;.:lllllNMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXo,codoOx;,,,,;:,.......,,.:llldMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO,':l;dkkko,,,,,;:;'',;::::::cllxMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo..;lc,,cxkkc,,,,;;:;::::::;::,;loWMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW:...:l:,,,;xkkc,,:xkxxxxol:::xoodloNMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:...:l:,;;,lx:. 'cllxolccxkxdxxxkxdMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:...,lc,,,,,;.      'loldxkkkkkkkxxOWMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0'...;kOxddokko::.. ,:ooooc:ooxxxxkxxMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk'..,l0XXXkllx0XOoclooooooolcl::cooooXMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd,'ck0KXXXXK0Okk0Kdooooooooool:::llooookMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMNXkk0KXXKOxkOkccoxxlooooooooooooo:clccoooooWMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMWNKK0KXXKkdc'...;oxdo:,,cooooooooooooo::c:coooooKMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMNXKK0XXKOkxc'.......cll;,,,;oooooooooooooo:oc:coooooxMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMWNXKKXXKOxl,..''.........lll;,,,coooo:,oooooooooocloooooodWMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMKO0K0OKKNWWWNk'.........,;lll;,,'ooool..oooooooooooooooooooNMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMXl......':;l'Nolll'..'oooo,.'ooooooloooooooooooo0MMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMM0'....'::ddklNcdXN;x;';,c;..'looood;ooolll:ldxXkNMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMWo...doOkXWWWN0WMMOXlOkc;....'o'l;o;:c....;X0WMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMK'.,WNMMMMMMMMMMMMMWNc:;''..ckOXoNk''.....xMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMN,.oMMMMMMMMMMMMMMMMNc::::::;xMMMMXc.'.'':KMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMNc.',WMMMMMMMMMMMMMMMNl:::::xNMMMMMWl'''.xWMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMXc..'dNMMMMMMMMMMMMMMMX:::::OMMMMMMMW;'''oWMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMx;cokO0MMMMMMMMMMMMMMMMK::::0MMMMMMMMN,'';MMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMWMMMMMMMMMMMMMMMMMMMMMk:::OMMMMMMMMMN''.:NMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNc:::NMMMMMMMMMK'.''KMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk::::KMMMMMMMMNc,'''XMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMX::::dMMMMMMMMMNkko''XMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk:::lkWMMMMMMMMKkOd.',OWMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0x:::dOWMMMMMMMMNXKx;;.';d0WMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMOl:::lKMMMMMMMMMMMMMMW00OOOONMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0:::::KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo::::oWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
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

    wget $repourl/$l10nprefix-$locale.tar.xz || ok=0

    handle_error

    echo "Deskargatuta."
}

apply_l10n() {
    echo ""
    echo "Itzulpena aplikatzen. Honek luze jo dezake..."

    # Aplikatu itzulpena
    tar -xvf $l10nprefix-$locale.tar.xz -C "$path"

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
