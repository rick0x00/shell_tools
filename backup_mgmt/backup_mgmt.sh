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
                        #echo "source set: $backup_source_set"
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
                                echo 'error: destination already specified'
                                local num_arg_errors=$(($num_arg_errors+1));
                            fi
                        else
                            local backup_destination_set="$2"
                            TRIGGER_BACKUP_DESTINATION_SET="1"
                        fi
                        #echo "destination set: $backup_destination_set"
                        shift
                    done
                else
                    echo 'error: destination not specified'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
                ;;
            ( "-r"|"--r"|"-retention"|"--retention" )
                if [ -n "$2" ] && [[ "$2" != -* ]]; then
                    while [ -n "$2" ] && [[ "$2" != -* ]]; do
                        # This while loop ensure that the complete message is defined
                        # This is useful when using $* and not $@
                        if [ -n "${TRIGGER_BACKUP_RETENTION_SET}" ] ; then
                            if [ -z "${backup_retention_set}" ]; then
                                local backup_retention_set="$2"
                                TRIGGER_BACKUP_RETENTION_SET="1"
                            else
                                echo 'error: retention already specified'
                                local num_arg_errors=$(($num_arg_errors+1));
                            fi
                        else
                            local backup_retention_set="$2"
                            TRIGGER_BACKUP_RETENTION_SET="1"
                        fi
                        #echo "retention set: $backup_retention_set"
                        shift
                    done
                else
                    echo 'error: retention not specified'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
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

    #echo "backup_source_set: $backup_source_set"
    export BACKUP_SOURCE="${backup_source_set}"
    echo "SOURCE SPECIFIED: $backup_source_set"
    #echo "backup_destination_set: $backup_destination_set"
    export BACKUP_DESTINATION="${backup_destination_set}"
    echo "DESTINATION SPECIFIED: $backup_destination_set"
    #echo "backup_retention_set: $backup_retention_set"
    export BACKUP_RETENTION="${backup_retention_set}"
    echo "RETENTION SPECIFIED: $backup_retention_set"

    # reserving date
    export BACKUP_DATE=$(date +"Y%Ym%md%d-H%HM%MS%S")

    # reserving hostname
    export BACKUP_HOST_HOSTNAME="$(hostname)"

    return 0
}

function backup_checks() {
    echo "## BACKUP CHECKS"

    # make sure you have "/" at the end of the variable
    if [[ "${BACKUP_DESTINATION: -1}" != "/" ]]; then
        BACKUP_DESTINATION="${BACKUP_DESTINATION}/"
    fi

    echo -n "# check if destination directory exists. "
    # check if destination directory exists
    if [ ! -d ${BACKUP_DESTINATION} ]; then
        echo -n "# destination directory not exists! "
        echo "# creating..."
        mkdir -p ${BACKUP_DESTINATION}
    else
        echo -n "# destination directory already exists "
        echo "# skipping..."
    fi

    echo "# check if source specified exists"
    # loop to grant check multiple source specified
    for to_check in ${BACKUP_SOURCE}; do
        echo -n "# check if \"$to_check\" exist:"
        if [ -e "$to_check" ]; then
            echo " exists..."
        else
            echo " NOT EXIST."
            exit 1
        fi 
    done
}

function backup_create() {
    echo "## CREATING BACKUP"

    # specify backup file URL
    local extension="tar.gz"
    local backup_file="${BACKUP_DESTINATION}${BACKUP_DATE}.${extension}"
    local log_file="${BACKUP_DESTINATION}${BACKUP_DATE}.log"

    function backup_create_file(){
        echo "# CREATING BACKUP FILE <${backup_file}>..."
        tar -czf "${backup_file}" ${BACKUP_SOURCE}
    }

    function backup_create_log(){
        echo "# CREATING LOG FILE <${log_file}>..."
        echo "# log of backup file <${backup_file}>" > "${log_file}"
        echo "BACKUP_DATE=\"${BACKUP_DATE}\"" >> "${log_file}"
        echo "BACKUP_HOST_HOSTNAME=\"${BACKUP_HOST_HOSTNAME}\"" >> "${log_file}"
        echo "BACKUP_RETENTION=\"${BACKUP_RETENTION}\"" >> "${log_file}"
        echo "BACKUP_DESTINATION=\"${BACKUP_DESTINATION}\"" >> "${log_file}"
        echo "BACKUP_SOURCE=\"${BACKUP_SOURCE}\"" >> "${log_file}"
    }

    backup_create_file
    
    # check error of creation backup file
    if [ $? -ne 0 ]; then
        echo "# BACKUP ERROR: aborting..."
        rm -f "${backup_file}"
        exit 1
    fi

    backup_create_log
}

function backup_retention() {
    echo "## SETTING RETENTION OF BACKUPS"

    if [[ ${BACKUP_RETENTION} -ne 0 ]]; then
        echo "# retention is specified"

        #local existent_backups="$(ls -t /var/backups/*.tar*)"
        local quantity_of_existent_backups="$(ls -t ${BACKUP_DESTINATION}*.tar* | wc -l)"
        
        #echo "Existent backups: ${existent_backups}"
        echo "# quantity of existent backups: ${quantity_of_existent_backups}"

        # check if existe surplus backups
        if [[ ${quantity_of_existent_backups} -gt ${BACKUP_RETENTION} ]]; then
            local quantity_of_surplus_backups_detected="$((${quantity_of_existent_backups} - ${BACKUP_RETENTION}))"
            echo "# \"${quantity_of_surplus_backups_detected}\" surplus backups detected"
            local surplus_backups="$(ls -t ${BACKUP_DESTINATION}*.tar* | tail -n ${quantity_of_surplus_backups_detected})"
            echo "# surplus backups: "
            echo "${surplus_backups}"
            for to_delete_backup in ${surplus_backups} ; do
                local backup_file_to_delete="${to_delete_backup}"
                local backup_log_to_delete="${backup_file_to_delete%tar.gz}log"
                echo "# deleting <${backup_file_to_delete}> and <${backup_log_to_delete}>..."
                rm -f ${backup_file_to_delete}
                rm -f ${backup_log_to_delete}
            done
        fi

    else
        echo "# retentions not specified."
    fi


}


backup_mgmt_option_setting $@

backup_checks
backup_create
backup_retention
