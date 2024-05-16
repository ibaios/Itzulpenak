#!/usr/bin/env bash

itzultool_version=0.4
itzultool_filename=itzultool-"$itzultool_version"-linux-x64
gamefolder=TUNIC/Tunic_Data
repourl=https://ibaios.eus/itzulpenak
gameurl=tunic
emipprefix=tunic
tempfolder=tunic-eu-instalazioa
gamename="TUNIC"
email=ibaios@disroot.org

ascii=$(cat <<'END'
                                                                                
                                                                                
   OlccOdccccccl0cccllllkdlclcccl0ccccccccc0cccOoccxxccoOcccc:::::::::::cO:;;   
                                                                                
   XNNNNNNNNNNNNNk 'NNNNl     ONNN0 .XNNXl      ONNO   0XXXk    .:x0XNNNXKkdl   
   XOOOOWMMMNOOO0O  MMMM,     kMMMO  WMMMMNc    OMMx   0MMMd   xWMMMOollodONx   
        NMMMd       MMMM,     kMMMO  WMMMMMMX:  OMMx   0MMMd  oMMMW'            
        NMMMd       MMMM,     kMMMO  WMMldWMMMX;0MMk   0MMMd  0MMMK             
        NMMMd       MMMM;     kMMMO  WMM: .dWMMMMMMk   0MMMd  dMMMN.            
        NMMMd       kMMMNl;,:xMMMW,  WMM:   .xWMMMMx   0MMMd   OMMMNo;'',,:l;   
       .NMMMk        ;kNMMMMMMWKd.  .WMMo     .xWMMx   XMMMO    'dKWMMMMMMN0:   
                         .....                                       ....       
   ;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::;;;;;;;;;;;;;;;,   
       ..               ..       .             ..       .                       
                                                                                
END
)

endascii=$(cat <<'END'
                                                                                
                                                             MXkl,.c  N         
         Mx. .,:oOX                                      MXx;.      ,  NM       
       NM .        .;dK                    MKllKM     MXo.    .,::   oM         
       NMk   doc:,.    .l0         M      k;    ;XM M0;   .,cooodKc   NMN       
        M:  'X0dooooc,.   .oNM       M k:.   '.  .KK,   'loooooxKXK   xMN       
        M'  :XXXkooooool,.  .lNM  Xkl'    .;loo'      'looooooxXXXX,  :M        
        M,  :XXXX0dooooooo:.  .,..     .;loooool    .cooooooodKXXXXc  'M        
        Mc  'XXXXXKxoooooooo;.  ...,:looooooooo:   ,oooooooooKXXXXXc  'M        
       NM0   0XXXXXXkoooooooooloooooooooooooooo.  ,oooooooooOXXXXXX'  cM        
       N M.  ;XXXXXXXkoooooooooooooooooooooooooocloooooooooxXXXXXXO   KMN       
        NMO   xXXXXXXXOooooooooooooooooooooooooooooooooooooKXXXXXX,  ,M N       
          Mo   kXXXX0xc.:oooooooooooooooooooooooooooooooo;lKXXXXXl   KMN        
           Md   lo;.   :ooo;..'loooooooooooooooc'..coooooc  'lOK:  .0MN         
            MO.      .coool    ,ooooooooooooooo.   .ooooooc       ,XM           
             MN:    .looooo:'',loooooooooooooool,.,coooooooc    .xM N           
             NMO   :Oxddooooooooooool:,,;cooooooooooooodxkO0c   OM              
            MNMK.  .;xKXK00Okkxxdddd.     ;ddxxxkkO00KXX0d:.  .l  N             
              N MO;    .;lxOKXXXXXXXKkddxOXXXXXXXX0Odc;.    ,x M                
                    Ol,.     ..',;;:ccccccc:;;,..      .;o0                     
                      MMk   ...                 ...  .XM                        
                     NMX.  .::::::::;;;;;;;::::::::   cM N                      
                    N M'   ;:::::::::::::::::::::::'   kMN                      
                      Mk.   ..;:::::::::::::::::;.    ,KMN                      
                        MKl.    ..',;:::::;,'..    .oXM                         
                            Xx:.               .:xXM                            
                               MN0koc:;;;:cokK M                                
                                                                                
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

echo "EMIP itzulpen-fitxategia deskargatzen..."

# Deskargatu EMIP fitxategia
wget $repourl/$gameurl/$emipprefix-eu-$locale.emip

echo "Deskargatuta."
echo "Itzulpena aplikatzen. Honek luze jo dezake..."

# Aplikatu itzulpena
ok=1
./"$itzultool_filename" decompress "$path"/data.unity3d || ok=0
./"$itzultool_filename" extractassets "$path"/data.unity3d.decomp resources.assets || ok=0
./"$itzultool_filename" applyemip $emipprefix-eu-$locale.emip "$path" || ok=0

# Garbitu
rm "$path"/resources.assets.bak0000 || ok=0

./"$itzultool_filename" replaceassets  "$path"/data.unity3d.decomp "$path"/resources.assets || ok=0

# Garbitu eta bundlearen backupa sortu (hala hautatu badu)
rm "$path"/resources.assets || ok=0

if [[ "$keeporiginal" = true ]]; then
    mv "$path"/data.unity3d "$path"/data.unity3d.bak || ok=0
else
    rm "$path"/data.unity3d || ok=0
fi

# Konprimatu (hala hautatu badu)
if [[ "$compress" = true ]]; then
    ./"$itzultool_filename" compress "$path"/data.unity3d.decomp "$path"/data.unity3d || ok=0
    rm "$path"/data.unity3d.decomp || ok=0
else
    mv "$path"/data.unity3d.decomp "$path"/data.unity3d || ok=0
fi

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
