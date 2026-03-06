#!/usr/bin/env bash

itzultool_version=0.4
itzultool_filename=itzultool-"$itzultool_version"-linux-x64
steamfolder=Hollow\ Knight/hollow_knight_Data
repourl=https://ibaios.eus/itzulpenak/hollowknight
emipprefix=hollow-knight-eu
tempfolder=hollow-knight-eu-instalazioa
gamename="Hollow Knight"
email=ibaios@disroot.org

ascii=$(cat <<'END'

'||'  '||'  ..|''||   '||'      '||'       ..|''||   '|| '||'  '|' 
 ||    ||  .|'    ||   ||        ||       .|'    ||   '|. '|.  .'  
 ||''''||  ||      ||  ||        ||       ||      ||   ||  ||  |   
 ||    ||  '|.     ||  ||        ||       '|.     ||    ||| |||    
.||.  .||.  ''|...|'  .||.....| .||.....|  ''|...|'      |   |     
                                                                   
                                                                   
      '||'  |'  '|.   '|' '||'  ..|'''.|  '||'  '||' |''||''|      
       || .'     |'|   |   ||  .|'     '   ||    ||     ||         
       ||'|.     | '|. |   ||  ||    ....  ||''''||     ||         
       ||  ||    |   |||   ||  '|.    ||   ||    ||     ||         
      .||.  ||. .|.   '|  .||.  ''|...'|  .||.  .||.   .||.        
                                                                   
END
)

endascii=$(cat <<'END'
                                                                                
                                                 :xl.                           
                  .oKk                            ,MMK:                         
                 lWMM'                           'dWWWWK.                       
                0WNWMW:                           .NNXXNN.                      
               xNNWMN                               cWXXXK                      
              .WXNMX                                 KNXXNc                     
              cNXNM'                                 ,WXXXk                     
              cNXNM;                                 lWXKXO                     
              .NXXWX.                               ;WNKKN.                     
               kXKXWWc      .,:ldxkO00KKK00Okxdoc;:kWNKKXc                      
                xXKXNMNkxOXWMMMMMMMMMMMMMMMMMMMMMMMWXKKX;                       
                 .XXKXNWMMMMMMMMMMWWWWWWWWWWWWWWNNXXKKK                         
                   ,KKKXXXXXXXXXXXXXKKKKKKKKKKKKKKKK0.                          
                     .KKKKKKKKKKKKKKKKKKKKKKKKKKKKKK:                           
                      0KKKKKKKKKKKKKKKKKKKKKKKKKKKKXd                           
                      dXKKKKKKKKKKKKKKKKKKKKKKKKKKKXx                           
     ...   .     .....:NKKKKKXXXKKKKKKKKKKKX0dodOKKXd  .   ;.                   
        ''.''...''.....KKKKk,. .,xKKKKKKKKK;     ,KXo... .''.                   
  .      ..'..'........lNKO       ;KKKKKKX;       dN:......,;;.                 
    ''',,,'.......  ....KXO        xKKKKKX.       kN.... .,'.                   
          .',,'...... ...NX,       dKKKKKKo      oNc........         .........  
         ........'.......'KKc.   .cKKKKKKKXOc;;lO0; .......:cldddddoodo;        
             .'............lOK0O0KKKKKKKKKKKKX0x:.........:clool:               
            .  ...............;cloddxxdoolc;'.......... .'                      
              .'..........................  ....                                
                 ......................                                         
                        ......                                                  
                                                                                
END
)

# FUNTZIOAK

choose_overridden_lang() {
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
}

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
    #	case $store in

    #		steam)
            get_steam_path
    #		;;
            
    #		gog)
    #		get_gog_path
    #		;;
            
    #	esac

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

download_itzultool() {
	echo ""
	echo "ItzulTool deskargatzen..."

	# Deskargatu ItzulTool
	wget https://github.com/ibaios/itzultool/releases/download/v"$itzultool_version"/"$itzultool_filename" || ok=0

	handle_error

	chmod +x ./"$itzultool_filename" || ok=0

	handle_error

	echo "Deskargatuta."
}

download_emip() {
	echo ""
	echo "EMIP itzulpen-fitxategia deskargatzen..."

	# Deskargatu EMIP fitxategia
	wget "${repourl}/${emipprefix}-${locale}.emip" || ok=0

	handle_error

	echo "Deskargatuta."
}

apply_emip() {
	echo ""
	echo "Itzulpena aplikatzen. Honek luze jo dezake..."

	# Aplikatu itzulpena
	./"$itzultool_filename" applyemip ${emipprefix}-${locale}.emip "$path" || ok=0

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

#initial_config

ok=1

if [[ "$1" == "es" || "$1" == "fr" ]]; then
    locale="$1"
else
    choose_overridden_lang
fi

get_game_path "${2:-}"

create_temp_folder

download_itzultool

download_emip

apply_emip

final_message

exit 0
