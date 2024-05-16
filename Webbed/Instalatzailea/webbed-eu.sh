#!/usr/bin/env bash

gamefolder=Webbed
repourl=https://ibaios.eus/itzulpenak
gameurl=webbed
tempfolder=webbed-eu-instalazioa
gamename="Webbed"
email=ibaios@disroot.org

ascii=$(cat <<'END'
                                                                   
dP   dP   dP  88888888b  888888ba   888888ba   88888888b 888888ba  
88   88   88  88         88    `8b  88    `8b  88        88    `8b 
88  .8P  .8P a88aaaa    a88aaaa8P' a88aaaa8P' a88aaaa    88     88 
88  d8'  d8'  88         88   `8b.  88   `8b.  88        88     88 
88.d8P8.d8P   88         88    .88  88    .88  88        88    .8P 
8888' Y88'    88888888P  88888888P  88888888P  88888888P 8888888P  
                                                                   
END
)

endascii=$(cat <<'END'
                                                                                
                                                                                
               .  ..':.....                                                     
            ,:xxkKXNXXKkolx0K0dk;;                                              
         .xKXXOdlloxkO0Okxocd0kxoclc,'..                                        
      .lOO00KK000Odlllcodxkl:xxxdlllok0KXXXXKdOXOl,'                       ';.  
     ldcc:loxOOOkkkkxxxo::cc:odxxkkkk0KKKK000koccldcdd.              .cdKNXXK0O.
    ,oxoc:::::clodddxdddolox0KKKOxcc:,;xk:cxOOkc.;xc.';;       :;lx0KK0OOOkOkOOo
  .;;KOkxdc:::;;:::cllllclololloodol...';...lOd.   .  .'.   ,d00:;:xolccc::;;,,.
  clOxolc:;;;;;::::;:c;'.,::,.,,..oo .      .xl      ..'. oOxl;,'..''.....      
 dckol:;;;:cllc::::;:l:,cl,;' . . co'.. ... .ld. ..... :;dc;'..                 
.XKo:;;;:loool:;;;c:coddoo;.,..  .loc...... .co;.  .  'c:lodxlo.;'.             
OXkl;;,;loooc;;,:ll::lllll:.',''.:ol;;'.. ..;llc;'....,ooKXXXXXd:cldoc;'.       
0Xd;;,,loolc;,',cc:'.'..';,;;...'':;lxK00l,'''...... ..'lk0KKKKXc',;dkKXKdl     
KOc,,';ccc;,'',;;;,..,;';:ckKKxc,.';kKXXXXXd..'..,,. ....,lx0KKK0;'.,:ldk0KX,   
Xx;'',;;;;''..,,'';,:kko,.:okOOOxo;,;okKKKKKO:. .'. ....   :ldxddo    .',:ldk   
:d;'',;,,,''.'''cKXxcdd00d,.;oo;::oxx:,cxO00K0.                                 
;x;''';.'..''';lxkkdlldkKKc. .',cx00KXOl:,:ll;.    .d                           
 l:''';''..'ooooddo:.'odOkd'.  .,ok00KXXKx;.. ......:d                          
  ',''','':ddlkxxk:...,oxc:lo,. ..,dOKNNNXKOl   '...;:                          
   ;,..';x0xccOxkkc.....lxoOK0o'....cdk0000O:   :''';;                          
    .,';00kl,oOkkk;..'...oxO0XKO:  ;'.,c,       l''':.                          
      'dOOl;;oolxd'.......cdk0KXO  x,''..       d,'';.                          
     .kxdl:.'odox: .....   .ok0o   k,''..       d;''c                           
    .KOOo;...dxxk;.                k,'''           .                            
   0X0ko;'.  dxxd,                 ::'':                                        
  cKOxl;,.  .dxo:.                                                              
 .Oxoc,'     oo;                                                                
   .,.                                                                          
                                                                                
END
)


echo "$ascii"

echo "$gamename euskaraz - Instalatzen..."

# Aukeratu gainidatziko den hizkuntza - Beti EN oraingoz
locale="en"

# Bilatu jokoaren kokalekua
path=""
paths=()


steamconfigpath=~/.steam/steam/config/libraryfolders.vdf
if [[ ! -f "$steamconfigpath" ]]; then
    steamconfigpath=~/.var/app/com.valvesoftware.Steam/.local/share/Steam/config/libraryfolders.vdf
    if [[ ! -f "$steamconfigpath" ]]; then
        steamconfigpath=""
        echo "EZIN IZAN DA STEAMEKO KONFIGURAZIO FITXATEGIA AURKITU."
    fi
fi

if [[ ! -z "$steamconfigpath" ]]; then
    while read -r line; do
        if [[ $line == \"path\"* ]]; then
            base=$(echo $line | cut -d '"' -f 4)
            optpath="$base"/steamapps/common/$gamefolder
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

if [[ -z "$path" ]]; then
    read -p "Ez da jokoaren karpeta aurkitu. Idatzi eskuz non dagoen.
    (adb. /home/erabiltzailea/.steam/steam/steamapps/common/$gamefolder)
    Kokalekua: " path
    while [[ ! -d "$path" ]]; do
        read -p "Sartutako kokalekua ez da existitzen. Saiatu berriz.
        (adb. /home/erabiltzailea/.steam/steam/steamapps/common/$gamefolder)
        Kokalekua: " path
    done
fi

echo "Path: $path"

# Instalaziorako karpeta sortu
mkdir $tempfolder
cd $tempfolder

echo "Itzulpen-fitxategia deskargatzen..."

# Deskargatu ASSETS fitxategia
wget $repourl/$gameurl/webbed-eu-$locale.csv

echo "Deskargatuta."
echo "Itzulpena aplikatzen..."

# Aplikatu itzulpena
ok=1
mv "$path"/translations.csv "$path"/translations.csv.bak || ok=0
cp ./webbed-eu-$locale.csv "$path"/translations.csv || ok=0

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
    echo "Arazoren bat gertatu da $gamename jokoaren euskaratzea instalatzean. Saiatu berriro edo idatzi $email helbidera lagun zaitzadan."
else
    echo "Aplikatuta."
    echo "Instalazioko fitxategiak ezabatzen..."
    cd ..
    rm -R $tempfolder/

    # Instalatuta!
    echo ""
    echo "$endascii"
    echo ""
    echo "✔  Instalazioa behar bezala burutu da. Orain $gamename euskaraz izango duzu."
fi