#!/bin/bash
trap "tput reset; tput cnorm; exit" 2
clear
tput civis
lin=2
col=$(($(tput cols) / 2))
c=$((col-1))
est=$((c-2))
color=0
tput setaf 2; tput bold

# Arbolito
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

# Tronco
for ((i=1; i<=2; i++))
{
    tput cup $((lin++)) $c
    echo 'mWm'
}
new_year=$(date +'%Y')
let new_year++
tput setaf 1; tput bold
tput cup $lin $((c - 6)); echo MERRY CHRISTMAS
tput cup $((lin + 1)) $((c - 10)); echo And lots of CODE in $new_year
let c++
k=1

# Lucecitas y bolitas
while true; do
    for ((i=1; i<=35; i++)) {
        # Apagar luces
        [ $k -gt 1 ] && {
            tput setaf 2; tput bold
            tput cup ${linea[$[k-1]$i]} ${columna[$[k-1]$i]}; echo \*
            unset linea[$[k-1]$i]; unset columna[$[k-1]$i]  # Limpiar el array
        }

        li=$((RANDOM % 9 + 3))
        inicio=$((c-li+2))
        fin=$((c+li+2))
        co=$((RANDOM % (li-2) * 2 + 1 + inicio))
        tput setaf $color; tput bold   # cambiar colorcitos
        tput cup $li $co
        echo o
        linea[$k$i]=$li
        columna[$k$i]=$co
        color=$(((color+1)%8))
        # Texto flashero
        sh=1
        for l in C O D E
        do
            tput cup $((lin+1)) $((c+sh))
            echo $l
            let sh++
            sleep 0.01
        done
    }
    k=$((k % 2 + 1))
done
