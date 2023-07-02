#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 23 fev 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: system_info                                       #
# Description: Script for help in get system information       #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #

# kernel information
kernel_name="$(uname -s)"
kernel_name=${kernel_name:-"unknown"}
kernel_release="$(uname -r)"
kernel_release=${kernel_release:-"unknown"}

# machine information
host_name="$(hostname)"
host_name=${hostname_name:-"$(uname -n)"}
host_name=${host_name:-"unknown"}
host_full_domain="$(hostname -f | awk -F"." '{print $2}')"
host_full_domain=${host_full_domain:-"unknown"}

# operational system information
os_name=$(cat /etc/os-release | grep "^NAME" | awk -F'=' '{print $2}' | sed -s "s/\"//g")
os_name=${os_name:-"unknown"}
os_version=$(cat /etc/os-release | grep "^VERSION_ID" | awk -F'=' '{print $2}' | sed -s "s/\"//g")
os_version=${os_version:-'unknown'}
os_codename=$(cat /etc/os-release | grep "^VERSION_CODENAME" | awk -F'=' '{print $2}' | sed -s "s/\"//g")
os_codename=${os_codename:-"unknown"}

# Continer information
# containerizer system?
if [ -f /.dockerenv ]; then
    containerized=("yes" "true" "1")
else
    containerized=("no" "false" "0")
fi 
containerized=${containerized:-"unknown"}

# system information
system_architecture="$(uname -m)"

cpu_model="$(cat /proc/cpuinfo | grep '^model name' | head -n1 | awk -F ':[[:space:]]' '{print $2}' | sed 's/\@[[:space:]]//')"
cpu_model=${cpu_model:-"unknown"}

mem_info=$(top -bn1 | head -n 6 | grep '^MiB Mem' | sed "s/^[^:]*://" | sed 's/\(\w\+\)\. /\1,/g' | sed 's/[[:space:]][[:space:]]\+//g')
mem_total=("$(echo $mem_info | tr ',' '\n' | grep 'total' | sed -e 's/[^[:digit:]]*$//g' | tr -d '\n')" "Mb")
mem_total=${mem_total:-"unknown"}
mem_free=("$(echo $mem_info | tr ',' '\n' | grep 'free' | sed -e 's/[^[:digit:]]*$//g' | tr -d '\n')" "Mb")
mem_free=${mem_free:-"unknown"}
mem_used=("$(echo $mem_info | tr ',' '\n' | grep 'used' | sed -e 's/[^[:digit:]]*$//g' | tr -d '\n')" "Mb")
mem_used=${mem_used:-"unknown"}
mem_cached=("$(echo $mem_info | tr ',' '\n' | grep 'cache' | sed -e 's/[^[:digit:]]*$//g' | tr -d '\n')" "Mb")
mem_cached=${mem_cached:-"unknown"}
echo -e "Memory Info: \nTotal: ${mem_total[@]} \nFree: ${mem_free[@]} \nUsed: ${mem_used[@]} \nCached: ${mem_cached[@]}"

swap_info=$(top -bn1 | head -n 6 | grep '^MiB Swap' | sed "s/^[^:]*://" | sed 's/\(\w\+\)\. /\1,/g' | sed 's/[[:space:]][[:space:]]\+//g')
swap_total=("$(echo $swap_info | tr ',' '\n' | grep 'total' | sed -e 's/[^[:digit:]]*$//g' | tr -d '\n')" "Mb")
swap_total=${swap_total:-"unknown"}
swap_free=("$(echo $swap_info | tr ',' '\n' | grep 'free' | sed -e 's/[^[:digit:]]*$//g' | tr -d '\n')" "Mb")
swap_free=${swap_free:-"unknown"}
swap_used=("$(echo $swap_info | tr ',' '\n' | grep 'used' | sed -e 's/[^[:digit:]]*$//g' | tr -d '\n')" "Mb")
swap_used=${swap_used:-"unknown"}
swap_avail=("$(echo $swap_info | tr ',' '\n' | grep 'avail' | sed -e 's/[^[:digit:]]*$//g' | tr -d '\n')" "Mb")
swap_avail=${swap_avail:-"unknown"}
echo -e "Memory Info: \nTotal: ${swap_total[@]} \nFree: ${swap_free[@]} \nUsed: ${swap_used[@]} \nAvail: ${swap_avail[@]}"

# system usage
cpu_usage="$(top -bn1 | grep 'Cpu(s)' | awk '{print $2+$4+$6}')"
mem_usage="$(top -bn1 | grep 'MiB Mem' | awk '{print $8}')"
swap_usage="$(top -bn1 | grep 'MiB Swap' | awk '{print $7}')"
disk_usage=""
load_avarage="$(top -bn1 | grep 'load average:' | awk -F 'load average: ' '{print $2}' | awk -F ', ' '{print $1}')"

# network information
# primary interface = pif
net_pif_name=""
net_pif_ipv4=""
net_pif_ipv6=""


while true ; do
    if_number=$(echo $((1+${if_number:-0})) )
    if_finded_name=$(ip address show | grep "$if_number: " | head -n 1 | awk -F':' '{print $2}' | cut -d ' ' -f 2)
    if [[ $if_finded_name == "" ]] ; then
        break
    fi
    echo -en "Interface finded: $if_finded_name"
    if_finded_ipv4=$( ip address show $if_finded_name | grep "scope global" | grep "inet " | head -n 1 | awk -F' ' '{print $2}')
    if_finded_ipv6=$( ip address show $if_finded_name | grep "scope global" | grep "inet6 " | head -n 1 | awk -F' ' '{print $2}')
    echo " - ipv4: ${if_finded_ipv4:-'undefined'} - ipv6: ${if_finded_ipv6:-'undefined'}"
    if [[ $if_finded_ipv4 != "" ]]; then
        echo "first ipv4 finded ($if_finded_ipv4) on interfacee $if_finded_name, ipv6: ${if_finded_ipv6:-'undefined'}"
	break
    fi
done

hostname_ips=$(hostname -I)

while true ; do
    sequence=$(echo $((1+${sequence:-0})))
    finded_ip=$(echo $hostname_ips | awk -F" " "{print $"$sequence"}")
    if [[ $finded_ip == "" ]]; then
        break
    fi
    echo $finded_ip
    if [ -z $finded_ipv4 ]; then
        if [[ $(echo $finded_ip | grep ".") != "" ]]; then
            finded_ipv4="$finded_ip"
            echo "IPV4 Finded: $finded_ipv4"
        fi
    fi
    if [ -z $finded_ipv6 ]; then
        if [[ $(echo $finded_ip | grep ":") != "" ]]; then
            finded_ipv6="$finded_ip"
            echo "IPV6 Finded: $finded_ipv6"
        fi
    fi
done

