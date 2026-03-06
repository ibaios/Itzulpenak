#!/usr/bin/env bash

itzultool_version=0.4
itzultool_filename=itzultool-"$itzultool_version"-linux-x64
steamfolder=Pummel\ Party/PummelParty_Data
repourl=https://ibaios.eus/itzulpenak/pummelparty
emipprefix=pummel-party-eu
tempfolder=pummel-party-eu-instalazioa
gamename="Pummel Party"
email=ibaios@disroot.org

ascii=$(cat <<'END'
                                                                                
              oOxxxx. dd      ko:Ol     'dd;Oo     .dx.kxxxxx.Oo                
              OK.  kX.O0      NxlXxO; .dx00cNkk:  lkOK,K:     Nk                
              OXdddXl k0      NdcN. ckO; k0cN, :OOc lK,0xlllc Nx                
              OK.     x0      NocX.      k0cN;      lK,0c     Xx                
              OK       lx;;';k0;;X.      kKcX;      lX,0l'.'. Xk''''            
              ..         ....    .        . .        . ...... ......            
        ;;;,''...      .         .,,,''..   .;;;::;;;;;;;;. .;;.        ;:;     
        NWX000KWWc    .X0.       :XXkkk0Kk. .lOOOOKNXOOkkkx. 'KWd     .OWK;     
        NWd.   .NWl  .K0NK.      ;KK.   ,KK,      cXK.         ;NX:  oNXl       
        NWd.   .WWx..KK..0K.     ;XX.   xXX'      cXK.           oWOXWx.        
        NWXKXNNWK;..XX,  .KK'    ;XNKKXXNk,       cXK.            cWW;          
        NWk;.     .KN0xddoOXX'   ;XWl;;OW0'       cXK.            ;WW.          
        NWd.     .KXlc,,,,,;0K'  ;NW,   .KWo      cXK.            ;WW.          
        NWd.    .KK:        .kK' :WW'     oW0'    :XK.            ;NW.          
        ,dc.    ,oc.         .:d..lk.      .ok'   .lx.            .oO.          
                                                                                
END
)

endascii=$(cat <<'END'
                                                                                
                                 .xWMMMMMMMMMMMMMMMMWO'                         
                              .kNX0kxxxxxxxxxxxxxxxxkOKW0c                      
                             0WOocccccccccccccccccccccclxXW.                    
                            0Noccccccccccccccloooolccccccl0M.                   
                           .MxccccccccccccccccclllodolcccclNo                   
                          .kWoccccccccccccccccccccclodlccccXl                   
                      :KWK0OOccccccccccccccccccccccccodlcccN;                   
                     ;Wx:;;;;;cccccccccccccccccccccccldlcclW.                   
                     lX:;;;;;;cccccccccccccccccccccccclcccoN                    
                     lX:;;;;;;:cccccccccccccccccccccccccccxN                    
                     lX:;;;;;;:ccccccccccccccccccccccccccck0                    
                     :N:;;;;;;:ccccccccccccccccccccccccccc0x                    
                      ,0c;;;;;;cccccccccccccccccccccccccccXl                    
                        ckc;;;;ccccccccccdkO0OkoccccccccclN,                    
                          dx:;;ccccccccoKNNNNNNN0lcccccccoW.                    
                            Od::ccccccc0Nd:xKx:xNkcccccccdW                     
                              0dccccccc0NNO:;:0NNkcccccccOx                     
                              .Wc'',;;:0Nx:d0d:xNk:;;,''lN                      
                              .Wc''''''ONXXNNNXXNd''''''lN                      
                              .Wc''''''ONdckXkcxNd''''''lN                      
                              .Wc''''''ONNO:;:0NNd''''''lN                      
                              .Wl''''''ONx:d0o:kNd''''''oW                      
                                 dxl;,'ONKXNNNXXNd',;cxd                        
                                       :0KKKKKK0k,                              
                                                                                
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
