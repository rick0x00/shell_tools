#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 12 dez 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: text_format                                       #
# Description: basic shell text color/style edit               #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #

# base: https://en.wikipedia.org/wiki/ANSI_escape_code



function text_format_set_variables_values() {
    ### message
    text_msg="lorem ipsum dolor sit amet"

    ### Control Sequence Introducer, or CSI, commands, the ESC(ANSI escape sequences)
    csi_esc="\e["
    csi_esc="\033["

    function set_variables_foreground_color() {
        ### Foreground Color
        text_fg_color_black="${csi_esc}30m"
        text_fg_color_red="${csi_esc}31m"
        text_fg_color_green="${csi_esc}32m"
        text_fg_color_yellow="${csi_esc}33m"
        text_fg_color_blue="${csi_esc}34m"
        text_fg_color_magenta="${csi_esc}35m"
        text_fg_color_cyan="${csi_esc}36m"
        text_fg_color_bright_gray="${csi_esc}37m"
        text_fg_color_gray="${csi_esc}90m"
        text_fg_color_bright_red="${csi_esc}91m"
        text_fg_color_bright_green="${csi_esc}92m"
        text_fg_color_bright_yellow="${csi_esc}93m"
        text_fg_color_bright_blue="${csi_esc}94m"
        text_fg_color_bright_magenta="${csi_esc}95m"
        text_fg_color_bright_cyan="${csi_esc}96m"
        text_fg_color_white="${csi_esc}97m"

        r_value_color="255"
        g_value_color="255"
        b_value_color="255"
        text_fg_color_rgb="${csi_esc}38;2;${r_value_color};${g_value_color};${b_value_color}m" # 24-bit RGB 0-255 values set color
        text_fg_color_24bit="${text_bg_color_rgb}"

        byte_value_color="255"
        text_fg_color_8bit="${csi_esc}48;5;${byte_value_color}m" # 8-bit 0-255 values set color

        r_value_color="255"
        g_value_color="255"
        b_value_color="255"
        text_style_underline_color_rgb="${csi_esc}58;2;${r_value_color};${g_value_color};${b_value_color}m" # 24-bit RGB 0-255 values set color
        text_style_underline_color_24bit="${text_style_underline_color_rgb}"

        text_style_off_underline_color="${csi_esc}59m" # turn off underline color
    }
    set_variables_foreground_color

    function set_variables_background_color() {
        ### Background Color
        text_bg_color_black="${csi_esc}40m"
        text_bg_color_red="${csi_esc}41m"
        text_bg_color_green="${csi_esc}42m"
        text_bg_color_yellow="${csi_esc}43m"
        text_bg_color_blue="${csi_esc}44m"
        text_bg_color_magenta="${csi_esc}45m"
        text_bg_color_cyan="${csi_esc}46m"
        text_bg_color_gray="${csi_esc}47m"
        text_bg_color_bright_gray="${csi_esc}100m"
        text_bg_color_bright_red="${csi_esc}101m"
        text_bg_color_bright_green="${csi_esc}102m"
        text_bg_color_bright_yellow="${csi_esc}103m"
        text_bg_color_bright_blue="${csi_esc}104m"
        text_bg_color_bright_magenta="${csi_esc}105m"
        text_bg_color_bright_cyan="${csi_esc}106m"
        text_bg_color_white="${csi_esc}107m"

        r_value_color="255"
        g_value_color="0"
        b_value_color="0"
        text_bg_color_rgb="${csi_esc}48;2;${r_value_color};${g_value_color};${b_value_color}m" # 24-bit RGB 0-255 values set color
        text_bg_color_24bit="${text_bg_color_rgb}"

        byte_value_color="255"
        text_bg_color_8bit="${csi_esc}48;5;${byte_value_color}m" # 8-bit 0-255 values set color
    }
    set_variables_background_color

    function set_variables_styles() {
        ### style
        text_style_reset="${csi_esc}0m" # All attributes become turned off

        text_style_bold="${csi_esc}1m"
        text_style_faint="${csi_esc}2m"
        text_style_italic="${csi_esc}3m"
        text_style_underline="${csi_esc}4m"
        text_style_overline="${csi_esc}53m" 

        text_style_slow_blink="${csi_esc}5m"
        text_style_rapid_blink="${csi_esc}6m"

        text_style_invert="${csi_esc}7m" # invert color FG with BG
        text_style_hide="${csi_esc}8m" # hide text
        text_style_strike="${csi_esc}9m" # strike text

        text_style_double_underline="${csi_esc}21m"

        text_style_off_bold="${csi_esc}22m" # turn off bold/faint(enable normal intensity)
        text_style_off_italic="${csi_esc}23m" # turn off italic
        text_style_off_underline="${csi_esc}24m" # turn off underline
        text_style_off_overline="${csi_esc}55m" # turn off overline

        text_style_off_blink="${csi_esc}25m" # turn off blink

        text_style_off_invert="${csi_esc}27m" # turn off invert color FG with BG
        text_style_off_hide="${csi_esc}28m" # turn off hide text
        text_style_off_strike="${csi_esc}29m" # turn off strike text

    }
    set_variables_styles
}
text_format_set_variables_values

function text_format_short_help() {
    echo -e "usage:\n    $(echo $0) [OPTIONS] <OBJECT>"
    echo "execute  \"$(echo $0) --help\" to get more information...";
}

function text_format_full_help() {
    echo "";
    echo -e "${text_style_bold}DESCRIPTION:${text_style_reset}";
    echo "  tool to format text.";
    echo "";
    echo -e "${text_style_bold}USAGE:${text_style_reset}";
    echo "  $(echo $0) [OPTIONS] <OBJECT> ...";
    echo "";
    echo -e "${text_style_bold}OPTIONS:${text_style_reset}";
    echo "  -fgc, --fgc, -foreground_color, --foreground_color <color>"
    echo "      Foreground color.";
    echo -e "      [possible values of <color>: ${text_fg_color_white}white${text_style_reset}, ${text_fg_color_black}black${text_style_reset}(black), ${text_fg_color_red}red${text_style_reset}, ${text_fg_color_green}green${text_style_reset}, ${text_fg_color_yellow}yellow${text_style_reset}, ${text_fg_color_blue}blue${text_style_reset}, ${text_fg_color_magenta}magenta${text_style_reset}, ${text_fg_color_cyan}cyan${text_style_reset}, ${text_fg_color_gray}gray${text_style_reset}, ${text_fg_color_bright_gray}bright_gray${text_style_reset}, ${text_fg_color_bright_red}bright_red${text_style_reset}, ${text_fg_color_bright_green}bright_green${text_style_reset}, ${text_fg_color_bright_yellow}bright_yellow${text_style_reset}, ${text_fg_color_bright_blue}bright_blue${text_style_reset}, ${text_fg_color_bright_magenta}bright_magenta${text_style_reset}, ${text_fg_color_bright_cyan}bright_cyan${text_style_reset}, ${text_fg_color_red}r${text_fg_color_green}g${text_fg_color_blue}b${text_fg_color_white} <255,255,255>${text_style_reset}, underline_${text_style_underline}${csi_esc}58;2;255;0;0mr${csi_esc}58;2;0;255;0mg${csi_esc}58;2;0;0;255mb${text_style_reset} <255,255,255>";  
    echo "  -bgc, --bgc, -background_color, --background_color <color>"
    echo "      Background color.";
    echo "      [default: black]"
    echo -e "      [possible values of <color>: ${text_bg_color_white}white${text_style_reset}(white), ${text_bg_color_black}black${text_style_reset}, ${text_bg_color_red}red${text_style_reset}, ${text_bg_color_green}green${text_style_reset}, ${text_bg_color_yellow}yellow${text_style_reset}, ${text_bg_color_blue}blue${text_style_reset}, ${text_bg_color_magenta}magenta${text_style_reset}, ${text_bg_color_cyan}cyan${text_style_reset}, ${text_bg_color_gray}gray${text_style_reset}, ${text_bg_color_bright_gray}bright_gray${text_style_reset}, ${text_bg_color_bright_red}bright_red${text_style_reset}, ${text_bg_color_bright_green}bright_green${text_style_reset}, ${text_bg_color_bright_yellow}bright_yellow${text_style_reset}, ${text_bg_color_bright_blue}bright_blue${text_style_reset}, ${text_bg_color_bright_magenta}bright_magenta${text_style_reset}, ${text_bg_color_bright_cyan}bright_cyan${text_style_reset}, ${text_bg_color_red}r${text_bg_color_green}g${text_bg_color_blue}b${text_style_reset} <255,255,255>";  
    echo "  -es, --es, -enable_style, --enable_style <style>"
    echo "      Enable Style of text.";
    echo "      [default: reset]"
    echo -e "      [possible values of <style>: ${text_style_reset}reset${text_style_reset}, ${text_style_bold}bold${text_style_reset}, ${text_style_faint}faint${text_style_reset}, ${text_style_italic}italic${text_style_reset}, ${text_style_underline}underline${text_style_reset}, ${text_style_overline}overline${text_style_reset}, ${text_style_rapid_blink}rapid_blink${text_style_reset}, ${text_style_slow_blink}slow_blink${text_style_reset}, ${text_style_invert}invert${text_style_reset}, ${text_style_hide}hide${text_style_reset}(hide), ${text_style_strike}strike${text_style_reset}, ${text_style_double_underline}double_underline${text_style_reset}";
    echo "  -ds, --ds, -disable_style, --disable_style <style>"
    echo "      Disable Style of text.";
    echo "      [default: bold]"
    echo -e "      [possible values of <style>: ${text_style_bold}bold${text_style_reset}, ${text_style_italic}italic${text_style_reset}, ${text_style_underline}underline${text_style_reset}, ${text_style_overline}overline${text_style_reset}, ${text_style_slow_blink}blink${text_style_reset}, ${text_style_invert}invert${text_style_reset}, ${text_style_hide}hide${text_style_reset}(hide), ${text_style_strike}strike${text_style_reset}";
    echo "  -msg, --msg, -message, --message \"<text>\""
    echo "      Define the text of format.";
    echo "      [default: not defined]"
    echo "      [possible values of <text>: all available(every use the syntax \"<text>\" to define a message to format";
    echo "  -enrs, --enrs, -exit_not_reset_style, --exit_not_reset_style";
    echo "      exit of this tool not reset style defined."
    echo "      [default: not seted]"
    echo "  -h";
    echo "      Show short help message."
    echo "  -H, --help"
    echo "      Show Full Help message.";
    echo "";
    echo -e "${text_style_bold}EXAMPLES:${text_style_reset}";
    echo "  ./text_format.sh --fgc red -bgc white --enable_style rapid_blink -msg \"Hello World\"";
    echo "  ./text_format.sh -fgc rgb 0,100,255 -bgc rgb 255,255,255 -es bold -msg \"RICK0X00\"";
    echo "";
}

function text_format_message_maker() {
    #echo "imputed args: $@"
    text_format_function_args="$@"
    if [ -z "${text_format_function_args}" ]; then
        echo "Error, no options specified"
        text_format_short_help;
        exit 0;
    fi

    function setting_rgb_color() {
        # setting rgb color
        rgb_color_to_set="$1"
        if [ -n "$rgb_color_to_set" ] && [[ "$rgb_color_to_set" != -* ]]; then
            #echo "RGB color to set: $rgb_color_to_set"

            local rgb_color_red_num_set="$(echo $rgb_color_to_set | awk -F',' '{print $1}')"
            local rgb_color_green_num_set="$(echo $rgb_color_to_set | awk -F',' '{print $2}')"
            local rgb_color_blue_num_set="$(echo $rgb_color_to_set | awk -F',' '{print $3}')"

            function rgb_color_check() {
                # 24 bit RGB color check
                local number=$1
                # check if the number is inside 0-255
                if [ $number -ge 0 ] && [ $number -le 255 ]; then
                    echo "RGB color $number is a valid number" > /dev/null
                else
                    echo "ERROR: INVALID RGB number"
                    exit 1
                fi
            }
            rgb_color_check ${rgb_color_red_num_set}
            rgb_color_check ${rgb_color_green_num_set}
            rgb_color_check ${rgb_color_blue_num_set}

            r_value_color=${rgb_color_red_num_set}
            g_value_color=${rgb_color_green_num_set}
            b_value_color=${rgb_color_blue_num_set}

        else
            #echo 'error: RGB color not specified'
            local num_arg_errors=$(($num_arg_errors+1));
            exit 1
        fi
    }

    ## read CLI Args
    while [ -n "$1" ]; do
        if [ "$1" == "-h" ]; then
            text_format_short_help;
            exit 0;
        elif [ "$1" == "-H" ] || [ "$1" == "--help" ]; then
            text_format_full_help;
            exit 0;
        fi
        case $1 in
            ( "-fgc"|"--fgc"|"-foreground_color"|"--foreground_color" )
                if [ -n "$2" ] && [[ "$2" != -* ]]; then
                    case $2 in
                        ( [Ww][Hh][Ii][Tt][Ee] )
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_white}"
                            shift
                        ;;                    
                        ([Bb][Ll][Aa][Cc][Kk])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_black}"
                            shift
                        ;;
                        ([Rr][Ee][Dd])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_red}"
                            shift
                        ;;
                        ([Gg][Rr][Ee][Ee][Nn])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_green}"
                            shift
                        ;;
                        ([Yy][Ee][Ll][Ll][Oo][Ww])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_yellow}"
                            shift
                        ;;
                        ([Bb][Ll][Uu][Ee])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_blue}"
                            shift
                        ;;
                        ([Mm][Aa][Gg][Ee][Nn][Tt][Aa])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_magenta}"
                            shift
                        ;;
                        ([Cc][Yy][Aa][Nn])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_cyan}"
                            shift
                        ;;
                        ([Gg][Rr][Aa][Yy])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_gray}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Gg][Rr][Aa][Yy])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_bright_gray}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Rr][Ee][Dd])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_bright_red}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Gg][Rr][Ee][Ee][Nn])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_bright_green}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Yy][Ee][Ll][Ll][Oo][Ww])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_bright_yellow}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Bb][Ll][Uu][Ee])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_bright_blue}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Mm][Aa][Gg][Ee][Nn][Tt][Aa])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_bright_magenta}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Cc][Yy][Aa][Nn])
                            #echo "Foreground Color: $2"
                            local foreground_color_set="${text_fg_color_bright_cyan}"
                            shift
                        ;;
                        ([Uu][Nn][Dd][Ee][Rr][Ll][Ii][Nn][Ee]_[Rr][Gg][Bb])
                            shift
                            #echo "Foreground Color: $2"

                            setting_rgb_color "$2"

                            local text_style_underline_color_rgb="${csi_esc}58;2;${r_value_color};${g_value_color};${b_value_color}m" # 24-bit RGB 0-255 values set color

                            local foreground_color_set="${text_style_underline_color_rgb}"
                            shift
                        ;;
                        ([Rr][Gg][Bb])
                            shift
                            #echo "Foreground Color: $2"

                            setting_rgb_color "$2"

                            local text_fg_color_rgb="${csi_esc}38;2;${r_value_color};${g_value_color};${b_value_color}m" # 24-bit RGB 0-255 
                            local foreground_color_set="${text_fg_color_rgb}"
                            shift
                        ;;
                        ( * )
                            echo 'error: unrecognized "'$2'" color.'
                            local num_arg_errors=$(($num_arg_errors+1))
                        ;;
                    esac
                else
                    echo 'error: Foreground color not specified'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
                ;;
            ( "-bgc"|"--bgc"|"-background_color"|"--background_color" )
                if [ -n "$2" ] && [[ "$2" != -* ]]; then
                    case $2 in
                        ( [Ww][Hh][Ii][Tt][Ee] )
                            #echo "Background Color: $2"
                            background_color_set="${text_bg_color_white}"
                            shift
                        ;;
                        ([Bb][Ll][Aa][Cc][Kk])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_black}"
                            shift
                        ;;
                        ([Rr][Ee][Dd])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_red}"
                            shift
                        ;;
                        ([Gg][Rr][Ee][Ee][Nn])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_green}"
                            shift
                        ;;
                        ([Yy][Ee][Ll][Ll][Oo][Ww])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_yellow}"
                            shift
                        ;;
                        ([Bb][Ll][Uu][Ee])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_blue}"
                            shift
                        ;;
                        ([Mm][Aa][Gg][Ee][Nn][Tt][Aa])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_magenta}"
                            shift
                        ;;
                        ([Cc][Yy][Aa][Nn])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_cyan}"
                            shift
                        ;;
                        ([Gg][Rr][Aa][Yy])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_gray}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Gg][Rr][Aa][Yy])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_bright_gray}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Rr][Ee][Dd])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_bright_red}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Gg][Rr][Ee][Ee][Nn])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_bright_green}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Yy][Ee][Ll][Ll][Oo][Ww])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_bright_yellow}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Bb][Ll][Uu][Ee])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_bright_blue}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Mm][Aa][Gg][Ee][Nn][Tt][Aa])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_bright_magenta}"
                            shift
                        ;;
                        ([Bb][Rr][Ii][Gg][Hh][Tt]_[Cc][Yy][Aa][Nn])
                            #echo "Background Color: $2"
                            local background_color_set="${text_bg_color_bright_cyan}"
                            shift
                        ;;
                        ([Rr][Gg][Bb])
                            shift
                            #echo "Background Color: $2"

                            setting_rgb_color "$2"

                            local text_bg_color_rgb="${csi_esc}48;2;${r_value_color};${g_value_color};${b_value_color}m" # 24-bit RGB 0-255 values set color

                            local background_color_set="${text_bg_color_rgb}"
                            shift
                        ;;
                        ( * )
                            echo 'error: unrecognized "'$2'" color.'
                            local num_arg_errors=$(($num_arg_errors+1))
                        ;;
                    esac
                else
                    echo 'error: Background color not specified'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
                ;;
            ( "-es"|"--es"|"-enable_style"|"--enable_style" )
                if [ -n "$2" ] && [[ "$2" != -* ]]; then
                    case $2 in
                        ( [Rr][Ee][Ss][Ee][Tt] )
                            #echo "Style: $2"
                            local style_set="${text_style_reset}"
                            shift
                        ;;
                        ( [Bb][Oo][Ll][Dd] )
                            #echo "Style: $2"
                            local style_set="${text_style_bold}"
                            shift
                        ;;
                        ( [Ff][Aa][Ii][Nn][Tt] )
                            #echo "Style: $2"
                            local style_set="${text_style_faint}"
                            shift
                        ;;
                        ( [Ii][Tt][Aa][Ll][Ii][Cc] )
                            #echo "Style: $2"
                            local style_set="${text_style_italic}"
                            shift
                        ;;
                        ( [Uu][Nn][Dd][Ee][Rr][Ll][Ii][Nn][Ee] )
                            #echo "Style: $2"
                            local style_set="${text_style_underline}"
                            shift
                        ;;
                        ( [Oo][Vv][Ee][Rr][Ll][Ii][Nn][Ee] )
                            #echo "Style: $2"
                            local style_set="${text_style_overline}"
                            shift
                        ;;
                        ( [Ss][Ll][Oo][Ww]_[Bb][Ll][Ii][Nn][Kk] )
                            #echo "Style: $2"
                            local style_set="${text_style_slow_blink}"
                            shift
                        ;;
                        ( [Rr][Aa][Pp][Ii][Dd]_[Bb][Ll][Ii][Nn][Kk] )
                            #echo "Style: $2"
                            local style_set="${text_style_rapid_blink}"
                            shift
                        ;;
                        ( [Ii][Nn][Vv][Ee][Rr][Tt] )
                            #echo "Style: $2"
                            local style_set="${text_style_invert}"
                            shift
                        ;;
                        ( [Hh][Ii][Dd][Ee] )
                            #echo "Style: $2"
                            local style_set="${text_style_hide}"
                            shift
                        ;;
                        ( [Ss][Tt][Rr][Ii][Kk][Ee] )
                            #echo "Style: $2"
                            local style_set="${text_style_strike}"
                            shift
                        ;;
                        ( [Dd][Oo][Uu][Bb][Ll][Ee]_[Uu][Nn][Dd][Ee][Rr][Ll][Ii][Nn][Ee] )
                            #echo "Style: $2"
                            local style_set="${text_style_double_underline}"
                            shift
                        ;;
                        ( * )
                            echo 'error: unrecognized "'$2'" style.'
                            local num_arg_errors=$(($num_arg_errors+1))
                        ;;
                    esac
                else
                    echo 'error: Style not specified'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
                ;;
            ( "-ds"|"--ds"|"-disable_style"|"--disable_style" )
                if [ -n "$2" ] && [[ "$2" != -* ]]; then
                    case $2 in
                        ( [Bb][Oo][Ll][Dd] )
                            #echo "Disable Style: $2"
                            local style_off_set="${text_style_off_bold}"
                            shift
                        ;;
                        ( [Ii][Tt][Aa][Ll][Ii][Cc] )
                            #echo "Disable Style: $2"
                            local style_off_set="${text_style_off_italic}"
                            shift
                        ;;
                        ( [Uu][Nn][Dd][Ee][Rr][Ll][Ii][Nn][Ee] )
                            #echo "Disable Style: $2"
                            local style_off_set="${text_style_off_underline}"
                            shift
                        ;;
                        ( [Oo][Vv][Ee][Rr][Ll][Ii][Nn][Ee] )
                            #echo "Disable Style: $2"
                            local style_off_set="${text_style_off_overline}"
                            shift
                        ;;
                        ( [Bb][Ll][Ii][Nn][Kk] )
                            #echo "Disable Style: $2"
                            local style_off_set="${text_style_off_blink}"
                            shift
                        ;;
                        ( [Ii][Nn][Vv][Ee][Rr][Tt] )
                            #echo "Disable Style: $2"
                            local style_off_set="${text_style_off_invert}"
                            shift
                        ;;
                        ( [Hh][Ii][Dd][Ee] )
                            #echo "Disable Style: $2"
                            local style_off_set="${text_style_off_hide}"
                            shift
                        ;;
                        ( [Ss][Tt][Rr][Ii][Kk][Ee] )
                            #echo "Disable Style: $2"
                            local style_off_set="${text_style_off_strike}"
                            shift
                        ;;
                        ( * )
                            echo 'error: unrecognized "'$2'" style.'
                            local num_arg_errors=$(($num_arg_errors+1))
                        ;;
                    esac
                else
                    echo 'error: Style not specified'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
                ;;
            ( "-msg"|"--msg"|"-message"|"--message" )
                if [ -n "$2" ] && [[ "$2" != -* ]]; then
                    while [ -n "$2" ] && [[ "$2" != -* ]]; do
                        # This while loop ensure that the complete message is defined
                        # This is useful when using $* and not $@
                        if [ -n "${TRIGGER_MESSAGE_SET}" ] ; then
                            if [ -z "${message_set}" ]; then
                                local message_set="$2"
                                TRIGGER_MESSAGE_SET="1"
                            else
                                local message_set="${message_set} "
                                local message_set="${message_set}$2"
                                TRIGGER_MESSAGE_SET="1"
                            fi
                        else
                            local message_set="$2"
                            TRIGGER_MESSAGE_SET="1"
                        fi
                        #echo "Message: $message_set"
                        shift
                    done
                else
                    echo 'error: Message not specified'
                    local num_arg_errors=$(($num_arg_errors+1));
                fi
                ;;
            ( "-enrs"|"--enrs"|"-exit_not_reset_style"|"--exit_not_reset_style" )
                #echo "seted: exit not reset style"
                local exit_not_reset_style="yes"
                #shift
                ;;
            ( "-h" )
                text_format_short_help
                exit 0
                ;;
            ( "-H"|"--help" )
                text_format_full_help
                exit 0
                ;;
            ( * )
                echo "error: unknown option: $1"
                local num_arg_errors=$(($num_arg_errors+1));
            ;;
        esac
        shift

        maked_message="${maked_message}${foreground_color_set}${background_color_set}${style_set}${style_off_set}${message_set}"

        unset foreground_color_set
        unset background_color_set
        unset style_set
        unset style_off_set
        unset message_set

    done

    if [[ -n "$num_arg_errors" ]]; then
        echo "error: $num_arg_errors invalid arguments"
        exit 1;    
    fi


    # check if you should reset the formatting when exiting the command
    if [ -n ${exit_not_reset_style} ]; then
        # some value is seted to ${exit_not_reset_style}
        if [ "yes" == "${exit_not_reset_style}" ]; then
            #echo "text style reset seted value: yes"
            local exit_style=''
            # output the maked message
            #echo -e "${maked_message}${exit_style}"
        #else
        #    echo "ERROR: text style reset value unrecognized"
        #    exit 1;
        fi
    else
        # check if message is defined, if yes, set to reset style when exiting the command
        if [ -n "${TRIGGER_MESSAGE_SET}" ]; then
            local exit_style="${text_style_reset}"
            # output the maked message
            #echo -e "${maked_message}${exit_style}"
        else
            local exit_style=''
            # output the maked message
            #echo -e "${maked_message}${exit_style}"
        fi
    fi

    # output the maked message
    echo -en "${maked_message}${exit_style}"
    exit 0
}

text_format_message_maker "$@"
