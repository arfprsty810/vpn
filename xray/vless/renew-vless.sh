#!/bin/bash
#########################################################
# Export Color
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
BINC='\e[0m'

RED='\033[0;31m'      # RED 1
RED2='\e[1;31m'       # RED 2
GREEN='\033[0;32m'   # GREEN 1
GREEN2='\e[1;32m'    # GREEN 2
STABILO='\e[32;1m'    # STABILO
ORANGE='\033[0;33m' # ORANGE
PURPLE='\033[0;35m'  # PURPLE
BLUE='\033[0;34m'     # BLUE 1
TYBLUE='\e[1;36m'     # BLUE 2
CYAN='\033[0;36m'     # CYAN
LIGHT='\033[0;37m'    # LIGHT
NC='\033[0m'           # NC

bl='\e[36;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
color1='\e[031;1m'
color2='\e[34;1m'
green_mix() { echo -e "\\033[32;1m${*}\\033[0m"; }
red_mix() { echo -e "\\033[31;1m${*}\\033[0m"; }

# Export Align
BOLD="\e[1m"
WARNING="${RED}\e[5m"
UNDERLINE="\e[4m"

# Export Banner Status Information
EROR="[${RED} EROR ${NC}]"
INFO="[${LIGHT} INFO ${NC}]"
OK="[${LIGHT} OK ! ${NC}]"
CEKLIST="[${LIGHT}✔${NC}]"
PENDING="[${YELLOW} PENDING ${NC}]"
SEND="[${GREEN} SEND ${NC}]"
RECEIVE="[${YELLOW} RECEIVE ${NC}]"
SUCCESS="[${LIGHT} ✔ SUCCESS ✔ ${NC}]"

#########################################################
source /etc/os-release
cd /root
# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

#########################################################
arfvpn_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
# Start
echo -ne "     ${ORANGE}Processing ${NC}${LIGHT}- [${NC}"
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "${TYBLUE}>${NC}"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "${LIGHT}]${NC}"
   sleep 1s
   tput cuu1
   tput dl1
   # Finish
   echo -ne "           ${ORANGE}Done ${NC}${LIGHT}- [${NC}"
done
echo -e "${LIGHT}] -${NC}${LIGHT} OK !${NC}"
tput cnorm
}

#########################################################
arfvpn="/etc/arfvpn"
github=$(cat ${arfvpn}/github)
xray="/etc/xray"
clear 

    # Client is nothing
    NUMBER_OF_CLIENTS=$(grep -c -E "^#vl# " "${xray}/config.json")
    	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "              ⇱ \e[32;1m✶ Renew Xray Vless Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e ""
    echo -e "  ${RED}•${NC} ${CYAN}You have no existing Vless clients! ${NC}"
    echo -e ""
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e ""
    sleep 3
    clear
    menu-vless
    	else
	clear
	
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "              ⇱ \e[32;1m✶ Renew Xray Vless Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e ""
    echo -e "${NC}${CYAN}User       Expired ${NC}"
    echo -e "${NC}${CYAN}──────────────────── $NC"
	grep -E "^#vl# " "${xray}/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
    echo -e "${NC}${CYAN}──────────────────── $NC"
    echo -e " "
    read -rp "Input Username : " user
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
        fi
        
    # Username not found
	USERNAME_DOES_NOT_EXIST=$(grep -w ${user} ${xray}/config.json | wc -l)
		if [[ ${USERNAME_DOES_NOT_EXIST} == '0' ]]; then
	clear
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "              ⇱ \e[32;1m✶ Renew Xray Vless Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e ""
    echo -e "${NC}${CYAN}Username does not exist ! ${NC}"
    echo -e ""
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    sleep 3
    clear
    menu-vless
	    else
	clear

    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "              ⇱ \e[32;1m✶ Renew Xray Vless Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e ""
    echo -e "${NC}${CYAN}User: ${user} $NC"
    read -p "Expired (days): " masaaktif
    echo -e " "
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e " "
        fi
            
    clear
    exp=$(grep -wE "^#vl# ${user}" "${xray}/config.json" | cut -d ' ' -f 3 | sort | uniq)
    now=$(date +%Y-%m-%d)
    d1=$(date -d "${exp}" +%s)
    d2=$(date -d "${now}" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$((${exp2} + ${masaaktif}))
    exp4=`date -d "${exp3} days" +"%Y-%m-%d"`
    renewvl () {
    sed -i "/#vl# ${user}/c\#vl# ${user} ${exp4}" ${xray}/config.json
    }
    echo -e " ${LIGHT}- ${NC}Renew User Vless Websocket"
    arfvpn_bar 'renewvl'
    # systemctl restart xray > /dev/null 2>&1
    history-c
    clear
    
    echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
    echo -e "               ⇱ \e[32;1m✶ Renew Xray Vless Account ✶\e[0m ⇲ ${NC}"
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo -e ""
    echo -e "${NC}${CYAN}Renew Client Successfully !!!$NC"
    echo -e "${NC}${CYAN}Client Name : ${user} $NC"
    echo -e "${NC}${CYAN}Expired On  : ${exp4} $NC"
    echo -e ""
    echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${BIYellow}Back to Vless Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
    read -p ""
    history -c
    clear
    menu-vless