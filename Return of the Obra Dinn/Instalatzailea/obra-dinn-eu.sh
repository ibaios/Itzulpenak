#!/usr/bin/env bash

gamefolder=ObraDinn/ObraDinn_Data
repourl=https://ibaios eus/itzulpenak
gameurl=obradinn
tempfolder=obra-dinn-eu-instalazioa
gamename="Return of the Obra Dinn"
email=ibaios@disroot org

ascii=$(cat <<'END'
     ,-                                                   
     |  )     |                      ,-   |   |           
     |-<  ,-  |-      ;-  ;-    ,-   |    |-  |-  ,-      
     |  \ |-' |   | | |   | |   | |  |-   |   | | |-'     
     '  ' `-' `-' `-` '   ' '   `-'  |    `-' ' ' `-'     
                                    -'                    
                                                          
     x~X88888Hx        uW8"                               
   H8X 888888888h    `t888           u                    
  8888:`*888888888:   8888         d88B :@8c        u     
  88888:        `%8   9888 z88N  ="8888f8888r    us888u   
  `88888          ?>  9888  888E   4888>'88"   @88 "8888" 
`  ?888%           X  9888  888E   4888> '    9888  9888  
  ~*??             >  9888  888E   4888>      9888  9888  
  x88888h         <   9888  888E   d888L  +   9888  9888  
:"""8888888x     x    8888  888"  ^"8888*"    9888  9888  
`    `*888888888"     `%888*%"       "Y"      "888*""888" 
        ""***""          "`                    ^Y"   ^Y'  
                                                          
                                                          
                                                          
                                                          
     xH888888Hx         @88>                              
   H8888888888888:      %8P      u     u       u     u    
  888*"""?""*88888X            x@88k u@88c   x@88k u@88c  
' f     d8x    ^%88k    @88u  ^"8888""8888" ^"8888""8888" 
 '>    <88888X   '?8  ''888E`   8888  888R    8888  888R  
  `:  :`888888>    8>   888E    8888  888R    8888  888R  
         `"*88     X    888E    8888  888R    8888  888R  
     xHHhx  "      !    888E    8888  888R    8888  888R  
   X88888888hx    !     888&   "*88*" 8888"  "*88*" 8888" 
  !   "*888888888"      R888"    ""   'Y"      ""   'Y"   
         ^"***"`         ""                               
                                                          
END
)

endascii=$(cat <<'END'
                                                                                
                                               ,,,,,                            
                                          ,,,,'''''',,,,                        
                                         ;,    ,,,,     :                       
                                        c'  ,coo;;;:c,   :'                     
                                        l  c:;l     '::, :'                     
                                       :'  ,;,,,,,,,,c:, :'                     
                                    ';:o,'   c,,,,, ';'  c                      
                             ,cddkkKKKKKKK0kkxkoccc     c                       
                         ,:dd0KXNXcdWWWWWWWWd,XWXKK0dddl                        
                      ';cOKNWWWWWWk,NNKKKXWN:xWWWWWWWX0KOc'                     
                    ,;;x0cdWWWWW0kxlclcllllc:oxONWWWNkcXK0Xk,                   
                  ,;cxKWW0l:K0dlcolcccc::::loxollok0;d0WWWKKNc                  
                 ;,:0WNXWWNxcooc;             ,;oolcxNWWWWWW0XO'                
                ;;;kKXWWWKccol;     ;oxX0xdl,    'dlll0WWWWWWONN;               
               c';ocookKOocc:      lXWWWWWWWWO'    lcll0X00oxWxWX               
               c'lkoxkxK:lll      ,ldd0NWWWWWKl     lllcKOkOKWXOWl              
              : ,okOOOKx:ll:      O0c;:ok;'cO,      oolcKWWWWWWxWN              
              c coddk0Kk:oc;      ;o0K:'K0odx       ocolKWWWWWWkWW'             
              c :llxdOx0;lcl'     cl'':;l:c;       ,ooo,NKNWWWWxWW'             
              c cc:c;:oOlcolc:     dKOddd:        :llll0WdlclkWxWW'             
              ,, ococdxOOd;lccc'     ;;,        ;lollc0WWWWWWWONWO              
               c ,lcoldx0xOlcdcoc,'          ''dclclxNWWWWWWWK0WX;              
               ;l ,oc:oxkdkKkd:olollc:,::;:dlllccoxX00NWWWWWX0WKl               
                cd ,o:l:'':k0K0Oklllcclllll:codO0WWWKc:kNWW0XWXo                
                 :d  :l:coxdx00KKWXXKK0Ok0KK0WWWWWWWWW0oXKKWNkx                 
                  :d:  ;lcoxxkk000'oXWWWWWWN';NWWWWWWWXKKWKx:c'                 
                   ,ccc,   ;coOx0; 0XXWNNWWWd,xWWWNXKKXXK0d,,,                  
                    ',';c;'   ,:looO0K0XNNNWKO000K0Kdcolc,,,                    
                      'l;cdolc,   ,''''c,cc:c,;,,;ccl:' ,;                      
                       c   ',:ldccccccc;,,;ccccccc,  ,,,                        
                       ;,,,,    ,,,;:::cclcl     ',,'                           
                            ,,,,,,,,       o,,,,,                               
                                    ,,,,,,:,                                    
                                                                                
END
)


echo "$ascii"

echo "$gamename euskaraz - Instalatzen   "

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
        OKERREKO AUKERA  Idatzi 1 (Gaztelania) edo 2 (Frantsesa) eta sakatu SARTU tekla 
        ";;		
    esac
done

# Bilatu jokoaren kokalekua
path=""
paths=()


steamconfigpath=~/ steam/steam/config/libraryfolders vdf
if [[ ! -f "$steamconfigpath" ]]; then
    steamconfigpath=~/ var/app/com valvesoftware Steam/ local/share/Steam/config/libraryfolders vdf
    if [[ ! -f "$steamconfigpath" ]]; then
        steamconfigpath=""
        echo "EZIN IZAN DA STEAMEKO KONFIGURAZIO FITXATEGIA AURKITU "
    fi
fi

if [[ ! -z "$steamconfigpath" ]]; then
    while read -r line; do
        if [[ $line == \"path\"* ]]; then
            base=$(echo $line | cut -d '"' -f 4)
            optpath="$base"/steamapps/common/$gamefolder
            if [[ -d "$optpath" ]]; then
                paths+=("$optpath")
                #echo "Konfigurazioan $optpath aurkitu da   "
            fi
        fi
    done < "$steamconfigpath"

    if [[ ${#paths[@]} > 0 ]]; then
        if [[ ${#paths[@]} == 1 ]]; then
            path=${paths[0]}
        else
            # Galdetu erabiltzaileari
            echo "Jokoarentzako karpeta posible bat baino gehiago aurkitu dira  Zein da jokoaren benetako karpeta?"
            select selpath in "${paths[@]}"; do
                if [[ -z "$selpath" ]]; then
                    printf 'Okerreko aukera \n' "$selpath" >&2
                else
                    path="$selpath"
                    break
                fi
            done
        fi
    fi
fi

if [[ -z "$path" ]]; then
    read -p "Ez da jokoaren karpeta aurkitu  Idatzi eskuz non dagoen 
    (adb  /home/erabiltzailea/ steam/steam/steamapps/common/$gamefolder)
    Kokalekua: " path
    while [[ ! -d "$path" ]]; do
        read -p "Sartutako kokalekua ez da existitzen  Saiatu berriz 
        (adb  /home/erabiltzailea/ steam/steam/steamapps/common/$gamefolder)
        Kokalekua: " path
    done
fi

echo "Path: $path"

# Instalaziorako karpeta sortu
mkdir $tempfolder
cd $tempfolder

echo "Itzulpen-fitxategia deskargatzen   "

# Deskargatu ASSETS fitxategia
wget $repourl/$gameurl/lang-$locale

echo "Deskargatuta "
echo "Itzulpena aplikatzen   "

# Aplikatu itzulpena
ok=1
cp lang-$locale "$path/StreamingAssets/" || ok=0

if [[ $ok == 0 ]]; then
    echo "Huts egin du "
    echo "Instalazioko fitxategiak ezabatzen   "
    cd   
    rm -R $tempfolder/

    # Errorea
    echo ""
    echo "✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗"
    echo "✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗ ✗"
    echo ""
    echo "Arazoren bat gertatu da $gamename jokoaren euskaratzea instalatzean  Saiatu berriro edo idatzi $email helbidera lagun zaitzadan "
else
    echo "Aplikatuta "
    echo "Instalazioko fitxategiak ezabatzen   "
    cd   
    rm -R $tempfolder/

    # Instalatuta!
    echo ""
    echo "$endascii"
    echo ""
    echo "✔  Instalazioa behar bezala burutu da  Orain $gamename euskaraz izango duzu "
fi
