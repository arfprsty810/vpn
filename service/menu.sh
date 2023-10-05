#!/bin/bash
#########################

# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

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

# / letssgoooo

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting IP Address,Domain&ISP
arfvpn="/etc/arfvpn"
IP=$(cat ${arfvpn}/IP)
ISP=$(cat ${arfvpn}/ISP)
DOMAIN=$(cat ${arfvpn}/domain)

# // Exporting URL Host
export Server_URL="${DOMAIN}"
export Server_Port="8443"
export Server_IP="${IP}"
export Script_Mode="Stable"
export Auther="@arf.prsty_"

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ ${nginx} == "running" ]]; then
 status_nginx="${GREEN}ACTIVE${NC}"
else
 status_nginx="${RED}FAILED${NC}"
fi
clear

echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ \e[32;1mInformasi VPS\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e "  ❇️ \e[32;1m Sever Uptime\e[0m     : $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "  ❇️ \e[32;1m Current Time\e[0m     : $( date -d "0 days" +"%d-%m-%Y | %X" ) "
echo -e "  ❇️ \e[32;1m Operating System\e[0m : $( cat /etc/os-release | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) ) "
echo -e "  ❇️ \e[32;1m Current Domain\e[0m   : ${DOMAIN} "
echo -e "  ❇️ \e[32;1m Current Isp Name\e[0m : ${ISP} "
echo -e "  ❇️ \e[32;1m Server IP\e[0m        : ${IP} "
echo -e "  ❇️ \e[32;1m Time Reboot VPS\e[0m  : 00:00 ( Jam 12 Malam ) "
echo -e ""
echo -e "      🟢🟡🔴  SERVER STATUS     :    ${status_nginx}  🔴🟡🟢"
echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ \e[32;1mTunnel/s Menu\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e "    ${BICyan}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}SSH/OVPN     $NC  ${BICyan}[${BIWhite}04${BICyan}]${RED} • ${NC}${CYAN}TROJAN-WS/GO $NC"

echo -e "    ${BICyan}[${BIWhite}02${BICyan}]${RED} •${NC} ${CYAN}XRAY - VMESS $NC  ${BICyan}[${BIWhite}05${BICyan}]${RED} • ${NC}${CYAN}SHADOWSOCK-OBFS$NC"

echo -e "    ${BICyan}[${BIWhite}03${BICyan}]${RED} •${NC} ${CYAN}XRAY - VLESS $NC"

echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                   ⇱ \e[32;1mMenu Service/s\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

echo -e "    ${BICyan}[${BIWhite}06${BICyan}]${RED} •${NC} ${CYAN}SETTING/s    $NC  ${BICyan}[${BIWhite}10${BICyan}]${RED} • ${NC}${CYAN}CEK BANDWIDTH $NC"

echo -e "    ${BICyan}[${BIWhite}07${BICyan}]${RED} •${NC} ${CYAN}UPDATE-XRAY  $NC  ${BICyan}[${BIWhite}11${BICyan}]${RED} • ${NC}${CYAN}CEK RUNNING SERVICE $NC"

echo -e "    ${BICyan}[${BIWhite}08${BICyan}]${RED} •${NC} ${CYAN}UPDATE-SCRIPT$NC  ${BICyan}[${BIWhite}12${BICyan}]${RED} • ${NC}${CYAN}RESTART SERVICE$NC"

echo -e "    ${BICyan}[${BIWhite}09${BICyan}]${RED} •${NC} ${CYAN}BACKUP       $NC  ${BICyan}[${BIWhite}13${BICyan}]${RED} • ${NC}${CYAN}INSTALL-WEBMIN$NC"

echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                       ⇱ \e[32;1mAbout\e[0m ⇲ "
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"

echo -e "    ${BICyan}[${BIWhite}14${BICyan}]${RED} •${NC} ${CYAN}INFO-SCRIPT  $NC  ${BICyan}[${BIWhite}xx${BICyan}]${RED} • ${NC}${CYAN}CLOSE MENU   $NC"

echo -e "    ${BICyan}[${BIWhite}15${BICyan}]${RED} •${NC} ${CYAN}REBOOT VPS   $NC"

echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e ""

read -p "                    Select Menu : " menu
case $menu in

1)
clear
menu-ssh
;;

2)
clear
menu-vmess
;;

3)
clear
menu-vless
;;

4)
clear
menu-trojan
;;

5)
clear
menu-ss
;;

6)
clear
menu-setting
;;

7)
clear
update-xray
;;

8)
clear
update
;;

9)
clear
menu-backup
;;

10)
clear
cek-bandwidth
;;

11)
clear
running
;;

12)
clear
restart
;;

13)
clear
wbmn
;;

14)
clear
cat /etc/arfvpn/log-install.txt
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
;;

15)
reboot
exit
;;

x)
clear
neofetch
exit
;;

*)
clear
echo " Command not found! "
sleep 3
menu
;;

esac
