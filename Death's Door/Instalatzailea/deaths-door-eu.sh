#!/usr/bin/env bash

itzultool_version=0.4
itzultool_filename=itzultool-"$itzultool_version"-linux-x64
gamefolder=Death\'s\ Door/DeathsDoor_Data
repourl=https://ibaios.eus/itzulpenak
gameurl=deathsdoor
#emipprefix=deaths-door
tempfolder=deaths-door-eu-instalazioa
gamename="Death's Door"
email=ibaios@disroot.org

ascii=$(cat <<'END'
                                                                                
                                     '                                          
                                   :NWK.                                        
                    .    ........ 'WWWWX ............. ....:W:                  
               'lWWxoxOk..KWx::c0'xWWWWW.OddNNddK.OW:  .WK..dooc'               
                 NW.   lX oW.   . 0WWWWW,.  KK  . xW.  .Wx :Wd .;               
                 0W.    WxoW.     XWO0xX:   N0    OW.  .Wl 'WO                  
                 kW'    WxoWoccx  0K; :Wl   Wk    KWlccdW:  :WO                 
                 dW;   cW,oW   , .Wd  .Nd   Wx    NW...lW,   'W0                
                 xWl.'lNl xN....:.W.   kx  .Wk    WX   oW..   KW                
                loccccc,.;doc::lc.o:'''l; .col.  :do. .ld':kokK:                
                     .;0WO:cdKo   :dxo;   :kkkkc ,ONxcldd.                      
                       cWd    Xk 00. .X0 ON'  .KK lW,   xN                      
                       ;Wx    dW:W;   dW:Wk    ;W:lW'   O0                      
                       'Wk    xW;W;   kW.Wx    .WllWodk:'                       
                       .W0   .N0 k0'.dN: kX    :W.oW. K;  .                     
                      .cWX:lxXk.  .''.    oOl:lx. OW; ;NOKd                     
                      .......                     ..    ..                      
END
)

endascii=$(cat <<'END'
                                             ...                                          
                                         .,lkXWXOl'                                       
                                      .;xXWWWWWWWWWKd'                                    
                                    .oXWWWWWWWWWWWWWWW0l.                                 
                                  .dNWWWWWWWWWWWWWWWWWWWXl.                               
                                 :XWWWWWWWWWWWWWWWWWWWWWWW0'                              
                                oWWWWWWWWWWWWWWWWWWWWWWWWWWNc                             
                               xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWo                            
                              dWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWc                           
                             ;WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWN.                          
                            .XWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWx                          
                            :WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWX                          
                            OWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWN.                         
                           .XWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW;                         
                           .NWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWd                         
                           'WWWWWWWWWWWWKxlc:;,c:...:KNWWWWWWWWWk                         
                           ;WWWWWWWWWWW0,     0WWX.   ..'lXWWWWW0                         
                           lWWWWWWWWWWWWWO    oKKd.  .,;clxNWWWWK                         
                           kWWWWWWWWWWWWWd           NWWWWWWWWWWN                         
                           0WWWWWWWWWWWWWc           XWWWWWWWWWWN.                        
                           XWKxxkNWWWWWWW,           KWWWWWWWWWWW.                        
                          .NWc   oWWWWWWN.           kWWWWWWWWWWW'                        
                          .NWK;,. :ONWWWo            cWWWWWWWWWWW,                        
                          .NWWWWWO; .lKK             .NWWWWWWWWWW;                        
                          'WWWWWWWWKl. .              kWWWWWWWWWWc                        
                          ,WWWWWWWWWWN.               'WWWWWWWWWWo                        
                          ;WWWWWWWWWWc                 kWWWWWWWWWx                        
                          cWWWWWWWWWo                  .NWWWWWWWWO                        
                          oWWWWWWWWk                    xWWWWWWWW0                        
                          dWWWWWWWK.                    'WWWWWWWWK                        
                          kWWWWWWN.                      OWWWWWWWK                        
                          OWWWWWWl                       :WWWWWWWX                        
                          OWWWWWN.                       .NWWWWWWX.                       
                          KWWWWWN                         0WWWWWWN.                       
                         .XWWWWWN.                        xWWWWWWN.                       
                         .NWWWWWW:                        kWWWWWWN.                       
                         .NWWWWWWX... .:::  ,..,:;  ,... .NWWWWWWN.                       
                         .WWWWWWWWNNNKWWWd :WWWWW0 .NNNWXNWWWWWWWW'                       
                         .XNNNNWWWWWWWWWWc KWWWWW0 ,WWWWWWWWWWWWW0.                       
                             .....''',;;:..::::::; .:;;;;;,'''''.                         
                                                                                          
END
)

echo "$ascii"

echo "$gamename euskaraz - Instalatzen..."

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

echo "ItzulTool deskargatzen..."

# Deskargatu ItzulTool
wget https://github.com/ibaios/itzultool/releases/download/v"$itzultool_version"/"$itzultool_filename"

chmod +x ./"$itzultool_filename"

echo "Deskargatuta."

echo "EMIP itzulpen-fitxategiak deskargatzen..."

# Deskargatu EMIP fitxategiak
wget $repourl/$gameurl/sharedassets16-eu-$locale.emip
wget $repourl/$gameurl/level2-eu-$locale.emip
wget $repourl/$gameurl/level3-eu-$locale.emip
wget $repourl/$gameurl/level15-eu-$locale.emip
wget $repourl/$gameurl/level18-eu-$locale.emip
wget $repourl/$gameurl/level20-eu-$locale.emip
wget $repourl/$gameurl/level21-eu-$locale.emip
wget $repourl/$gameurl/level22-eu-$locale.emip
wget $repourl/$gameurl/level25-eu-$locale.emip

echo "Deskargatuta."
echo "Itzulpena aplikatzen..."

# Aplikatu itzulpena
ok=1
./"$itzultool_filename" applyemip sharedassets16-eu-$locale.emip "$path" || ok=0
./"$itzultool_filename" applyemip level2-eu-$locale.emip "$path" || ok=0
./"$itzultool_filename" applyemip level3-eu-$locale.emip "$path" || ok=0
./"$itzultool_filename" applyemip level15-eu-$locale.emip "$path" || ok=0
./"$itzultool_filename" applyemip level18-eu-$locale.emip "$path" || ok=0
./"$itzultool_filename" applyemip level20-eu-$locale.emip "$path" || ok=0
./"$itzultool_filename" applyemip level21-eu-$locale.emip "$path" || ok=0
./"$itzultool_filename" applyemip level22-eu-$locale.emip "$path" || ok=0
./"$itzultool_filename" applyemip level25-eu-$locale.emip "$path" || ok=0

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
