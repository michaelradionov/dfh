#!/bin/bash

# Full House – Disk free space monitor written in Bash
# https://github.com/michaelradionov/dfh

# Variables
  SCRIPT_NAME="dfh"
  SCRIPTS_FOLDER=~/.gg_tools
  DEFAULT_DISK_SPACE_ALERT_PERCENTAGE=90
  DEFAULT_PATH=.

# Colors
  L_RED='\033[1;31m'
  YELLOW='\033[1;33m'
  WHITE='\033[1;37m'
  D_GREY='\033[1;30m'
  D_VIOL='\033[1;34m'
  NC='\033[0m'



dfh(){

###################################################
# Processing input parameters
###################################################

while [ -n "$1" ]
do
  case "$1" in

  "-h")
  echo "Usage: dfh [-d <website_path_where_env_is> | -sw <slack_channel_url>] [-sс <slack_channel>] [-l <disk_space_alert_percentage>]"
  return
  ;;

  "-d")

    if [ -z "$2" ]; then
       echo -e "${L_RED}You must specify website path on disk when using the \"-d\" flag!${NC}"
       return
    fi

    WEBSITE_PATH=$2
    shift # Getting rid of <d> parameter
  ;;


  "-l")

    if [ -z "$2" ]; then
       echo -e "${L_RED}You must specify disk space alert percentage when using the \"-l\" flag!${NC}"
       return
    fi

    DISK_SPACE_ALERT_PERCENTAGE=$2
    shift # Getting rid of <l> parameter
  ;;

  "-sw")

    if [ -z "$2" ]; then
       echo -e "${L_RED}You must specify Slack Webhoock URL when using the \"-sw\" flag!${NC}"
       return
    fi

    LOG_SLACK_WEBHOOK_URL=$2
    shift # Getting rid of <sw> parameter
  ;;

  "-sc")

    if [ -z "$2" ]; then
       echo -e "${L_RED}You must specify Slack channel when using the \"-sc flag!${NC}"
       return
    fi

    LOG_SLACK_CHANNEL=$2
    shift # Getting rid of <sc> parameter
  ;;

  esac
shift
done

###################################################
# Processing exceptions
###################################################

#   If both Slack webhook either path isn't set
    if [ -z "$LOG_SLACK_WEBHOOK_URL" ]; then
#        Trying to get Slack Webhook from .env
        if [ -f "${WEBSITE_PATH}/.env" ]; then
            echo -e "Found .env in ${WEBSITE_PATH}/.env. Sourcing ..."
            source "${WEBSITE_PATH}/.env"
            if [ -z $LOG_SLACK_WEBHOOK_URL ]; then
              echo -e "${L_RED}There is no LOG_SLACK_WEBHOOK_URL variable in .env. Please specify -sw or -d parameter. See dfh -h${NC}"
              return
            fi
          else
            echo -e "${L_RED}Can't find .env file in given path to get Slack webhook URL... Please specify -sw or -d parameter. See dfh -h${NC}"
            return
        fi
    fi
#    If limit isn't set
    if [ -z "$WEBSITE_PATH" ]; then
        WEBSITE_PATH=$DEFAULT_PATH
    fi

#    If path isn't set
    if [ -z "$DISK_SPACE_ALERT_PERCENTAGE" ]; then
        DISK_SPACE_ALERT_PERCENTAGE=$DEFAULT_DISK_SPACE_ALERT_PERCENTAGE
    fi

###################################################
# Main logic
###################################################

  FREE_SPACE=$(df -H "$WEBSITE_PATH" | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5  }' | cut -d'%' -f1)

  if [ "$FREE_SPACE" -ge "$DISK_SPACE_ALERT_PERCENTAGE" ]; then
    MESSAGE="$(hostname): Disk space usage is ${FREE_SPACE}%. Limit of ${DISK_SPACE_ALERT_PERCENTAGE}% exceeded!"
    echo -e "${L_RED}${MESSAGE}${NC}"

#    Sending to SLack
    curl -X POST --data-urlencode "payload={\"channel\": \"${LOG_SLACK_CHANNEL}\", \"username\": \"Disk Space Monitoring Bot\", \"text\": \"${MESSAGE}\", \"icon_emoji\": \":admin:\"}" "$LOG_SLACK_WEBHOOK_URL"
    else
      echo "Disk space usage is ${FREE_SPACE}% and limit is ${DISK_SPACE_ALERT_PERCENTAGE}%. It's allright here!"
  fi
}
