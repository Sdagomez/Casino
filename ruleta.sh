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
  echo -e "\n\n${yellowColour}[!]${redColour} Saliendo.... ${endColour}\n"
  tput cnorm;  exit 1
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
  echo -e "\n${yellowColour}[+]${yellowColour} Dinero Actual: $money €${endColour}"
  echo -ne "${yellowColour}[+]${blueColour} Cuanto dinero tienes pensado apostar? --> ${endColour}" && read initial_bed
  echo -ne "${yellowColour}[+]${blueColour} ¿A què deseas apostar continuamente (par/impar)? ${endColour}" && read par_impar

  
  echo -e "\n${yellowColour}[+]${blueColour} Vamos a jugar con la cantidad inicial de $yellowColour $initial_bed${endColour}${blueColour} a $yellowColour$par_impar ${endColour}"

  backup_bed=$initial_bed
  play_counter=1
  jugadas_malas="[ "

  tput civis
  while true; do
    money=$(($money-$initial_bed))
#    echo -e "\n${yellowColour}[+]${blueColour} Acabas de apostar ${yellowColour} $initial_bed € ${endColour}${blueColour} y tienes ${endColour}${yellowColour} $money € ${endColour}"
    random_number="$(($RANDOM % 37))"
#    echo -e "${yellowColour}[+]${blueColour} El nùmero que ha salido es: ${endColour}${yellowColour}$random_number${endColour}"

    if [[ ! "$money" -le 0 ]]; then
      if [[ "$par_impar" == "par" ]]; then 
        if [[ "$(($random_number % 2))" -eq 0 ]]; then
          if [[ "$random_number" -eq 0 ]]; then
#            echo -e "${yellowColour}[!]${redColour} Ha salido 0, por lo tanto perdiste${endColour}"
            initial_bed=$(($initial_bed*2))
            jugadas_malas+="$random_number "
#            echo -e "${yellowColour}[+]${redColour} Ahora mismo te quedas en ${endColour}${yellowColour} $money €  ${endColour}"
          else
#            echo -e "${yellowColour}[+]${blueColour} EL nùmero es par, Ganaste!!! ${endColour}"
            reward=$(($initial_bed*2))
#            echo -e "${yellowColour}[+]${purpleColour} Ganas un total de: ${endColour}${yellowColour} $reward € ${endColour}"
            money=$(($money+$reward))
#            echo -e "${yellowColour}[+]${blueColour} Tienes un total de: ${endColour}${yellowColour} $money € ${endColour}"
            initial_bed=$backup_bed

            jugadas_malas=""
          fi
        else
  #        echo -e "${yellowColour}[+]${redColour} El nùmero es impar, Pierdes!!! ${endColour}"
          initial_bed=$(($initial_bed*2))
          jugadas_malas+="$random_number "
#          echo -e "${yellowColour}[+]${redColour} Ahora mismo te quedas en ${endColour}${yellowColour} $money €  ${endColour}"
        fi     
      fi
    else
      echo -e "${yellowColour}[!]${redColour} Te has quedado sin dinero${endColour}\n"
      echo -e "${yellowColour}[+]${grayColour} Han habido un total de: ${endColour}${yellowColour} $play_counter ${endColour}${grayColour} jugadas ${endColour}\n"
      echo -e "${yellowColour}[+]${grayColour} A continuaciòn se van a representar las malas jugadas consecutivas que han salido: ${endColour}\n"
      echo -e "${bluewColour} $jugadas_malas ${endColour}\n"

      tput cnorm;exit 0
    fi

    let play_counter+=1
  done

  tput cnorm

}

while getopts "m:t:h" arg; do
  case $arg in
    m)money="$OPTARG";;
    t)technique="$OPTARG";;
    h);;
  esac
done

if [[ $money ]] && [[ $technique ]]; then
  if [[ "$technique" == "martingala" ]]; then
    martingala
  else
    echo -e "\n$redColour[!]${redColour} No existe ninguna tecnica con ese nombre ${endColour}\n"
  fi
else 
  helpPanel
fi
