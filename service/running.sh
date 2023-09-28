#!/bin/bash
red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
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
NC='\e[0m'

# COLOR VALIDATION
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
yl='\e[32;1m'
bl='\e[36;1m'
gl='\e[32;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
bd='\e[1m'
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

#########################
# VPS INFORMATION
arfvpn="/etc/arfvpn"
IP=$(cat ${arfvpn}/IP)
ISP=$(cat ${arfvpn}/ISP)
DOMAIN=$(cat ${arfvpn}/domain)
clear

# CHECK STATUS 
# XRAY VMESS - VLESS - TROJAN
xray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
clear

# TROJAN-GO
trgo_info="$(systemctl show trojan-go.service --no-page)"
trgo_status=$(echo "${trgo_info}" | grep 'ActiveState=' | cut -f2 -d=)  
#trojango=$(systemctl status trojan-go.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
clear

# TROJAN-GFW
#trojangfw_server=$(systemctl status trojan | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#clear

# SHADOWSHOCK-R
#ssr_status=$(systemctl status ssrmu | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#clear

# SHADOWSHOCK
ss_info="$(systemctl show shadowsocks-libev.service --no-page)"
ss_obfs=$(echo "${ss_info}" | grep 'ActiveState=' | cut -f2 -d=)  
#ss_status=$(systemctl status shadowsocks-libev.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status_ss_tls="$(systemctl show shadowsocks-libev-server@tls.service --no-page)"
#ss_tls=$(echo "${status_ss_tls}" | grep 'ActiveState=' | cut -f2 -d=)
#status_ss_http="$(systemctl show shadowsocks-libev-server@http.service --no-page)"
#ss_http=$(echo "${status_ss_http}" | grep 'ActiveState=' | cut -f2 -d=)
#sst_status=$(systemctl status shadowsocks-libev-server@tls | grep Active | awk '{print $0}' | cut -d "(" -f2 | cut -d ")" -f1) 
#sssohtt=$(systemctl status shadowsocks-libev-server@*-http | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ssh_status=$(systemctl status shadowsocks-libev-server@http | grep Active | awk '{print $0}' | cut -d "(" -f2 | cut -d ")" -f1) 
clear

# SSH
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
sshws=$(systemctl status ws-nontls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
sshwstls=$(systemctl status ws-tls | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohr=$(systemctl status ssh-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
clear

# OPENVPN
#ovpn_info="$(systemctl show openvpn --no-page)"
#ovpn_status=$(echo "${ovpn_info}" | grep 'ActiveState=' | cut -f2 -d=)  
#status_openvp=$(/etc/init.d/openvpn status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ovpnws=$(systemctl status edu-proxyovpn.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ovpnws_info="$(systemctl show edu-proxyovpn.service --no-page)"
#ovpnws_status=$(echo "${ovpnws_info}" | grep 'ActiveState=' | cut -f2 -d=)  
#status_openvp=$(/etc/init.d/openvpn status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ohq=$(systemctl status openvpn-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
clear

# DROPBEAR
dropbear_status=$(systemctl status dropbear | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#dober_service="$(systemctl show /etc/init.d/dropbear.service --no-page)"
#dober=$(echo "${dober_service}" | grep 'ActiveState=' | cut -f2 -d=)  
#wsdrop=$(systemctl status ws-dropbear.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohp=$(systemctl status dropbear-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
clear

# STUNNEL
#wstls=$(systemctl status ws-stunnel.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#stunnel_service=$(/etc/init.d/stunnel5 status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
stunnel5_service=$(systemctl status stunnel5.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#stunnel5_info="$(systemctl show stunnel5.service --no-page)"
#stunnel5=$(echo "${stunnel5_info}" | grep 'ActiveState=' | cut -f2 -d=)  
clear

# SQUID
squid_service=$(systemctl status squid | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
clear

# FAIL2BAN
fail2ban_service=$(/etc/init.d/fail2ban status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
clear

# CRON
cron_service=$(/etc/init.d/cron status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
clear

# VNSTAT
vnstat_service=$(/etc/init.d/vnstat status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
clear

#sstp_service=$(systemctl status accel-ppp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wg="$(systemctl show wg-quick@wg0.service --no-page)"
#swg=$(echo "${wg}" | grep 'ActiveState=' | cut -f2 -d=)
#sswg=$(systemctl status wg-quick@wg0 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#osslh=$(systemctl status sslh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
clear

# STATUS SERVICE XRAY ( VMESS - VLESS - TROJAN )
if [[ $xray_status == "running" ]]; then 
   status_xray=" ${GREEN}Running${NC} ( No Error )"
else
   status_xray="${RED}  Not Running${NC}   ( Error )"
fi
clear

# STATUS SERVICE TROJAN GO
if [[ $trgo_status == "active" ]]; then
  status_trojan_go=" ${GREEN}Running ${NC}( No Error )${NC}"
else
  status_trojan_go="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
clear

# STATUS SERVICE TROJAN GFW
#if [[ $trojangfw_server == "running" ]]; then 
#   status_virus_trojangfw=" ${GREEN}Running ${NC}( No Error )${NC}"
#else
   status_virus_trojangfw="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi
#clear

# STATUS SERVICE SHADOWSOCKS OBFS
if [[ $ss_obfs == "active" ]]; then
  status_ss_obfs=" ${GREEN}Running ${NC}( No Error )${NC}"
else
  status_ss_obfs="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
clear

# STATUS SERVICE OPENVPN
if [[ $ohq == "active" ]]; then
  status_openohp=" ${GREEN}Running ${NC}( No Error )"
else
  status_openohp="${RED}  Not Running ${NC}  ( Error )"
fi
clear

# STATUS SERVICE  SSH 
if [[ $ssh_service == "running" ]]; then 
   status_ssh=" ${GREEN}Running ${NC}( No Error )"
else
   status_ssh="${RED}  Not Running ${NC}  ( Error )"
fi
clear

# STATUS SERVICE  SSH WS
if [[ $sshws == "running" ]]; then 
   status_sshws=" ${GREEN}Running ${NC}( No Error )"
else
   status_sshws="${RED}  Not Running ${NC}  ( Error )"
fi
clear

# STATUS SERVICE  SSH WS/TLS
if [[ $sshwstls == "running" ]]; then 
   status_sshwstls=" ${GREEN}Running ${NC}( No Error )"
else
   status_sshwstls="${RED}  Not Running ${NC}  ( Error )"
fi
clear

# STATUS SERVICE  SQUID 
if [[ $squid_service == "running" ]]; then 
   status_squid=" ${GREEN}Running ${NC}( No Error )"
else
   status_squid="${RED}  Not Running ${NC}  ( Error )"
fi
clear

# STATUS SERVICE  VNSTAT 
if [[ $vnstat_service == "running" ]]; then 
   status_vnstat=" ${GREEN}Running ${NC}( No Error )"
else
   status_vnstat="${RED}  Not Running ${NC}  ( Error )"
fi
clear

# STATUS SERVICE  CRONS 
if [[ $cron_service == "running" ]]; then 
   status_cron=" ${GREEN}Running ${NC}( No Error )"
else
   status_cron="${RED}  Not Running ${NC}  ( Error )"
fi
clear

# STATUS SERVICE  FAIL2BAN 
if [[ $fail2ban_service == "running" ]]; then 
   status_fail2ban=" ${GREEN}Running ${NC}( No Error )"
else
   status_fail2ban="${RED}  Not Running ${NC}  ( Error )"
fi
clear

# STATUS SERVICE DROPBEAR
if [[ $dropbear_status == "running" ]]; then 
   status_beruangjatuh=" ${GREEN}Running${NC} ( No Error )${NC}"
else
   status_beruangjatuh="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
clear

# STATUS SERVICE STUNNEL
if [[ $stunnel5_service == "running" ]]; then 
   status_stunnel5=" ${GREEN}Running ${NC}( No Error )"
else
   status_stunnel5="${RED}  Not Running ${NC}  ( Error )"
fi
clear

# STATUS SERVICE WEBSOCKET TLS
#if [[ $wstls == "running" ]]; then 
#   swstls=" ${GREEN}Running ${NC}( No Error )${NC}"
#else
#   swstls="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi
#clear

# STATUS SERVICE WEBSOCKET DROPBEAR
#if [[ $wsdrop == "running" ]]; then 
#   swsdrop=" ${GREEN}Running ${NC}( No Error )${NC}"
#else
#   swsdrop="${RED}  Not Running ${NC}  ( Error )${NC}"
#fi
#clear

nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
 status_nginx="${GREEN}ACTIVE${NC}"
else
 status_nginx="${RED}FAILED${NC}"
fi
clear

# TOTAL RAM
#total_ram=` grep "MemTotal: " /proc/meminfo | awk '{ print $2}'`
#totalram=$(($total_ram/1024))

# TIPE PROCESSOR
#totalcore="$(grep -c "^processor" /proc/cpuinfo)" 
#totalcore+=" Core"
#corediilik="$(grep -c "^processor" /proc/cpuinfo)" 
tipeprosesor="$(awk -F ': | @' '/model name|Processor|^cpu model|chip type|^cpu type/ {
                        printf $2;
                        exit
                        }' /proc/cpuinfo)"

# GETTING CPU INFORMATION
#cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
#cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
#cpu_usage+=" %"

# OS UPTIME
#uptime="$(uptime -p | cut -d " " -f 2-10)"

# KERNEL TERBARU
#kernelku=$(uname -r)

# WAKTU SEKARANG 
#harini=`date -d "0 days" +"%d-%m-%Y"`
#jam=`date -d "0 days" +"%X"`

# DNS PATCH
#tipeos2=$(uname -m)
#Name=$(curl -sS https://raw.githubusercontent.com/Fahmiiiiiiii/anjim/main/anjay/allow | grep ${IP} | awk '{print $2}')
#Exp=$(curl -sS https://raw.githubusercontent.com/Fahmiiiiiiii/anjim/main/anjay/allow | grep ${IP} | awk '{print $3}')
# GETTING DOMAIN NAME

echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[39;1;92m              ⇱ Sytem Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "  ❇️ \e[32;1m Sever Uptime\e[0m     : $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "  ❇️ \e[32;1m Current Time\e[0m     : $( date -d "0 days" +"%d-%m-%Y | %X" ) "
echo -e "  ❇️ \e[32;1m Operating System\e[0m : $( cat /etc/os-release | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) ) "
echo -e "  ❇️ \e[32;1m Processor\e[0m        : $tipeprosesor"
echo -e "  ❇️ \e[32;1m Current Isp Name\e[0m : ${ISP} "
echo -e "  ❇️ \e[32;1m Server IP\e[0m        : ${IP} "
echo -e "  ❇️ \e[32;1m Current Domain\e[0m   : ${DOMAIN} "
echo -e "  ❇️ \e[32;1m Time Reboot VPS\e[0m  : 00:00 ( Jam 12 Malam ) "
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[39;1;92m             ⇱ Service Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "❇️ FAIL2BAN                :$status_fail2ban"
echo -e "❇️ CRONS                   :$status_cron"
echo -e "❇️ VNSTAT                  :$status_vnstat"
echo ""
echo -e "  🟢🟡🔴  SERVER STATUS     :    ${status_nginx}  🔴🟡🟢"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[39;1;92m             ⇱ Tunnel Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "❇️ OPENSSH                 :$status_ssh"
echo -e "❇️ WEBSOCKET TLS           :$status_sshwstls"
echo -e "❇️ WEBSOCKET NTLS          :$status_sshws"
echo -e "❇️ OPENVPN                 :$status_openohp"
echo -e "❇️ STUNNEL5                :$status_stunnel5"
echo -e "❇️ SQUID                   :$status_squid"
echo -e "❇️ DROPBEAR                :$status_beruangjatuh"
echo -e "❇️ XRAY                    :$status_xray"
echo -e "❇️ TROJAN GO               :$status_trojan_go"
echo -e "❇️ SHADOWSOCKS OBFS        :$status_ss_obfs"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"

menu
