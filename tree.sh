#!/bin/bash

trap onexit 2

START_LINE=2
CROWN_HEIGHT=10
TRUNK_HEIGHT=2
MSG_LANG=en

CENTER=$(($(tput cols)/2))

function main() {
   
    parsed_args=$(getopt -o l:Lh -l language,list-languages,help -n 'tree.sh' -- "$@")
    getopt_exit_code=$?

    if [ $getopt_exit_code -ne 0 ] ; then
        exit 1
    fi

    eval set -- "$parsed_args"

    while :; do
        case "$1" in
            -h | --help ) show_help; exit 1 ;;
			-L | --list-languages ) listlangs; exit ;;
			-l | --language ) MSG_LANG="$2"; shift 2 ;;
            -- ) shift; break ;;
            * ) break ;;
        esac
    done
    
    validate_language && source ./langs/$MSG_LANG
    empty_screen

    show_tree_crown
    show_tree_trunk
    show_messages
    
    animate

}

function listlangs() {
cat << EOF
Code     Language
----     --------
es       English (default)
en       Spanish
EOF
}

function validate_language() {
    if [ $(echo -n "$MSG_LANG" | wc -c) -ne 2 ] || [ ! -f "./langs/$MSG_LANG" ] ; then
        err "language code $MSG_LANG isnt supported"
    fi
}

function empty_screen() {
    clear
    tput civis
}

function show_tree_crown() {
    tput setaf 2 
    tput bold

    for i in $(seq 1 $CROWN_HEIGHT); do
        tput cup $((START_LINE + i - 1)) $((CENTER - i + 1))
        for j in $(seq 1 $(((i-1)*2 + 1))); do
            echo -n '*'
        done
    done
}

function show_tree_trunk() {
    tput sgr0
    tput setaf 3

    for i in $(seq 1 $TRUNK_HEIGHT); do
        tput cup $((START_LINE + CROWN_HEIGHT + i - 1)) $((CENTER - 1)) 
        echo 'mWm'
    done
}

function show_messages() {
    tput setaf 1
    tput bold

    mc_length=$(echo -n "$MERRY_CHRISTMAS" | wc -c)
    loc_length=$(echo -n "$AND_LOTS_OF_CODE_IN_NEW_YEAR" | wc -c)

    tput cup $((START_LINE + CROWN_HEIGHT + TRUNK_HEIGHT)) $((CENTER - mc_length / 2))
    echo $MERRY_CHRISTMAS

    tput cup $((START_LINE + CROWN_HEIGHT + TRUNK_HEIGHT + 1)) $((CENTER - loc_length / 2))
    echo $AND_LOTS_OF_CODE_IN_NEW_YEAR
}

function animate() {
	
    color=0
    turn_off=false
    code_index=$(echo "$AND_LOTS_OF_CODE_IN_NEW_YEAR" | grep "$CODE" -bo | cut -d ':' -f1)
    loc_length=$(echo -n "$AND_LOTS_OF_CODE_IN_NEW_YEAR" | wc -c)
    xmem=()
    ymem=()

	# lights and decorations
	while :; do
    	for i in $(seq 1 36); do
			
            if $turn_off ; then
                tput setaf 2
                tput bold
                tput cup ${ymem[$i]} ${xmem[$i]}
                unset xmem[$i]
                unset ymem[$i]
                echo -n '*'
            fi

            y=$(((RANDOM % (CROWN_HEIGHT - 1)) + 1))
            x=$((((RANDOM % y) + 1) * 2 - 1))

            ymem[$i]=$((START_LINE + y))
            xmem[$i]=$((CENTER - y + x))

            tput setaf $color
            tput bold
            tput cup ${ymem[$i]} ${xmem[$i]}
            echo o

            color=$(((color + 1) % 8))
            cpos=0

            for c in $(echo -n "$CODE" | grep -o .); do
                tput cup $((START_LINE + CROWN_HEIGHT + TRUNK_HEIGHT + 1)) $(((CENTER - loc_length / 2) + code_index + cpos))
                echo -n $c
                cpos=$((cpos + 1))
                sleep 0.01
            done
		done
		
        $turn_off && 
            turn_off=false || 
            turn_off=true
    done
}

function err() {
    printf "tree.sh: %s\n" "$@" >&2
    exit 1
}

function show_help() {
    echo Usage: tree.sh [ -hL ] [ -l language_code ]
    echo Options are:
    echo '     -l | --language                uses the specified language (english default)'
    echo '     -L | --list-languages          list all supported languages'
    echo '     -h | --help                    display this message and exit'
}

function onexit() {
    tput reset
    tput cnorm
    exit
}

main "$@"
