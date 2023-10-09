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
YELLOW='\e[32;1m'    # YELLOW
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
   echo -e "${TYBLUE}]${NC}"
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
# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

#########################

# // Exporting URL Host
arfvpn="/etc/arfvpn"
IP=$(cat ${arfvpn}/IP)
ISP=$(cat ${arfvpn}/ISP)
DOMAIN=$(cat ${arfvpn}/domain)
VERSION=$(cat ${arfvpn}/Version)
AUTHER="@arf.prsty_"
Mode="Stable"
export Server_HOST="${DOMAIN}"
export Server_IP="${IP}"
export Server_ISP="${ISP}"
export Script_Version=${VERSION}
export Script_Mode="${Mode}"
export Script_AUTHER="${AUTHER}"

# CHECK STATUS 
xray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

trgo_info="$(systemctl show trojan-go.service --no-page)"
trgo_status=$(echo "${trgo_info}" | grep 'ActiveState=' | cut -f2 -d=)  

ss_info="$(systemctl show shadowsocks-libev.service --no-page)"
ss_obfs=$(echo "${ss_info}" | grep 'ActiveState=' | cut -f2 -d=)  

ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
sshws=$(systemctl status ws-nontls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
sshwstls=$(systemctl status ws-tls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

ovpn_ohq="$(systemctl show openvpn-ohp --no-page)"
status_ohq=$(echo "${ovpn_ohq}" | grep 'ActiveState=' | cut -f2 -d=)  

dropbear_status=$(systemctl status dropbear | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
stunnel5_service=$(systemctl status stunnel5.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
squid_service=$(systemctl status squid | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
fail2ban_service=$(/etc/init.d/fail2ban status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
cron_service=$(/etc/init.d/cron status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vnstat_service=$(/etc/init.d/vnstat status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

# STATUS SERVICE XRAY ( VMESS - VLESS - TROJAN )
if [[ $xray_status == "running" ]]; then 
   status_xray=" ${OK} Running ${CEKLIST}"
else
   status_xray=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE TROJAN GO
if [[ $trgo_status == "active" ]]; then
  status_trojan_go=" ${OK} Running ${CEKLIST}${NC}"
else
  status_trojan_go=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE SHADOWSOCKS OBFS
if [[ $ss_obfs == "active" ]]; then
  status_ss_obfs=" ${OK} Running ${CEKLIST}${NC}"
else
  status_ss_obfs=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE OPENVPN
if [[ $status_ohq == "active" ]]; then
  status_openohp=" ${OK} Running ${CEKLIST}"
else
  status_openohp=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE  SSH 
if [[ $ssh_service == "running" ]]; then 
   status_ssh=" ${OK} Running ${CEKLIST}"
else
   status_ssh=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE  SSH WS
if [[ $sshws == "running" ]]; then 
   status_sshws=" ${OK} Running ${CEKLIST}"
else
   status_sshws=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE  SSH WS/TLS
if [[ $sshwstls == "running" ]]; then 
   status_sshwstls=" ${OK} Running ${CEKLIST}"
else
   status_sshwstls=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE  SQUID 
if [[ $squid_service == "running" ]]; then 
   status_squid=" ${OK} Running ${CEKLIST}"
else
   status_squid=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE  VNSTAT 
if [[ $vnstat_service == "running" ]]; then 
   status_vnstat=" ${OK} Running ${CEKLIST}"
else
   status_vnstat=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE  CRONS 
if [[ $cron_service == "running" ]]; then 
   status_cron=" ${OK} Running ${CEKLIST}"
else
   status_cron=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE  FAIL2BAN 
if [[ $fail2ban_service == "running" ]]; then 
   status_fail2ban=" ${OK} Running ${CEKLIST}"
else
   status_fail2ban=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE DROPBEAR
if [[ $dropbear_status == "running" ]]; then 
   status_beruangjatuh=" ${OK} Running ${CEKLIST}"
else
   status_beruangjatuh=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVICE STUNNEL
if [[ $stunnel5_service == "running" ]]; then 
   status_stunnel5=" ${OK} Running ${CEKLIST}"
else
   status_stunnel5=" ${ERROR}${RED} Not Running${NC} ( Error )${NC}"
fi

# STATUS SERVER
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
 status_nginx="${GREEN}ACTIVE${NC}"
else
 status_nginx="${RED}FAILED${NC}"
fi

tipeprosesor="$(awk -F ': | @' '/model name|Processor|^cpu model|chip type|^cpu type/ {
                        printf $2;
                        exit
                        }' /proc/cpuinfo)"
clear

echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[39;1;92m              ⇱ Sytem Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "  ❇️ \e[32;1m Sever Uptime\e[0m     ${NC}: $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "  ❇️ \e[32;1m Current Time\e[0m     ${NC}: $( date -d "0 days" +"%d-%m-%Y | %X" ) "
echo -e "  ❇️ \e[32;1m Operating System\e[0m ${NC}: $( cat /etc/os-release | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) ) "
echo -e "  ❇️ \e[32;1m Processor\e[0m        ${NC}: $tipeprosesor"
echo -e "  ❇️ \e[32;1m Current Domain\e[0m   ${NC}: ${Server_HOST} "
echo -e "  ❇️ \e[32;1m Server IP\e[0m        ${NC}: ${Server_IP} "
echo -e "  ❇️ \e[32;1m Current Isp Name\e[0m ${NC}: ${Server_ISP} "
echo -e "  ❇️ \e[32;1m Time Reboot VPS\e[0m  ${NC}: 00${NC}:00 ( Jam 12 Mid-Night ) "
echo -e "  ❇️ \e[32;1m Script Auther\e[0m    ${NC}: ${Script_AUTHER} "
echo -e "  ❇️ \e[32;1m Script Version\e[0m   ${NC}: ${Script_Mode}_${Script_Version} "
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[39;1;92m             ⇱ Service Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "❇️ ${LIGHT}FAIL2BAN                ${NC}:$status_fail2ban"
echo -e "❇️ ${LIGHT}CRONS                   ${NC}:$status_cron"
echo -e "❇️ ${LIGHT}VNSTAT                  ${NC}:$status_vnstat"
echo ""
echo -e "  🟢🟡🔴  ${LIGHT}SERVER STATUS     ${NC}:    ${status_nginx}  🔴🟡🟢"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[39;1;92m             ⇱ Tunnel Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "❇️ ${LIGHT}OPENSSH                 ${NC}:$status_ssh"
echo -e "❇️ ${LIGHT}WEBSOCKET TLS           ${NC}:$status_sshwstls"
echo -e "❇️ ${LIGHT}WEBSOCKET NTLS          ${NC}:$status_sshws"
echo -e "❇️ ${LIGHT}OPENVPN                 ${NC}:$status_openohp"
echo -e "❇️ ${LIGHT}STUNNEL5                ${NC}:$status_stunnel5"
echo -e "❇️ ${LIGHT}SQUID                   ${NC}:$status_squid"
echo -e "❇️ ${LIGHT}DROPBEAR                ${NC}:$status_beruangjatuh"
echo -e "❇️ ${LIGHT}XRAY                    ${NC}:$status_xray"
echo -e "❇️ ${LIGHT}TROJAN GO               ${NC}:$status_trojan_go"
echo -e "❇️ ${LIGHT}SHADOWSOCKS OBFS        ${NC}:$status_ss_obfs"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo ""
echo -e "     ${LIGHT}Press ${NC}[ ENTER ]${LIGHT} to ${NC}${YELLOW}Back to Menu${NC}${LIGHT} or ${NC}${RED}CTRL+C${NC}${LIGHT} to exit${NC}"
read -p ""
clear
menu

#########################################################