#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 23 fev 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: shell_tools                                       #
# Description: Scripts for help in the creation shell scripts  #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #

# ============================================================ #
# importing functions

function import_script() {
    script_name="$1"
    if [ -e "./${script_name}" ]; then
        # if file "script_name" exist, import
        source ./${script_name}
    else
        # if file "script_name" don't exist, report
        echo "File \"${script_name}\" does not exist";
        exit 1;
    fi    
}

# import show_changelog-preview and show_version functions
import_script "project_info.sh"

# import short_help and full_help functions
import_script "help.sh"

# ============================================================ #

function read_cli_args() {
    local num_arg_errors=0
    while [ -n "$1" ]; do
        if [ "$1" == "-h" ]; then
            short_help;
            exit 0;
        elif [ "$1" == "-H" ] || [ "$1" == "--help" ]; then
            full_help;
            exit 0;
        fi
        case $1 in
            ( "-os"|"--operational-system" )
                if [ -n "$2" ] && [[ "$2" != -* ]]; then
                    case $2 in
                        ( [Dd]ebian | DEBIAN )
                            echo "os system: $2"
                            shift
                            ;;
                        ( * )
                            echo 'error: unrecognized "'$2'" operational system.'
                            local num_arg_errors=$(($num_arg_errors+1))
                            ;;
                    esac
                else
                    echo 'error: operational system not defined'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
                ;;
            ( "-ct"|"--container-technology" )
                if [ -n "$2" ] && [[ "$2" != -* ]]; then
                    case $2 in
                        ( "off"|"no-ct" )
                            echo "Container technology: $2"
                            shift
                            
                            ;;
                        ( * )
                            echo 'error: unrecognized "'$2'" container technology option'
                            local num_arg_errors=$(($num_arg_errors+1))
                            ;;
                    esac
                else
                    echo 'error: Container technology not defined'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
                ;;
            ( "-clp"|"--changelog-preview" )
                show_changelog-preview
                exit 0
                ;;
            ( "-v"|"--version" )
                show_version
                exit 0
                ;;
            ( "-h" )
                short_help
                exit 0
                ;;
            ( "-H"|"--help" )
                full_help
                exit 0
                ;;
            ( * )
                echo "error: unknown option: $1"
                local num_arg_errors=$(($num_arg_errors+1));
            ;;
        esac
        shift
    done
    if [ $num_arg_errors != 0 ]; then
        echo "error: $num_arg_errors invalid arguments"
        exit 1;    
    fi
}

# the command above it used for tests
# read_cli_args $*