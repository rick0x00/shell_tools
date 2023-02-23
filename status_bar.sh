#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 17 fev 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: status_bar                                        #
# Description: Script for help me to implement status bar      #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #


function task_bar() {
    # task bar function
    # example to use: task_bar -at 'actual task number' --tt 'total number of tasks' -task 'short task description' -slb '1|0' -sla '1|0' -cl '1|0'
    if [ -n "$1" ]; then
        #echo "task bar information available"
        while [ -n "$1" ]; do
            #echo "validating task bar values"
            case "$1" in
                ( "-at"|"--at"|"-actual"|"--actual"|"-actual-task"|"--actual-task" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering task parameters: actual-task=$2"
                        local actual_task=$2
                        shift
                    else
                        echo "Error: task parameter incorrect: actual-task=$2"
                    fi
                ;;
                ( "-tt"|"--tt"|"-total"|"--total"|"-total-tasks"|"--total-tasks" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering task parameters: total-tasks=$2"
                        local total_tasks=$2
                        shift
                    else
                        echo "Error: task parameter incorrect: total-tasks=$2"
                    fi
                ;;
                ( "-t"|"--t"|"-task"|"--task"|"-task-msg"|"--task-msg"|"-msg"|"--msg"  )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering task parameters: task-msg=$2"
                        local task_msg=$2
                        shift
                    else
                        echo "Error: task parameter incorrect: task-msg=$2"
                    fi
                ;;
                ( "-slb"|"--slb"|"-shift-line-before"|"--shift-line-before" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering task parameters: shift-line-before=$2"
                        local shift_line_before=$2
                        shift
                    else
                        echo "Error: task parameter incorrect: shift-line-before=$2"
                    fi
                ;;
                ( "-sla"|"--sla"|"-shift-line-after"|"--shift-line-after" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering task parameters: shift-line-after=$2"
                        local shift_line_after=$2
                        shift
                    else
                        echo "Error: task parameter incorrect: shift-line-after=$2"
                    fi
                ;;
                ( "-cl"|"--cl"|"-clear-line"|"--clear-line" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering task parameters: clear-line=$2"
                        local clear_line=$2
                        shift
                    else
                        echo "Error: task parameter incorrect: clear-line=$2"
                    fi
                ;;
                ( "-ed"|"--ed"|"-enable-division"|"--enable-division" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering status parameters: enable-division=$2"
                        local enable_division=$2
                        shift
                    else
                        echo "Error: status parameter incorrect: enable-diivision=$2"
                    fi
                ;;
                ( * )
                    echo "unknown parameter to task bar: $1"
                    local unrecognized_parameters="$1 $unrecognized_parameters"
                ;;
            esac
            shift
        done
    else
        echo "no task bar information available"
    fi
    if [  -n "$unrecognized_parameters" ] || [ -z "$task_msg" ] || [ -z "$total_tasks" ] || [ -z "$actual_task" ] ; then
        echo "error: task not informed correctly"
        echo "task msg: $task_msg"
        echo "total tasks: $total_tasks"
        echo "actual task: $actual_task"
        if [ -n "$unrecognized_parameters" ]; then
            echo "unrecognized parameters: $unrecognized_parameters"
        fi
    else
        local yx_stty=$(stty size)
        local width_tty=${yx_stty#* }
        local icon_line1="-"
        local icon_line2="-"
        if [ -n "$shift_line_before" ]; then
            if [ "$shift_line_before" == "1" ]; then
                echo -en "\n"
            elif [ "$shift_line_before" == "0" ]; then
                echo -en "\r"
            fi
        fi
        if [ -z "$clear_line" ]; then
            local clear_line=0
        fi
        if [ "$clear_line" == "1" ]; then
            for (( c=1; c<=$width_tty; c++ )); do echo -en " " ; done
        else
            if [ -z "$enable_division" ]; then
                local enable_division=0
            fi
            if [ "$enable_division" == "1" ]; then
                #echo $(for (( c=1; c<=$(stty size | cut -d' ' -f2); c++ )); do echo -en "_" ; done)
                echo $(for (( c=1; c<=$width_tty; c++ )); do echo -en "$icon_line1" ; done)
                #echo -en "\n"
            fi
            echo -en "\033[1m"
            echo -en "TASK "
            echo -en "[$actual_task/$total_tasks]: "
            echo -en "\033[0m"
            echo -en "$task_msg"
            if [ "$enable_division" == "1" ]; then
                echo -en "\n"
                #echo $(for (( c=1; c<=$(stty size | cut -d' ' -f2); c++ )); do echo -en "-" ; done)
                echo $(for (( c=1; c<=$width_tty; c++ )); do echo -en "$icon_line2" ; done)
            fi
        fi
        if [ -n "$shift_line_after" ]; then
            if [ "$shift_line_after" == "1" ]; then
                echo -en "\n"
            elif [ "$shift_line_after" == "0" ]; then
                echo -en "\r"
            fi
        fi
    fi
}

function progress_bar() {
    # progress bar function
    # example to use: progress_bar -percent 'percent value' -slb '1|0' -sla '1|0' -cl '1|0'
    if [ -n "$1" ]; then
        #echo "progress bar information available"
        while [ -n "$1" ]; do
            #echo "validating progress bar values"
            case "$1" in
                ( "-percent"|"--percent"  )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering progress parameters: percent=$2"
                        local percent=$2
                        shift
                    else
                        echo "Error: progress parameter incorrect: percent=$2"
                    fi
                ;;
                ( "-slb"|"--slb"|"-shift-line-before"|"--shift-line-before" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering progress parameters: shift-line-before=$2"
                        local shift_line_before=$2
                        shift
                    else
                        echo "Error: progress parameter incorrect: shift-line-before=$2"
                    fi
                ;;
                ( "-sla"|"--sla"|"-shift-line-after"|"--shift-line-after" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering progress parameters: shift-line-after=$2"
                        local shift_line_after=$2
                        shift
                    else
                        echo "Error: progress parameter incorrect: shift-line-after=$2"
                    fi
                ;;
                ( "-cl"|"--cl"|"-clear-line"|"--clear-line" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering progress parameters: clear-line=$2"
                        local clear_line=$2
                        shift
                    else
                        echo "Error: progress parameter incorrect: clear-line=$2"
                    fi
                ;;
                ( "-ed"|"--ed"|"-enable-division"|"--enable-division" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering status parameters: enable-division=$2"
                        local enable_division=$2
                        shift
                    else
                        echo "Error: status parameter incorrect: enable-diivision=$2"
                    fi
                ;;
                ( * )
                    echo "unknown parameter to progress bar: $1"
                    local unrecognized_parameters="$1 $unrecognized_parameters"
                ;;
            esac
            shift
        done
    else
        echo "no progress bar information available"
    fi
    if [  -n "$unrecognized_parameters" ] || [ -z "$percent" ] ; then
        echo "error: progress not informed correctly"
        echo "percent: $percent"
        if [ -n "$unrecognized_parameters" ]; then
            echo "unrecognized parameters: $unrecognized_parameters"
        fi
    else
        local yx_stty=$(stty size)
        local width_tty=${yx_stty#* }
        local width_bar=$(((width_tty-15)-2))
        local bar_percent=$((($percent*$width_bar)/100))
        local complement_bar_percent=$(($width_bar-$bar_percent))
        local icon_line1="-"
        local icon_line2="-"
        if [ -n "$shift_line_before" ]; then
            if [ "$shift_line_before" == "1" ]; then
                echo -en "\n"
            elif [ "$shift_line_before" == "0" ]; then
                echo -en "\r"
            fi
        fi
        if [ -z "$clear_line" ]; then
            local clear_line=0
        fi
        if [ "$clear_line" == "1" ]; then
            for (( c=1; c<=$width_tty; c++ )); do echo -en " " ; done
        else
            if [ -z "$enable_division" ]; then
                local enable_division=0
            fi
            if [ "$enable_division" == "1" ]; then
                #echo $(for (( c=1; c<=$(stty size | cut -d' ' -f2); c++ )); do echo -en "_" ; done)
                echo $(for (( c=1; c<=$width_tty; c++ )); do echo -en "$icon_line1" ; done)
                #echo -en "\n"
            fi
            echo -en "\033[1m"
            echo -en "PROGRESS "
            echo -en "\033[0m"
            echo -en "["
            echo -en "\033[30m"
            echo -en "\033[46m"
            for (( c=1; c<=$bar_percent; c++ )); do echo -en "#" ; done
            echo -en "\033[0m"
            echo -en "\033[1m"
            #echo -en "($percent%)"
            printf '(%4s)' "$percent%"
            echo -en "\033[0m"
            for (( c=1; c<=$complement_bar_percent; c++ )); do echo -en "." ; done
            echo -en "]"
            if [ "$enable_division" == "1" ]; then
                echo -en "\n"
                #echo $(for (( c=1; c<=$(stty size | cut -d' ' -f2); c++ )); do echo -en "-" ; done)
                echo $(for (( c=1; c<=$width_tty; c++ )); do echo -en "$icon_line2" ; done)
            fi
        fi
        if [ -n "$shift_line_after" ]; then
            if [ "$shift_line_after" == "1" ]; then
                echo -en "\n"
            elif [ "$shift_line_after" == "0" ]; then
                echo -en "\r"
            fi
        fi
    fi

}

function status_bar() {
    # status bar function
    # example to use: status_bar -at 'actual task number' --tt 'total number of tasks' -task 'short task description' -slb '1|0' -sla '1|0' -cl '1|0' -ed '1|0'
    if [ -n "$1" ]; then
        #echo "status bar information available"
        while [ -n "$1" ]; do
            #echo "validating status bar values"
            case "$1" in
                ( "-at"|"--at"|"-actual"|"--actual"|"-actual-task"|"--actual-task" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering status parameters: actual-task=$2"
                        local actual_task=$2
                        shift
                    else
                        echo "Error: status parameter incorrect: actual-task=$2"
                    fi
                ;;
                ( "-tt"|"--tt"|"-total"|"--total"|"-total-tasks"|"--total-tasks" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering status parameters: total-tasks=$2"
                        local total_tasks=$2
                        shift
                    else
                        echo "Error: status parameter incorrect: total-tasks=$2"
                    fi
                ;;
                ( "-t"|"--t"|"-task"|"--task"|"-task-msg"|"--task-msg"|"-msg"|"--msg"  )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering status parameters: task-msg=$2"
                        local task_msg=$2
                        shift
                    else
                        echo "Error: status parameter incorrect: task-msg=$2"
                    fi
                ;;
                ( "-slb"|"--slb"|"-shift-line-before"|"--shift-line-before" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering status parameters: shift-line-before=$2"
                        local shift_line_before=$2
                        shift
                    else
                        echo "Error: status parameter incorrect: shift-line-before=$2"
                    fi
                ;;
                ( "-sla"|"--sla"|"-shift-line-after"|"--shift-line-after" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering status parameters: shift-line-after=$2"
                        local shift_line_after=$2
                        shift
                    else
                        echo "Error: status parameter incorrect: shift-line-after=$2"
                    fi
                ;;
                ( "-cl"|"--cl"|"-clear-line"|"--clear-line" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering status parameters: clear-line=$2"
                        local clear_line=$2
                        shift
                    else
                        echo "Error: status parameter incorrect: clear-line=$2"
                    fi
                ;;
                ( "-ed"|"--ed"|"-enable-division"|"--enable-division" )
                    if [ -n "$2" ] && [[ "$2" != -* ]]; then
                        #echo "registering status parameters: enable-division=$2"
                        local enable_division=$2
                        shift
                    else
                        echo "Error: status parameter incorrect: enable-diivision=$2"
                    fi
                ;;
                ( * )
                    echo "unknown parameter to status bar: $1"
                    local unrecognized_parameters="$1 $unrecognized_parameters"
                ;;
            esac
            shift
        done
    else
        echo "no status bar information available"
    fi
    if [  -n "$unrecognized_parameters" ] || [ -z "$task_msg" ] || [ -z "$total_tasks" ] || [ -z "$actual_task" ] ; then
        echo "error: status not informed correctly"
        echo "task msg: $task_msg"
        echo "total tasks: $total_tasks"
        echo "actual task: $actual_task"
        if [ -n "$unrecognized_parameters" ]; then
            echo "unrecognized parameters: $unrecognized_parameters"
        fi
    else
        local yx_stty=$(stty size)
        local width_tty=${yx_stty#* }
        local icon_line1="-"
        local icon_line2="-"
        local percent="$((($actual_task*100)/$total_tasks))"
        if [ -n "$shift_line_before" ]; then
            if [ "$shift_line_before" == "1" ]; then
                echo -en "\n"
            elif [ "$shift_line_before" == "0" ]; then
                echo -en "\r"
            fi
        fi
        if [ -z "$clear_line" ]; then
            local clear_line=0
        fi
        if [ "$clear_line" == "1" ]; then
            echo -en "\033[1A"
            echo -en "\r"
            for (( c=1; c<=$width_tty; c++ )); do echo -en " " ; done
            echo -en "\033[1A"
            echo -en "\r"
            for (( c=1; c<=$width_tty; c++ )); do echo -en " " ; done
            echo -en "\r"
        else
            if [ -z "$enable_division" ]; then
                local enable_division=0
            fi
            if [ "$enable_division" == "1" ]; then
                #echo $(for (( c=1; c<=$(stty size | cut -d' ' -f2); c++ )); do echo -en "_" ; done)
                echo $(for (( c=1; c<=$width_tty; c++ )); do echo -en "$icon_line1" ; done)
                #echo -en "\n"
            fi
            progress_bar -percent "$percent" -slb '0' -sla '1' -cl '0' -ed '0'
            task_bar -tt "$total_tasks" -at "$actual_task" -msg "$task_msg" -sla '0' -slb '0' -cl '0' -ed '0'
            if [ "$enable_division" == "1" ]; then
                echo -en "\n"
                #echo $(for (( c=1; c<=$(stty size | cut -d' ' -f2); c++ )); do echo -en "-" ; done)
                echo $(for (( c=1; c<=$width_tty; c++ )); do echo -en "$icon_line2" ; done)
            fi
        fi
        if [ -n "$shift_line_after" ]; then
            if [ "$shift_line_after" == "1" ]; then
                echo -en "\n"
            elif [ "$shift_line_after" == "0" ]; then
                echo -en "\r"
            fi
        fi
    fi
}