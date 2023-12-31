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
clear

#########################################################
echo -e ""
echo -e "\033[0;34m┌─────────────────────────────────────────────────────┐${NC}"
echo -e "                ⇱ \e[32;1m✶ Update Script VPS ✶\e[0m ⇲"
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo -e " "

remove_script () {
rm -rvf /usr/bin/cek-bandwidth
rm -rvf /etc/arfvpn/cron-vpn
rm -rvf /usr/bin/cert
rm -rvf /usr/bin/cf
#rm -rvf /usr/bin/cfnhost
rm -rvf /usr/bin/hostvps
rm -rvf /usr/bin/limitspeed
rm -rvf /usr/bin/menu
#rm -rvf /usr/bin/menu-backup
rm -rvf /usr/bin/menu-setting
rm -rvf /usr/bin/fixssh
rm -rvf /usr/bin/renew-domain
rm -rvf /usr/bin/restart
rm -rvf /usr/bin/running
rm -rvf /usr/bin/update
rm -rvf /usr/bin/update-xray
rm -rvf /etc/arfvpn/Version
rm -rvf /usr/bin/wbmn
rm -rvf /usr/bin/xp

rm -rvf /usr/bin/addssh
rm -rvf /usr/bin/autokill
rm -rvf /usr/bin/ceklim
rm -rvf /usr/bin/cekssh
rm -rvf /usr/bin/delssh
rm -rvf /usr/bin/member
rm -rvf /usr/bin/menu-ssh
rm -rvf /usr/bin/renewssh
rm -rvf /usr/bin/tendang
rm -rvf /usr/bin/trialssh

#rm -rvf bbr.sh && ./bbr.sh
rm -rvf /usr/bin/clearlog
rm -rvf /etc/issue.net
rm -rvf /home/arfvps/public_html/index.html
#rm -rvf /etc/pam.d/common-password
rm -rvf /usr/bin/ram
#rm -rvf /etc/set.sh
#rm -rvf /etc/squid/squid.conf
rm -rvf /usr/bin/swapkvm
#rm -rvf /usr/bin/sshws

rm -rvf /usr/bin/changeport
rm -rvf /usr/bin/portovpn
rm -rvf /usr/bin/portsquid
rm -rvf /usr/bin/porttrojango
rm -rvf /usr/bin/portxrayws
rm -rvf /usr/bin/portsshws
#rm -rvf /usr/bin/portsstp
#rm -rvf /usr/bin/portwg

rm -rvf /usr/bin/menu-vmess
rm -rvf /usr/bin/add-vm
rm -rvf /usr/bin/cek-vm
rm -rvf /usr/bin/del-vm
rm -rvf /usr/bin/renew-vm

rm -rvf /usr/bin/menu-vless
rm -rvf /usr/bin/add-vless
rm -rvf /usr/bin/cek-vless
rm -rvf /usr/bin/del-vless
rm -rvf /usr/bin/renew-vless

rm -rvf /usr/bin/menu-trojan
rm -rvf /usr/bin/add-tr
rm -rvf /usr/bin/cek-tr
rm -rvf /usr/bin/del-tr
rm -rvf /usr/bin/renew-tr

rm -rvf /bin/add-trgo
rm -rvf /bin/cek-trgo
rm -rvf /bin/del-trgo
rm -rvf /bin/renew-trgo

rm -rvf /usr/bin/menu-ss
rm -rvf /usr/bin/addss
rm -rvf /usr/bin/cekss
rm -rvf /usr/bin/delss
rm -rvf /usr/bin/renewss
}
echo -e " ${LIGHT}- ${NC}Removing Old Script"
arfvpn_bar 'remove_script'
echo -e ""
sleep 2

#########################################################
update_script () {
wget -O /usr/bin/cek-bandwidth "https://${github}/service/cek-bandwidth.sh" && chmod +x /usr/bin/cek-bandwidth
wget -O /etc/arfvpn/cron-vpn "https://${github}/service/cron-vpn" && chmod +x /etc/arfvpn/cron-vpn
wget -O /usr/bin/cert "https://${github}/cert/cert.sh" && chmod +x /usr/bin/cert
wget -O /usr/bin/cf "https://${github}/service/cf.sh" && chmod +x /usr/bin/cf
#wget -O /usr/bin/cfnhost "https://${github}/service/cfnhost.sh" && chmod +x /usr/bin/cfnhost
wget -O /usr/bin/hostvps "https://${github}/service/hostvps.sh" && chmod +x /usr/bin/hostvps
wget -O /usr/bin/limitspeed "https://${github}/service/limitspeed.sh" && chmod +x /usr/bin/limitspeed
wget -O /usr/bin/menu "https://${github}/service/menu.sh" && chmod +x /usr/bin/menu
#wget -O /usr/bin/menu-backup "https://${github}/service/menu-backup.sh" && chmod +x /usr/bin/menu-backup
wget -O /usr/bin/menu-setting "https://${github}/service/menu-setting.sh" && chmod +x /usr/bin/menu-setting
wget -O /usr/bin/fixssh "https://${github}/service/rc.local.sh" && chmod +x /usr/bin/fixssh
wget -O /usr/bin/renew-domain "https://${github}/service/renew-domain.sh" && chmod +x /usr/bin/renew-domain
wget -O /usr/bin/restart "https://${github}/service/restart.sh" && chmod +x /usr/bin/restart
wget -O /usr/bin/running "https://${github}/service/running.sh" && chmod +x /usr/bin/running
wget -O /usr/bin/speedtest "https://${github}/service/speedtest_cli.py" && chmod +x /usr/bin/speedtest
wget -O /usr/bin/update "https://${github}/service/update.sh" && chmod +x /usr/bin/update
wget -O /usr/bin/update-xray "https://${github}/service/update-xray.sh" && chmod +x /usr/bin/update-xray
wget -O /etc/arfvpn/Version "https://${github}/service/Version"
wget -O /usr/bin/wbmn "https://${github}/service/webmin.sh" && chmod +x /usr/bin/wbmn
wget -O /usr/bin/xp "https://${github}/service/xp.sh" && chmod +x /usr/bin/xp
sed -i -e 's/\r$//' /usr/bin/cek-bandwidth
sed -i -e 's/\r$//' /etc/arfvpn/cron-vpn
sed -i -e 's/\r$//' /usr/bin/cert
sed -i -e 's/\r$//' /usr/bin/cf
#sed -i -e 's/\r$//' /usr/bin/cfnhost
sed -i -e 's/\r$//' /usr/bin/hostvps
sed -i -e 's/\r$//' /usr/bin/limitspeed
sed -i -e 's/\r$//' /usr/bin/menu
#sed -i -e 's/\r$//' /usr/bin/menu-backup
sed -i -e 's/\r$//' /usr/bin/menu-setting
sed -i -e 's/\r$//' /usr/bin/fixssh
sed -i -e 's/\r$//' /usr/bin/renew-domain
sed -i -e 's/\r$//' /usr/bin/restart
sed -i -e 's/\r$//' /usr/bin/running
sed -i -e 's/\r$//' /usr/bin/update
sed -i -e 's/\r$//' /usr/bin/update-xray
sed -i -e 's/\r$//' /usr/bin/wbmn
sed -i -e 's/\r$//' /usr/bin/xp

wget -O /usr/bin/addssh "https://${github}/ssh/addssh.sh"
wget -O /usr/bin/autokill "https://${github}/ssh/autokill.sh"
wget -O /usr/bin/ceklim "https://${github}/ssh/ceklim.sh"
wget -O /usr/bin/cekssh "https://${github}/ssh/cekssh.sh"
wget -O /usr/bin/delssh "https://${github}/ssh/delssh.sh"
wget -O /usr/bin/member "https://${github}/ssh/member.sh"
wget -O /usr/bin/menu-ssh "https://${github}/ssh/menu-ssh.sh"
wget -O /usr/bin/renewssh "https://${github}/ssh/renewssh.sh"
wget -O /usr/bin/tendang "https://${github}/ssh/tendang.sh"
wget -O /usr/bin/trialssh "https://${github}/ssh/trialssh.sh"
chmod +x /usr/bin/addssh
chmod +x /usr/bin/autokill
chmod +x /usr/bin/ceklim
chmod +x /usr/bin/cekssh
chmod +x /usr/bin/delssh
chmod +x /usr/bin/member
chmod +x /usr/bin/menu-ssh
chmod +x /usr/bin/renewssh
chmod +x /usr/bin/tendang
chmod +x /usr/bin/trialssh
sed -i -e 's/\r$//' /usr/bin/addssh
sed -i -e 's/\r$//' /usr/bin/autokill
sed -i -e 's/\r$//' /usr/bin/ceklim
sed -i -e 's/\r$//' /usr/bin/cekssh
sed -i -e 's/\r$//' /usr/bin/delssh
sed -i -e 's/\r$//' /usr/bin/member
sed -i -e 's/\r$//' /usr/bin/menu-ssh
sed -i -e 's/\r$//' /usr/bin/renewssh
sed -i -e 's/\r$//' /usr/bin/tendang
sed -i -e 's/\r$//' /usr/bin/trialssh
sed -i -e 's/\r$//' /usr/bin/expssh

#wget -O /usr/bin/badvpn-udpgw64 "https://${github}/ssh/archive/newudpgw"
#wget -O /usr/bin/bbr "https://${github}/ssh/archive/bbr.sh"
wget -O /usr/bin/clearlog "https://${github}/ssh/archive/clearlog.sh"
wget -O /etc/issue.net "https://${github}/ssh/archive/issue.net"
wget -O /home/arfvps/public_html/index.html "https://${github}/nginx/index.html"
#wget -O /etc/pam.d/common-password "https://${github}/ssh/archive/password"
wget -O /usr/bin/ram "https://${github}/ssh/archive/ram.sh"
#wget -O /etc/set.sh "https://${github}/ssh/archive/set.sh"
#wget -O /etc/squid/squid.conf "https://${github}/ssh/archive/squid3.conf"
wget -O /usr/bin/swapkvm "https://${github}/ssh/archive/swapkvm.sh"
#wget -O /usr/bin/sshws "https://${github}/ssh/websocket/sshws.sh"
#chmod +x /usr/bin/badvpn-udpgw64
#chmod +x bbr.sh && ./bbr.sh
chmod +x /usr/bin/clearlog
chmod +x /etc/issue.net
chown -R www-data:www-data /home/arfvps/public_html
chmod -R g+rw /home/arfvps/public_html
chmod +x /home/
chmod +x /home/arfvps/  
chmod +x /home/arfvps/public_html/
#chmod +x /etc/pam.d/common-password
chmod +x /usr/bin/ram
#chmod +x /etc/set.sh
#chmod +x /etc/squid/squid.conf
chmod +x /usr/bin/swapkvm
#chmod +x /usr/bin/sshws
#sed -i -e 's/\r$//' bbr.sh && ./bbr.sh
sed -i -e 's/\r$//' /usr/bin/clearlog
sed -i -e 's/\r$//' /usr/bin/issue.net
#sed -i -e 's/\r$//' /etc/pam.d/common-password
sed -i -e 's/\r$//' /usr/bin/ram
#sed -i -e 's/\r$//' /etc/set.sh
#sed -i -e 's/\r$//' /etc/squid/squid.conf
sed -i -e 's/\r$//' /usr/bin/swapkvm
#sed -i -e 's/\r$//' /usr/bin/sshws

#wget -O stunnel5.zip "https://${github}/ssh/stunnel5/stunnel5.zip"
#wget -O /etc/init.d/stunnel5 "https://${github}/ssh/archive/stunnel5.init"
#chmod +x /etc/init.d/stunnel5

wget -O /usr/bin/changeport "https://${github}/service/port/changeport.sh"
wget -O /usr/bin/portovpn "https://${github}/service/port/portovpn.sh"
wget -O /usr/bin/portsshws "https://${github}/service/port/portsshws.sh"
wget -O /usr/bin/portsquid "https://${github}/service/port/portsquid.sh"
wget -O /usr/bin/porttrojango "https://${github}/service/port/porttrojango.sh"
wget -O /usr/bin/portxrayws "https://${github}/service/port/portxrayws.sh"
#wget -O /usr/bin/portsstp "https://${github}/service/port/portsstp.sh"
#wget -O /usr/bin/portwg "https://${github}/service/port/portwg.sh
chmod +x /usr/bin/changeport
chmod +x /usr/bin/portovpn
chmod +x /usr/bin/portsshws
chmod +x /usr/bin/portsquid
chmod +x /usr/bin/porttrojango
chmod +x /usr/bin/portxrayws
#chmod +x /usr/bin/portsstp
#chmod +x /usr/bin/portwg
sed -i -e 's/\r$//' /usr/bin/changeport
sed -i -e 's/\r$//' /usr/bin/portovpn
sed -i -e 's/\r$//' /usr/bin/portsshws
sed -i -e 's/\r$//' /usr/bin/portsquid
sed -i -e 's/\r$//' /usr/bin/porttrojango
sed -i -e 's/\r$//' /usr/bin/portxrayws
#sed -i -e 's/\r$//' /usr/bin/portsstp
#sed -i -e 's/\r$//' /usr/bin/portwg

#vmess
wget -q -O /usr/bin/menu-vmess "https://${github}/xray/vmess/menu-vmess.sh" && chmod +x /usr/bin/menu-vmess
wget -q -O /usr/bin/add-vm "https://${github}/xray/vmess/add-vm.sh" && chmod +x /usr/bin/add-vm
wget -q -O /usr/bin/cek-vm "https://${github}/xray/vmess/cek-vm.sh" && chmod +x /usr/bin/cek-vm
wget -q -O /usr/bin/del-vm "https://${github}/xray/vmess/del-vm.sh" && chmod +x /usr/bin/del-vm
wget -q -O /usr/bin/renew-vm "https://${github}/xray/vmess/renew-vm.sh" && chmod +x /usr/bin/renew-vm

#vless
wget -q -O /usr/bin/menu-vless "https://${github}/xray/vless/menu-vless.sh" && chmod +x /usr/bin/menu-vless
wget -q -O /usr/bin/add-vless "https://${github}/xray/vless/add-vless.sh" && chmod +x /usr/bin/add-vless
wget -q -O /usr/bin/cek-vless "https://${github}/xray/vless/cek-vless.sh" && chmod +x /usr/bin/cek-vless
wget -q -O /usr/bin/del-vless "https://${github}/xray/vless/del-vless.sh" && chmod +x /usr/bin/del-vless
wget -q -O /usr/bin/renew-vless "https://${github}/xray/vless/renew-vless.sh" && chmod +x /usr/bin/renew-vless

#trojan
wget -q -O /usr/bin/menu-trojan "https://${github}/xray/trojan/menu-trojan.sh" && chmod +x /usr/bin/menu-trojan
wget -q -O /usr/bin/add-tr "https://${github}/xray/trojan/add-tr.sh" && chmod +x /usr/bin/add-tr
wget -q -O /usr/bin/cek-tr "https://${github}/xray/trojan/cek-tr.sh" && chmod +x /usr/bin/cek-tr
wget -q -O /usr/bin/del-tr "https://${github}/xray/trojan/del-tr.sh" && chmod +x /usr/bin/del-tr
wget -q -O /usr/bin/renew-tr "https://${github}/xray/trojan/renew-tr.sh" && chmod +x /usr/bin/renew-tr

sed -i -e 's/\r$//' /usr/bin/menu-vmess
sed -i -e 's/\r$//' /usr/bin/add-vm
sed -i -e 's/\r$//' /usr/bin/cek-vm
sed -i -e 's/\r$//' /usr/bin/del-vm
sed -i -e 's/\r$//' /usr/bin/renew-vm

sed -i -e 's/\r$//' /usr/bin/menu-vless
sed -i -e 's/\r$//' /usr/bin/add-vless
sed -i -e 's/\r$//' /usr/bin/cek-vless
sed -i -e 's/\r$//' /usr/bin/del-vless
sed -i -e 's/\r$//' /usr/bin/renew-vless

sed -i -e 's/\r$//' /usr/bin/menu-trojan
sed -i -e 's/\r$//' /usr/bin/add-tr
sed -i -e 's/\r$//' /usr/bin/cek-tr
sed -i -e 's/\r$//' /usr/bin/del-tr
sed -i -e 's/\r$//' /usr/bin/renew-tr

wget -q -O /usr/bin/menu-ss "https://${github}/shadowsocks/menu-ss.sh" && chmod +x /usr/bin/menu-ss
wget -q -O /usr/bin/addss "https://${github}/shadowsocks/addss.sh" && chmod +x /usr/bin/addss
wget -q -O /usr/bin/cekss "https://${github}/shadowsocks/cekss.sh" && chmod +x /usr/bin/cekss
wget -q -O /usr/bin/delss "https://${github}/shadowsocks/delss.sh" && chmod +x /usr/bin/delss
wget -q -O /usr/bin/renewss "https://${github}/shadowsocks/renewss.sh" && chmod +x /usr/bin/renewss
sed -i -e 's/\r$//' /usr/bin/menu-ss
sed -i -e 's/\r$//' /usr/bin/addss
sed -i -e 's/\r$//' /usr/bin/cekss
sed -i -e 's/\r$//' /usr/bin/delss
sed -i -e 's/\r$//' /usr/bin/renewss

wget -q -O /usr/bin/add-trgo "https://${github}/trojan-go/add-trgo.sh" && chmod +x /usr/bin/add-trgo
wget -q -O /usr/bin/cek-trgo "https://${github}/trojan-go/cek-trgo.sh" && chmod +x /usr/bin/cek-trgo
wget -q -O /usr/bin/del-trgo "https://${github}/trojan-go/del-trgo.sh" && chmod +x /usr/bin/del-trgo
wget -q -O /usr/bin/renew-trgo "https://${github}/trojan-go/renew-trgo.sh" && chmod +x /usr/bin/renew-trgo

sed -i -e 's/\r$//' /bin/add-trgo
sed -i -e 's/\r$//' /bin/cek-trgo
sed -i -e 's/\r$//' /bin/del-trgo
sed -i -e 's/\r$//' /bin/renew-trgo
}

echo -e " ${LIGHT}- ${NC}Updating New Script"
arfvpn_bar 'update_script'
echo -e ""

echo -e " ${OK} Successfully !!! ${CEKLIST}"

echo -e ""
echo -e "\033[0;34m└─────────────────────────────────────────────────────┘${NC}"
echo ""
echo -e "${LIGHT}Please write answer ${NC}[ Y/y ]${LIGHT} to ${NC}${ORANGE}Restart-Service${NC}${LIGHT} or ${NC}[ N/n ]${LIGHT} to ${NC}${STABILO}Back to Menu${NC}"
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
sleep 2
clear
menu
else
sleep 2
clear
restart
fi