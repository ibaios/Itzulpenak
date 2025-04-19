#!/usr/bin/env bash

gamefolder="Owlboy/content/localizations"
repourl=https://ibaios.eus/itzulpenak
gameurl=owlboy
l10nfile=owlboy-eu.tar.xz
tempfolder=.owlboy-eu-instalazioa
gamename="Owlboy"
email=ibaios@disroot.org

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

initial_config() {
	# Aukeratu denda
	while true; do
		read -p "Zein dendatatik instalatu duzu jokoa?
		1: Steam
		2: GOG
		3: Beste bat
		(idatzi 1, 2 edo 3 eta sakatu SARTU tekla)
		" storeop
		case $storeop in
		    1 ) store='steam'; break;;
		    2 ) store='gog'; break;;
		    3 ) store='other'; break;;
		    * ) echo "
		    OKERREKO AUKERA. Idatzi 1 (Steam), 2 (GOG) edo 3 (Beste bat) eta sakatu SARTU tekla.
		    ";;		
		esac
	done
}

get_steam_path() {
	echo "STEAM dendako jokoaren instalazioa bilatzen..."	
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
}

get_gog_path() {
	echo "GOG dendako jokoaren instalazioa bilatzen..."
	paths[0]="`eval echo ~/GOG Games/$gamefolder`"
	
	if [[ ${#paths[@]} > 0 ]]; then
	    if [[ ${#paths[@]} == 1 ]]; then
	    	if [[ -d "${paths[0]}" ]]; then
		        path=${paths[0]}
	        fi
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
}

set_path_manually() {
	read -p "Ez da jokoaren karpeta aurkitu. Idatzi eskuz non dagoen.
    (adb. /home/erabiltzailea/.steam/steam/steamapps/common/$gamefolder)
    Kokalekua: " path
    while [[ ! -d "$path" ]]; do
        read -p "Sartutako kokalekua ez da existitzen. Saiatu berriz.
        (adb. /home/erabiltzailea/.steam/steam/steamapps/common/$gamefolder)
        Kokalekua: " path
    done
}

get_game_path() {
	path=""
	paths=()

	case $store in

		steam)
		get_steam_path
		;;
		
		gog)
		get_gog_path
		;;
		
	esac
	
	if [[ -z "$path" ]]; then
		set_path_manually
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
	echo "Itzulpen-fitxategia deskargatzen..."

	# Deskargatu itzulpen-fitxategia
	wget "${repourl}/${gameurl}/${l10nfile}" || ok=0

	handle_error

	echo "Deskargatuta."
}

apply_l10n() {
	echo ""
	echo "Itzulpena aplikatzen..."

	# Aplikatu itzulpena
	tar -xJf ./"${l10nfile}" -C "${path}" || ok=0

	handle_error
	
	echo "Aplikatuta."
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

initial_config

ok=1

get_game_path

create_temp_folder

download_l10n

apply_l10n

final_message

exit 0

