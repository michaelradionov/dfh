#!/bin/bash

# Full House – Disk free space monitor written in Bash
# https://github.com/michaelradionov/full_house

# Variables
  SCRIPT_NAME="full_house"
  SCRIPTS_FOLDER=~/.gg_tools

# Colors
  L_RED='\033[1;31m'
  YELLOW='\033[1;33m'
  WHITE='\033[1;37m'
  D_GREY='\033[1;30m'
  D_VIOL='\033[1;34m'
  NC='\033[0m'

###################################################
# Common functions
###################################################

check_command_exec_status () {
  if [[ $1 -eq 0 ]]
    then
      echo -e "${YELLOW}Success!${NC}"
      echo
  else
    echo -e "${L_RED}ERROR${NC}"
    echo
  fi
}

title(){
    echo -e "${D_VIOL}$1${NC}"
}

showdelimiter(){
        echo
        echo '-------------------'
        echo
}

###################################################
# Main logic
###################################################

full_house(){
  df -h .
}
