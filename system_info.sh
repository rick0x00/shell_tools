#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 23 fev 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: system_info                                     #
# Description: Script for help in get system information       #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #

function kernel_info() {
    # kernel information
    kernel_name="$(uname -s)"
    kernel_name=${kernel_name:-"unknown"}
    kernel_release="$(uname -r)"
    kernel_release=${kernel_release:-"unknown"}
    if [ "$1" == "show" ]; then
            echo -e "Kernel info: \n  Name: $kernel_name \n  Release: $kernel_release"
    fi
}

function host_info() {
    # machine information
    host_name="$(hostname)"
    host_name=${hostname_name:-"$(uname -n)"}
    host_name=${host_name:-"unknown"}
    host_full_domain=.$(hostname -f | awk -F"." '{print $2}').
    host_full_domain=${host_full_domain:-"unknown"}
    if [ "$1" == "show" ]; then
        echo -e "Host Info: \n  name: $host_name \n  full domain: $host_full_domain"
    fi
}

function os_info () {
    # operational system information
    os_name=$(cat /etc/os-release | grep "^NAME" | awk -F'=' '{print $2}' | sed -s "s/\"//g")
    os_name=${os_name:-"unknown"}
    os_version=$(cat /etc/os-release | grep "^VERSION_ID" | awk -F'=' '{print $2}' | sed -s "s/\"//g")
    os_version=${os_version:-'unknown'}
    os_codename=$(cat /etc/os-release | grep "^VERSION_CODENAME" | awk -F'=' '{print $2}' | sed -s "s/\"//g")
    os_codename=${os_codename:-"unknown"}
    if [ "$1" == "show" ]; then
        echo -e "Operational system info: \n  Name: $os_name \n  Version: $os_version \n  Codename: $os_codename"
    fi
}

function continer_info () {
    # Continer information
    # containerizer system?
    if [ -f /.dockerenv ]; then
        containerized=("yes" "true" "1")
        container_technology="docker"
    else
        containerized=("no" "false" "0")
        container_technology="unknown"
    fi 
    containerized=${containerized:-"unknown"}
    if [ "$1" == "show" ]; then
        echo -e "Container Info: \n  Inside Container: $containerized \n  Container technology: $container_technology"
    fi
}

function data_extract () {
    if [ -z "$top_date" ]; then
        top_date=$(top -bn1 | head -n 6 | tr '\n' '+')
    fi
    echo $top_date | tr '+' '\n'
}

function cpu_info () {
    cpu_architecture="$(uname -m)"
    cpu_architecture=${cpu_architecture:-"unknown"}
    cpu_model=$(cat /proc/cpuinfo | grep '^model name' | head -n1 | awk -F ':[[:space:]]' '{print $2}' | sed 's/\@[[:space:]]//')
    cpu_model=${cpu_model:-"unknown"}
    cpu_stats=$( data_extract | grep 'Cpu(s)' | sed 's/^[^:]*://' | sed 's/[[:space:]][[:space:]]\+//g' )
    cpu_idle=$(echo $cpu_stats | tr ',' '\n' | grep 'id' | sed -e 's/[^[:digit:]]*$//g' | sed -e 's/[[:space:]]//g' | tr -d '\n')
    cpu_usage=("$(echo 100 $cpu_idle | awk '{print $1 - $2 }')" "%")
    if [ "$1" == "show" ]; then
        echo -e "CPU Info: \n  Model: $cpu_model \n  Architecture: $cpu_architecture \n  Usage: ${cpu_usage[@]}"
    fi
}

function mem_info () {
    mem_stats=$( data_extract | grep '^MiB Mem' | sed "s/^[^:]*://" | sed 's/[[:space:]][[:space:]]\+//g')
    mem_total=("$(echo $mem_stats | tr ',' '\n' | grep 'total' | sed -e 's/[^[:digit:]]*$//g' | sed -e 's/[[:space:]]//g' | tr -d '\n')" "Mb")
    mem_total=${mem_total:-"unknown"}
    mem_free=("$(echo $mem_stats | tr ',' '\n' | grep 'free' | sed -e 's/[^[:digit:]]*$//g' | sed -e 's/[[:space:]]//g' | tr -d '\n')" "Mb")
    mem_free=${mem_free:-"unknown"}
    mem_used=("$(echo $mem_stats | tr ',' '\n' | grep 'used' | sed -e 's/[^[:digit:]]*$//g' | sed -e 's/[[:space:]]//g' | tr -d '\n')" "Mb")
    mem_used=${mem_used:-"unknown"}
    mem_cached=("$(echo $mem_stats | tr ',' '\n' | grep 'cache' | sed -e 's/[^[:digit:]]*$//g' | sed -e 's/[[:space:]]//g' | tr -d '\n')" "Mb")
    mem_cached=${mem_cached:-"unknown"}
    mem_usage=("$(echo $mem_used $mem_total | awk '{ printf "%.2f", ( $1 / $2 ) * 100 }')" "%")
    if [ "$1" == "show" ]; then
        echo -e "Memory Info: \n  Total: ${mem_total[@]} \n  Free: ${mem_free[@]} \n  Used: ${mem_used[@]} ${mem_usage[@]} \n  Cached: ${mem_cached[@]}"
    fi
}

function swap_info () {
    swap_stats=$( data_extract | grep '^MiB Swap' | sed "s/^[^:]*://" | sed 's/\(\w\+\)\. /\1,/g' | sed 's/[[:space:]][[:space:]]\+//g')
    swap_total=("$(echo $swap_stats | tr ',' '\n' | grep 'total' | sed -e 's/[^[:digit:]]*$//g' | sed -e 's/[[:space:]]//g'  | tr -d '\n')" "Mb")
    swap_total=${swap_total:-"unknown"}
    swap_free=("$(echo $swap_stats | tr ',' '\n' | grep 'free' | sed -e 's/[^[:digit:]]*$//g' | sed -e 's/[[:space:]]//g' | tr -d '\n')" "Mb")
    swap_free=${swap_free:-"unknown"}
    swap_used=("$(echo $swap_stats | tr ',' '\n' | grep 'used' | sed -e 's/[^[:digit:]]*$//g' | sed -e 's/[[:space:]]//g' | tr -d '\n')" "Mb")
    swap_used=${swap_used:-"unknown"}
    swap_avail=("$(echo $swap_stats | tr ',' '\n' | grep 'avail' | sed -e 's/[^[:digit:]]*$//g' | sed -e 's/[[:space:]]//g' | tr -d '\n')" "Mb")
    swap_avail=${swap_avail:-"unknown"}
    swap_usage=("$(echo $swap_used $swap_total | awk '{ printf "%.2f", ( $1 / $2 ) * 100 }')" "%")
    if [ "$1" == "show" ]; then
        echo -e "Swap Info: \n  Total: ${swap_total[@]} \n  Free: ${swap_free[@]} \n  Used: ${swap_used[@]} ${swap_usage[@]} \n  Avail: ${swap_avail[@]}"
    fi
}

function disk_info () {
    disk_stats=$(df -h | grep '/$')
    disk_filesystem=$(echo $disk_stats | awk '{print $1}')
    disk_size=$(echo $disk_stats | awk '{print $2}')
    disk_used=$(echo $disk_stats | awk '{print $3}')
    disk_avail=$(echo $disk_stats | awk '{print $4}')
    disk_use_percent=$(echo $disk_stats | awk '{print $5}' | sed 's/\%//')
    disk_mounted_point=$(echo $disk_stats | awk '{print $6}')
    disk_usage=("$disk_use_percent" "%")
    if [ "$1" == "show" ]; then
        echo -e "Disk info: \n  Filesystem: $disk_filesystem \n  Mounted Point: $disk_mounted_point \n  Size: $disk_size \n  Avail: $disk_avail \n  Used: ${disk_usage[@]}"
    fi
}

function load_info () {
    sys_load_stats=$(uptime | grep -o 'load average.*$' | sed 's/^[^:]*://' | sed 's/[[:space:]][[:space:]]\+//g' | tr ',' ' ' )
    sys_load_1min=("$(echo $sys_load_stats  | awk '{print $1}')" "%")
    sys_load_5min=("$(echo $sys_load_stats  | awk '{print $2}')" "%")
    sys_load_15min=("$(echo $sys_load_stats  | awk '{print $3}')" "%")
    load_avarage=${sys_load_1min[@]}
    if [ "$1" == "show" ]; then
        echo -e "Load Average: \n  last 1 minute: ${sys_load_1min[@]} \n  last 5 minute: ${sys_load_5min[@]} \n  last 15 minute: ${sys_load_15min[@]}"
    fi
}

function system_info () {
    # system usage
    kernel_info $1
    host_info $1
    os_info $1
    continer_info $1
    cpu_info $1
    mem_info $1
    swap_info $1
    disk_info  $1
    load_info  $1
}

system_info "show"

uptime
virtualization

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

