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
kernel_version="$(uname -r)"

# operational system information
os_name=$(cat /etc/os-release | grep "^NAME=" | awk -F'"' '{print $2}')
os_version=$(cat /etc/os-release | grep "^VERSION_ID=" | awk -F'"' '{print $2}')

# Continer information
# containerizer system?
containerized=""
# yes = 1 | true
# no = 0 | false
container_name=""
container_version=""

# system information
system_cpu_info="$(cat /proc/cpuinfo | grep 'model name' | head -n1 | awk -F ': ' '{print $2}')"
system_mem_info=""
system_architecture="$(uname -m)"

# system usage
cpu_usage=""
mem_usage="$(cat /proc/meminfo | grep 'MemFree' | awk -F' ' '{print $2}')"
swap_usage="$(cat /proc/meminfo | grep 'SwapFree' | awk -F' ' '{print $2}')"
disk_usage=""
load_avarage=""

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

