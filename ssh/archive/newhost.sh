#!/bin/bash
#########################
# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"
clear

#Getting
source /etc/os-release
arfvpn="/etc/arfvpn"
xray="/etc/xray"
ipvps="/var/lib/arfvpn"
github="raw.githubusercontent.com/arfprsty810/vpn/main"
MYISP=$(curl -s ipinfo.io/org/);
MYIP=$(curl -s https://ipinfo.io/ip/);
success="${GREEN}[SUCCESS]${NC}"
clear
apt install curl jq -y
clear
echo ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Add Domain for Server VPN $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " "
echo -e "[ ${green}INFO$NC ]* BLANK INPUT FOR RANDOM SUB-DOMAIN ! "
read -rp "Input ur domain / sub-domain : " -e domain
    if [ -z ${domain} ]; then
    echo -e "
    Nothing input for domain!
    Then a random sub-domain will be created"
    sleep 2
    clear
    wget -q -O /usr/bin/cf "https://${github}/services/cf.sh"
    chmod +x /usr/bin/cf
    sed -i -e 's/\r$//' /usr/bin/cf
    cf
    else
    echo -e "${success} Please wait..."
	echo "${domain}" > ${arfvpn}/domain
	echo "${domain}" > ${arfvpn}/scdomain
    echo "IP=${domain}" > ${ipvps}/ipvps.conf
    echo "none" > ${ipvps}/cfndomain
    ${MYIP} > ${arfvpn}/IP
    ${MYISP} > ${arfvpn}/ISP
    fi
clear

echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu 