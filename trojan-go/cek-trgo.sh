#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

clear
arfvpn="/etc/arfvpn"
trgo="/etc/arfvpn/trojan-go"
logtrgo="/var/log/arfvpn/trojan-go"
ipvps="/var/lib/arfvpn"
source ${ipvps}/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat ${arfvpn}/domain)
else
domain=$IP
fi
clear 

echo "------------------------------------";
echo "-----=[ Trojan-Go User Login ]=-----";
echo "------------------------------------";
echo -n > /tmp/other.txt
data=( `cat ${trgo}/akun.conf | grep '^#trgo#' | cut -d ' ' -f 2`);
for akun in "${data[@]}"
do
if [[ -z "${akun}" ]]; then
akun="tidakada"
fi
echo -n > /tmp/iptrojango.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep trojan-go | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat ${logtrgo}/trojan-go.log | grep -w ${akun} | awk '{print $3}' | cut -d: -f1 | grep -w ${ip} | sort | uniq)
if [[ "${jum}" = "${ip}" ]]; then
echo "${jum}" >> /tmp/iptrojango.txt
else
echo "${ip}" >> /tmp/other.txt
fi
jum2=$(cat /tmp/iptrojango.txt)
sed -i "/${jum2}/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/iptrojango.txt)
oth=$(cat /tmp/other.txt | sort | uniq | nl)
lastlogin=$(cat ${logtrgo}/trojan-go.log | grep -w "${akun}" | tail -n 500 | cut -d " " -f 2 | tail -1)
if [[ -z "${jum}" ]]; then
echo > /dev/null
#else
jum2=$(cat /tmp/iptrojango.txt | nl)
echo "user : ${akun}";
echo "Login dengan IP:"
echo "${oth} | ${lastlogin}";
echo "------------------------------------";
fi
done

rm -rf /tmp/iptrojango.txt
rm -rf /tmp/other.txt

echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
