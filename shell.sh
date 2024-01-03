#!/bin/bash

echo "Bonjour sur votre programme CY-Trucks"

if [ $# -lt 1 ] # si pas d'argument
then
    echo "pas le nbr d'argument"
    exit 1
fi

if [ ! -f $1 ] #si n'est pas un fichier
then 
    echo "$1 n'est pas un fichier"
    exit 2
fi
if [ "$#" -eq 0 ]
then 
    echo "Veuillez spécifier au moins un traitemnt."
    exit 1
fi
fichier="$1"
dos_temp="temp"
dos_images="images"
exe_c="prog_c"
if [ ! -d "$dos_temp" ]; then
    mkdir "$dos_temp"
    echo "Dossier $dos_temp créé."
else
    echo "Le dossier $dos_temp existe déjà."
    rm -r "$dos_temp"/*
    echo "Le dossier $dos_temp a été vidé."
fi
if [ ! -d "$dos_images" ]; then
    mkdir "$dos_images"
    echo "Dossier $dos_images créé."
else
    echo "Le dossier $dos_images existe déjà."
fi
if [ ! -e "exe_c" ]; then
    echo "L'executable C n'existe pas. Compilation en cours..."
    ##gcc
    if [ $? -eq 0 ]; then
        echo "Compilation réussie. "
    else 
        echo "Erreur lors de la compilation."
    fi
else 
    echo "L'executable C existe. "
fi
shift
option_h=0
for arg in "$@"; do
    if [ "$arg" = "-h" ]; then
        echo "Affichage de l'aide"
        option_h=1
        break 
    fi
done
if [ "$option_h" -eq 1 ]
then
    exit 0
fi

for arg in "$@"; do
   case "$arg" in
   "-d1") 
   echo "Traitement d1 : "
   sort -n -t';' -k1 $1 | cut -d';' -f1,5,6 >tmp.csv 
   awk -F ';' '{count[$3" - "$1]++} END {for (i in count) print count[i],i}' tmp.csv | sort -nr | head -n10 >resultatsd1.txt
   ##gnuplot testd1.gnu
;;  
   "-d2")
   echo "Traitement d2 : "
   awk -F';' 'NR>1 {distance[$6] += $5} END {for (driver in distance) if (distance[driver] > 0) print distance[driver] "," driver}' tmp.csv | sort -nr | head -10
   ##gnuplot traitementd2.gnu
    ;;
  
   "-l")

   echo "Traitement l : " 
    sort -n -t';' -k1 $1 | cut -d';' -f1,5,6 >tmp.csv
    awk -F';' 'NR>1 { distances[$1] += $2 } END { for (id in distances) print id,distances[id] }' tmp.csv | sort -n -r -t' ' -k2 | head -n10 >resultats.txt  
    ##gnuplot testl.gnu
    ;;
   "-t") 
   echo "Traitement t : 
   ";;
   "-s") 
   echo "Traitement s : 
   ";;
    *)
    echo "Option non reconnue : $arg";;
   *) 
   echo "$arg existe pas ";;
   esac
done
