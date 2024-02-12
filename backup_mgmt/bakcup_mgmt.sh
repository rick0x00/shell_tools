#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 10 fev 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: backup_mgmt                                       #
# Description: basic backup manager                            #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #


function backup_mgmt_short_help() {
    echo -e "usage:\n    $(echo $0) [OPTIONS] <OBJECT>"
    echo "execute  \"$(echo $0) --help\" to get more information...";
}

function backup_mgmt_full_help() {
    echo "";
    echo "DESCRIPTION:";
    echo "  tool to format text.";
    echo "";
    echo "USAGE:";
    echo "  $(echo $0) [OPTIONS] <OBJECT> ...";
    echo "";
    echo "OPTIONS:";
    echo "  -s, --s, -source, --source <files/paths>"
    echo "      source files/paths.";
    echo "      [default: UNDEFINED]"
    echo "      [possible values of <files>: /etc/network/interfaces, /etc/samba/";
    echo "  -d, --d, -destination, --destination <path>"
    echo "      destination backup(the destination must be a directory).";
    echo "      [default: /var/backup/]"
    echo "      [possible values of <path>: /var/backup/, /tmp/, ...";
    echo "  -r, --r, -retention, --retention <number>"
    echo "      retentions backups(number of backups).";
    echo "      [default: 10]"
    echo "      [possible values of <number>: 10, 4, 30, ...";
    echo "  -h";
    echo "      Show short help message."
    echo "  -H, --help"
    echo "      Show Full Help message.";
    echo "";
    echo "EXAMPLES:";
    echo "  ./$(echo $0) -s '/etc/hosts' -d '/etc/' -r 5";
    echo "";
}


function backup_mgmt_option_setting() {
    #echo "imputed args: $@"
    backup_mgmt_function_args="$@"
    if [ -z "${backup_mgmt_function_args}" ]; then
        echo "Error, no options specified"
        backup_mgmt_short_help;
        exit 0;
    fi

    ## read CLI Args
    while [ -n "$1" ]; do
        if [ "$1" == "-h" ]; then
            backup_mgmt_short_help;
            exit 0;
        elif [ "$1" == "-H" ] || [ "$1" == "--help" ]; then
            backup_mgmt_full_help;
            exit 0;
        fi
        case $1 in
            ( "-s"|"--s"|"-source"|"--source" )
                if [ -n "$2" ] && [[ "$2" != -* ]]; then
                    while [ -n "$2" ] && [[ "$2" != -* ]]; do
                        # This while loop ensure that the complete message is defined
                        # This is useful when using $* and not $@
                        if [ -n "${TRIGGER_BACKUP_SOURCE_SET}" ] ; then
                            if [ -z "${backup_source_set}" ]; then
                                local backup_source_set="$2"
                                TRIGGER_BACKUP_SOURCE_SET="1"
                            else
                                local backup_source_set="${backup_source_set} "
                                local backup_source_set="${backup_source_set}$2"
                                TRIGGER_BACKUP_SOURCE_SET="1"
                            fi
                        else
                            local backup_source_set="$2"
                            TRIGGER_BACKUP_SOURCE_SET="1"
                        fi
                        echo "Source set: $backup_source_set"
                        shift
                    done
                else
                    echo 'error: source not specified'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
                ;;
            ( "-d"|"--d"|"-destination"|"--destination" )
                if [ -n "$2" ] && [[ "$2" != -* ]]; then
                    while [ -n "$2" ] && [[ "$2" != -* ]]; do
                        # This while loop ensure that the complete message is defined
                        # This is useful when using $* and not $@
                        if [ -n "${TRIGGER_BACKUP_DESTINATION_SET}" ] ; then
                            if [ -z "${backup_destination_set}" ]; then
                                local backup_destination_set="$2"
                                TRIGGER_BACKUP_DESTINATION_SET="1"
                            else
                                local backup_destination_set="${backup_destination_set} "
                                local backup_destination_set="${backup_destination_set}$2"
                                TRIGGER_BACKUP_DESTINATION_SET="1"
                            fi
                        else
                            local backup_destination_set="$2"
                            TRIGGER_BACKUP_DESTINATION_SET="1"
                        fi
                        echo "destination set: $backup_destination_set"
                        shift
                    done
                else
                    echo 'error: destination not specified'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
                ;;
            ( "-enrs"|"--enrs"|"-exit_not_reset_style"|"--exit_not_reset_style" )
                #echo "seted: exit not reset style"
                local exit_not_reset_style="yes"
                #shift
                ;;
            ( "-h" )
                backup_mgmt_short_help
                exit 0
                ;;
            ( "-H"|"--help" )
                backup_mgmt_full_help
                exit 0
                ;;
            ( * )
                echo "error: unknown option: $1"
                local num_arg_errors=$(($num_arg_errors+1));
            ;;
        esac
        shift
    done

    if [[ -n "$num_arg_errors" ]]; then
        echo "error: $num_arg_errors invalid arguments"
        exit 1;    
    fi

    # output the defined options

    echo "backup_source_set: $backup_source_set"
    echo "backup_destination_set: $backup_destination_set"
    
    

    exit 0
}


backup_mgmt_option_setting $@