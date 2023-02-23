#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 23 fev 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: logger                                            #
# Description: basic logger for my projects                    #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #

tool_name="shell_tools"
logs_directory="/var/log/$tool_name/"

function logger() {
    # logger function
    # exemple to use: logger -task 'value task' --priority 'value priority' -msg "log message"
    if [ -n "$1" ]; then
    #echo "Log information specified"
        while [ -n "$1" ]; do
            #echo "validating log values"
            case $1 in
                ( "-task"|"--task" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering log parameter: task=$2"
                        local task="$2"
                        shift
                    else
                        echo "error: log parameter incorrect: task=$2"
                    fi
                ;;
                ( "-priority"|"--priority" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering log parameter: priority=$2"
                        local priority="$2"
                        shift
                    else
                        echo "error: log parameter incorrect: priority=$2"
                    fi
                ;;
                ( "-msg"|"--msg"|"-message"|"--message" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering log parameter: message=$2"
                        local log_msg="$2"
                        shift
                    else
                        echo "error: log parameter incorrect: message=$2"
                    fi
                ;;
                ( "-show"|"--show" )
                    #echo "set show log parameter"
                    local show_msg="1"
                ;;
                ( * )
                    echo "unknown parameter to log: $1"
                    local unrecognized_parameters="$1 $unrecognized_parameters"
                ;;
            esac
            shift
        done
        if [  -n "$unrecognized_parameters" ] || [ -z "$log_msg" ] || [ -z "$task" ] || [ -z "$priority" ]; then
        echo "error: log not informed correctly"
        echo "task: $task"
        echo "priority: $priority"
        echo "message: $log_msg"
            if [ -n "$unrecognized_parameters" ]; then
                echo "unrecognized parameters: $unrecognized_parameters"
            fi
        else
            if [[  "$priority" == "emerg"||"alert"||"crit"||"err"||"warn"||"notice"||"debug"||"info" ]]; then
                #echo "priority: value is valid: $priority"
                while [ True ]; do
                    if [ -d "$logs_directory" ]; then
                        #echo "logs directory already exist."
                        if [ -e "$logs_directory/execution.log" ]; then
                            #echo "log file already exist."
                            #echo "writing log"
                            echo "$(date --rfc-3339='s') $(hostname) $0[$PPID]: $task: $priority: $log_msg" >> "$logs_directory/execution.log"
                            if [ "$show_msg" == "1" ]; then
                                #echo "show log message"
                                echo "$log_msg"
                            fi
                            break
                        else
                            echo "creating file $logs_directory/execution.log to logs registry."
                            touch "$logs_directory/execution.log"
                            echo "$(date --rfc-3339='s') $(hostname) $0[$PPID]: rick0x00 script executed" >> /var/log/syslog
                        fi
                    else
                        echo "creating directory $logs_directory to log registry."
                        mkdir -p "$logs_directory"
                    fi
                done
            else
                echo "Priority value '$priority' is not supported"
            fi
        fi
    else
        echo "no log information specified"
    fi 
}
