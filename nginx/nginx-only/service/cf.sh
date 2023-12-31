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
ipvps="/var/lib/arfvpn"
SUB=$(</dev/urandom tr -dc a-z0-9 | head -c4)
IP=$(cat ${arfvpn}/IP);
DOMAIN=d-jumper.me
SUB_DOMAIN=${SUB}.arfvpn.${DOMAIN}
CF_ID=arief.prsty@gmail.com
CF_KEY=3a3ac5ccc9e764de9129fbbb177c161b9dfbd
clear

#########################################################
# Generating Sub-Domain
set_cf () {
set -euo pipefail
mkdir -p ${arfvpn}/
mkdir -p ${ipvps}/
touch ${arfvpn}/domain
touch ${arfvpn}/scdomain
touch ${ipvps}/ipvps.conf
echo -e "${SUB_DOMAIN}" > ${arfvpn}/domain
echo -e "${SUB_DOMAIN}" > ${arfvpn}/scdomain
echo -e "IP=${SUB_DOMAIN}" > ${ipvps}/ipvps.conf
}
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "    GENEREATE RANDOM SUB-DOMAIN"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e " ${LIGHT}- ${NC}Generating Random Sub-Domain"
arfvpn_bar 'set_cf'
echo -e ""

#########################################################
# Updating DNS SUB-DOMAIN
set_dns () {
sleep 2
}
echo -e " ${LIGHT}- ${NC}Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
arfvpn_bar 'set_dns'

#########################################################
# Updating DNS WILD-DOMAIN
#WILD_DOMAIN="*.$SUB"
#set -euo pipefail
#echo -e ""
#echo -e "Updating DNS for ${WILD_DOMAIN}..."

#ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
#     -H "X-Auth-Email: ${CF_ID}" \
#     -H "X-Auth-Key: ${CF_KEY}" \
#     -H "Content-Type: application/json" | jq -r .result[0].id)

#RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${WILD_DOMAIN}" \
#     -H "X-Auth-Email: ${CF_ID}" \
#     -H "X-Auth-Key: ${CF_KEY}" \
#     -H "Content-Type: application/json" | jq -r .result[0].id)

#if [[ "${#RECORD}" -le 10 ]]; then
#     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
#     -H "X-Auth-Email: ${CF_ID}" \
#     -H "X-Auth-Key: ${CF_KEY}" \
#     -H "Content-Type: application/json" \
#     --data '{"type":"A","name":"'${WILD_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
#fi

#RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
#     -H "X-Auth-Email: ${CF_ID}" \
#     -H "X-Auth-Key: ${CF_KEY}" \
#     -H "Content-Type: application/json" \
#     --data '{"type":"A","name":"'${WILD_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')

#########################################################
# Finish
echo -e ""
echo -e " ${INFO} Your SUB-DOMAIN has been Generated : ${SUB_DOMAIN}"
echo -e ""
echo -e " ${OK} Successfully Generated SUB-DOMAIN ${CEKLIST}"
echo -e ""
sleep 5
clear
