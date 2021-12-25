#!/usr/bin/env bash

detect_lang="$(echo "${LANG}" | cut -f1 -d.)"
case "${detect_lang}" in
    es_*)
      xmas_msg='FELICES FIESTAS'
      ny_msg='Y mucho CODIGO en'
      code_word=(C O D I G O)
      code_offset=-3
      ;;
    *)
      xmas_msg='MERRY CHRISTMAS'
      ny_msg='And lots of CODE in'
      code_word=(C O D E)
      code_offset=0
      ;;
esac
new_year=$(date +'%Y')
let new_year++
ny_msg="${ny_msg} ${new_year}"

xmas_msg_offset=$((${#xmas_msg} / 2 - 1))
ny_msg_offset=$((${#ny_msg} / 2 - 2))

trap "tput reset; tput cnorm; exit" 2
clear
tput civis
lin=2
col=$(($(tput cols) / 2))
c=$((col-1))
est=$((c-2))
color=0
tput setaf 2; tput bold

# Tree
for ((i=1; i<20; i+=2))
{
    tput cup $lin $col
    for ((j=1; j<=i; j++))
    {
        echo -n \*
    }
    let lin++
    let col--
}

tput sgr0; tput setaf 3

# Trunk
for ((i=1; i<=2; i++))
{
    tput cup $((lin++)) $c
    echo 'mWm'
}
tput setaf 1; tput bold
tput cup $lin $((c - xmas_msg_offset)); echo "${xmas_msg}"
tput cup $((lin + 1)) $((c - ny_msg_offset)); echo "${ny_msg}"
let c++
k=1

# Lights and decorations
while true; do
    for ((i=1; i<=35; i++)) {
        # Turn off the lights
        [ $k -gt 1 ] && {
            tput setaf 2; tput bold
            tput cup ${line[$[k-1]$i]} ${column[$[k-1]$i]}; echo \*
            unset line[$[k-1]$i]; unset column[$[k-1]$i]  # Array cleanup
        }

        li=$((RANDOM % 9 + 3))
        start=$((c-li+2))
        co=$((RANDOM % (li-2) * 2 + 1 + start))
        tput setaf $color; tput bold   # Switch colors
        tput cup $li $co
        echo o
        line[$k$i]=$li
        column[$k$i]=$co
        color=$(((color+1)%8))
        # Flashing text
        sh=1
        for l in ${code_word[*]}
        do
            tput cup $((lin+1)) $((c+code_offset+sh))
            echo $l
            let sh++
            sleep 0.01
        done
    }
    k=$((k % 2 + 1))
done
