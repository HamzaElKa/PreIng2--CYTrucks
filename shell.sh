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
if [ "$#" -eq 0 ]; then 
    echo "Veuillez spécifier au moins un traitemnt."
    exit 1
fi
fichier="$1"
shift
option_h=0
for arg in "$@"; do
    if [ "$arg" = "-h" ]; then
        echo "Affichage de l'aide"
        option_h=1
        break 
    fi
done
if [ "$option_h" -eq 1 ]; then
    exit 0
fi
#cut -d';' -f5 temp.csv  |  sort -n -r  | head -n10  #traitement L

for arg in "$@"; do
   case "$arg" in
   "-d1") 
   echo "Traitement d1 : ";;
   "-d2")
   echo "Traitement d2 : " ;;
   "-l")
   echo "Traitement l : " ;;
   "-t") 
   echo "Traitement t : ";;
   "-s") 
   echo "Traitement s : ";;
    *)
    echo "Option non reconnue : $arg";;
   *) 
   echo "$arg existe pas ";;
   esac
done

