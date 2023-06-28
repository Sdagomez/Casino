#!/bin/bash


#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


function ctrl_c(){
  echo -e "\n\n[!] Saliendo....\n"
  exit 1
}

# Ctrl+c
trap ctrl_c INT

function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} uso:${endColour}"
  echo -e "\t${purpleColour}m) Monto a ingresar al casino${endColour}"
  echo -e "\t${purpleColour}t) Tecnica a utilizar ${turquoiseColour} (martingala/inverseLabrouchere)${endColour}"
  echo -e "\t${purpleColour}h) Mostrar este panel de ayuda${endColour}"
}

function martingala (){
  echo -e "\n[+]${greenColour} Vamos a jugar con la tecnica martingala${endColour}"

}

while getopts "m:t:h" arg; do
  case $arg in
    m)money="$OPTARG";;
    t)technique="$OPTARG";;
    h);;
  esac
done

if [[ $money ]] && [[ $technique ]]; then
  echo "golang"
  if [[ "$technique" == "martingala" ]]; then
    martingala
  else
    echo -e "\n$redColour[!]${redColour} No existe ninguna tecnica con ese nombre ${endColour}\n"
  fi
else 
  helpPanel
fi
