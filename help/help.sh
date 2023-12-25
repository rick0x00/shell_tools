#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 23 fev 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: help                                              #
# Description: basic structure for my help projects            #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #


function short_help() {
    echo "$(echo $0): usage: command [-os <os>] [-ct <container>] [--help :show Full help] ...";
}

function full_help() {
    echo "";
    echo -e "\e[1;34mDESCRIPTION: \e[0m";
    echo "Script to help in the creation of DNS Servers.";
    echo "";
    echo -e "\e[1;34mUSAGE: \e[0m";
    echo "  command [OPTIONS] OBJECT ...";
    echo "";
    echo -e "\e[1;34mOPTIONS: \e[0m";
    echo "  -os, --operational-system <os>";
    echo "      Operational System.";
    echo "      [default: debian] [possible values: debian]";
    echo "  -ct, --container-technology <container>"
    echo "      Container Technology.";
    echo "      [default: off|no-ct] [possible values: off|no-ct]";
    echo "  -clp, --changelog-preview"
    echo "      Show changelog preview to be changed/maked by the tool.";
    echo "  -v, --version"
    echo "      Report version of tool.";
    echo "  -h";
    echo "      Show short help message."
    echo "  -H, --help"
    echo "      Show Full Help message.";
    echo "";
    echo -e "\e[1;34mEXAMPLES: \e[0m";
    echo "  command -os debian --ct docker";
    echo "";
}
