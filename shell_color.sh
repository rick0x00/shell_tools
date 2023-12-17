#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 12 dez 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: shell_color                                       #
# Description: basic shell text color/style edit               #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #

# base: https://en.wikipedia.org/wiki/ANSI_escape_code

### Control Sequence Introducer, or CSI, commands, the ESC(ANSI escape sequences)
csi_esc="\e["
csi_esc="\033["

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
g_value_color="0"
b_value_color="0"
text_style_underline_color_rgb="${csi_esc}58;2;${r_value_color};${g_value_color};${b_value_color}m" # 24-bit RGB 0-255 values set color
text_style_underline_color_24bit="${text_style_underline_color_rgb}"

text_style_off_underline_color="${csi_esc}59m" # turn off underline color



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



### message
text_msg="lorem ipsum dolor sit amet"

echo -e " ${text_bg_color_bright_green} ${text_msg} ${csi_esc}102m ${text_msg} ${text_style_reset}"