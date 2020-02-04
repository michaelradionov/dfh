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
# Main logic
###################################################

full_house(){
  DIR=.
  FREE_SPACE=$(df -H "$DIR" | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5  }' | cut -d'%' -f1)
  echo $FREE_SPACE
}
