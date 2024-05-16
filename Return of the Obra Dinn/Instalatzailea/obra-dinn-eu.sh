#!/usr/bin/env bash

gamefolder=ObraDinn/ObraDinn_Data
repourl=https://ibaios.eus/itzulpenak
gameurl=obradinn
tempfolder=obra-dinn-eu-instalazioa
gamename="Return of the Obra Dinn"
email=ibaios@disroot.org

ascii=$(cat <<'END'
     ,-.      .                           .   .           
     |  )     |                      ,-   |   |           
     |-<  ,-. |-  . . ;-. ;-.   ,-.  |    |-  |-. ,-.     
     |  \ |-' |   | | |   | |   | |  |-   |   | | |-'     
     '  ' `-' `-' `-` '   ' '   `-'  |    `-' ' ' `-'     
                                    -'                    
        ....               ..                             
    .x~X88888Hx.     . uW8"                               
   H8X 888888888h.   `t888          .u    .               
  8888:`*888888888:   8888   .    .d88B :@8c        u     
  88888:        `%8   9888.z88N  ="8888f8888r    us888u.  
. `88888          ?>  9888  888E   4888>'88"  .@88 "8888" 
`. ?888%           X  9888  888E   4888> '    9888  9888  
  ~*??.            >  9888  888E   4888>      9888  9888  
 .x88888h.        <   9888  888E  .d888L .+   9888  9888  
:"""8888888x..  .x   .8888  888"  ^"8888*"    9888  9888  
`    `*888888888"     `%888*%"       "Y"      "888*""888" 
        ""***""          "`                    ^Y"   ^Y'  
                                                          
                                                          
                                                          
        ....             .                                
    .xH888888Hx.        @88>                              
  .H8888888888888:      %8P      u.    u.      u.    u.   
  888*"""?""*88888X      .     x@88k u@88c.  x@88k u@88c. 
' f     d8x.   ^%88k   .@88u  ^"8888""8888" ^"8888""8888" 
 '>    <88888X   '?8  ''888E`   8888  888R    8888  888R  
  `:..:`888888>    8>   888E    8888  888R    8888  888R  
         `"*88     X    888E    8888  888R    8888  888R  
    .xHHhx.."      !    888E    8888  888R    8888  888R  
   X88888888hx. ..!     888&   "*88*" 8888"  "*88*" 8888" 
  !   "*888888888"      R888"    ""   'Y"      ""   'Y"   
         ^"***"`         ""                               
                                                          
END
)

endascii=$(cat <<'END'
....................................................................................................
..........................................................,;;;;;;'..................................
.....................................................,;;;;.......,;;,...............................
....................................................:,...............;:.............................
...................................................:'...,:dxoooll:'....;:...........................
..................................................l'..,:o;l'...',c::'...d...........................
..................................................o..'l;lll,,.....:;:,..d...........................
.................................................;c...,:,'''',;;,.c;c'..o...........................
.................................................;c.....:;;;,...',c;'..:;...........................
......................................';:oodkdx000xddc::xooc,;o,......;;............................
..................................';oxOk00kOKWWWWWWWWWWXcx000xdoc'...'c.............................
..............................';cdkx0KWWWWl.lWWWWWWWWWWx.oNWWWN000OO0o..............................
............................;;:d0KWWWWWWWWN;;NWNNNNNWWN;,NWWWWWWWWN0kKKd'...........................
..........................,;;d0xxWWWWWWWNXOdlldlc;;olollox0WWWWWWWNkON0OW0c.........................
........................,;:dkWNd,:kXWXOxccocllodoololddloo::dxKWNoc;oXWNKOW0;.......................
......................'c'd0WNWWWNxodkcoco:cc'',,.....',:ocolod;lldkWWWWWWW0KWo......................
.....................;;.d0WNXXWWNKccld:;...................,lodlllOWWWWWWWWK0W0,....................
....................;:.lkKXXWWWNoccdc;,......,oo0XKkkol;......:dllooXWWWWWWWXkWN;...................
...................c,.ld:Ok0XNXoll:o.......'d0WWWWWWWWWW0:.....,dcoclXWNWNOXW00WX'..................
..................'c.cdllcc,dOooclc........'cXXWWWWWWWWWWX;.....'lo:llNocc:oXWxXWo..................
..................c,;:kkOOKXX0;loo:.......'O;,.;lKWKOOWWoo.......ocol:0WWWWWWWKOWN,.................
..................o.,ooOxkkXKo;lol:.......;WXdlccok;..'kl'.......cxolc0WWWWWWWWdWWO.................
.................:;.looxokO0Xdcc:o,........coKXx..xNOoxK,........oocll0WWWWWWWWxNW0.................
.................:;.::dlxkO0Kx;oll:.......;c'.':lcOl;o:.........'klll;XWWWWWWWWdWW0.................
.................;:.clckccl'kX,l:ol:,......:XO:,.''.c'..........olllooWx;ook0KWdWW0.................
..................d.'d;:o;lok0Occ:ocl,......;d00K0xl,.........:dcclcdWWWK0xddW00WWo.................
..................c,.lccllldxkkkllc:llc'....................;ddlll;xNWWWWWWWWNxWWX;.................
..................,:..o:clodxx0x0dllocol::..............',;dlclcloXWWWWWWWWWWkXWXd..................
...................lc..ll:llxxk00KOxdcllocolc:,,'';,,co:cdclolcdKWWNWWWWWWWWxWWXo'..................
....................xc..lo;looo''l00Xkxlc:ccolococclollcll:loxXWWk:;KNWWWWXOWWNd;...................
.....................xd..:ld,;';ddxO0OXKNkOkoll:o::;ddldxKXNWWWWWWXo,lKWNK0WWNx:....................
......................do...,l:lodxdkKk0KKWK0KWWWNNNNWWWk0WWWWWWWWWWWNkX0KWWKxdl.....................
.......................odl...:ocdlxkkk00OX:.kXWWWWWWWWN,.oWWWWWWWWWWK0KWNkd:;c......................
........................:clo;...''lodxOk0d.;0XNXNWXWWWWk.:NWWWWWN000XWNK0x,.l.......................
.........................:;.:o;....';:cxkdcdN0XXNXWWWWWNdx0WWK00KK0kooOd:.;,........................
..........................';,'ddo:,....':;:lxdxkkKKOkO00kxxkkOOkdccooc'.;,..........................
............................'x';:oooll:'...'....,,';;:;,;''',,:lll;...,:............................
............................;:.....;;:ldooooccccc;;,,:ccooooll;...';;;..............................
.............................l;''......,;;;;lllllocollo,......',;;,.................................
...............................,;;;;;;,'..........';,.d',;;;;;;.....................................
.......................................;;;;;;;,'.....,l;,...........................................
...............................................,,;;;;:..............................................
....................................................................................................
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

echo "Itzulpen-fitxategia deskargatzen..."

# Deskargatu ASSETS fitxategia
wget $repourl/$gameurl/lang-$locale

echo "Deskargatuta."
echo "Itzulpena aplikatzen..."

# Aplikatu itzulpena
ok=1
cp lang-$locale "$path/StreamingAssets/" || ok=0

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
