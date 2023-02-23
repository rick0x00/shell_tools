#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 23 fev 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: project_info                                      #
# Description: basic info of my shell projects pattern         #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #

version="1.0"
tool_name="shell_tools"
logs_directory="/var/log/$tool_name/"
backup_directory="/var/backup/$tool_name/"


division_short_equal_line="========================================"


function show_version() {
    echo "version: $version"
}

function show_changelog-preview() {
    echo "$division_short_equal_line"
    echo "the following directory will be created"
    echo "logs:     $logs_directory"
    echo "backups:  $backup_directory"
    echo ""
    echo "the following files will be created"
    echo "logs:     $logs_directory/execution.log"
    echo "          $logs_directory/summary.log"
    echo "$division_short_equal_line"
}
