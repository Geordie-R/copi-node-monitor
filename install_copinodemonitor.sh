#!/bin/bash
#######################################################
#██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗
#██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║
#██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║
#██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║
#██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
#╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝
#######################################################

sudo apt update
#Install JQ to read JSON
sudo apt-get install jq

create_dir="$HOME/stafi-stats" #FIX THIS
config_file="$create_dir/config.ini" # FIX THIS
not_setup=0

#----------------------------------------------------------------------------------------------------#
# GLOBAL VALUE IS USED AS A GLOBAL VARIABLE TO RETURN THE RESULT                                     #
#----------------------------------------------------------------------------------------------------#

function get_config_value(){
  global_value=$(grep -v '^#' "$config_file" | grep "^$1=" | awk -F '=' '{print $2}')
  if [ -z "$global_value" ]
  then
    return 1
  else
    return 0
  fi
}

#----------------------------------------------------------------------------------------------------#
# CREATE THE DIRECTORY IF IT DOES NOT EXIST                                                          #
#----------------------------------------------------------------------------------------------------#

if [ ! -d "$create_dir" ]
then
  mkdir -p "$create_dir"
fi

#----------------------------------------------------------------------------------------------------#
# CREATE CONFIG FILE IF IT DOESN'T EXIST                                                             #
#----------------------------------------------------------------------------------------------------#

if [ ! -f "$config_file" ]
then
  echo "#Configuration file for the copi node monitor script" > "$config_file"
  echo "#Make the entries as variable=value" >> "$config_file"
  echo " " >> "$config_file"
fi

#telegram_bot_token="$(grep -v '^#' "$config_file" | grep '^ telegram_bottoken=' | awk -F '=' '{print $2}')"
#telegram_chat_id="$(grep -v '^#' "$config_file" | grep '^ telegram_chatid=' | awk -F '=' '{print $2}')"

#----------------------------------------------------------------------------------------------------#
# GET TELEGRAM BOT TOKEN FROM THE USER OR TAKE IT FROM THE CONFIG FILE                                   #
#----------------------------------------------------------------------------------------------------#

  if get_config_value telegram_bot_token
  then
    telegram_bot_token="$global_value"
  else
    not_setup=1
    read -p "COPY AND PASTE YOUR TELEGRAM BOT TOKEN: " -e telegram_bot_token
    echo "telegram_bot_token=$telegram_bot_token" >> "$config_file"
    echo
  fi

#----------------------------------------------------------------------------------------------------#
# GET TELEGRAM CHAT ID FROM THE USER OR TAKE IT FROM THE CONFIG FILE                                 #
#----------------------------------------------------------------------------------------------------#

  if get_config_value telegram_chat_id
  then
    telegram_chat_id="$global_value"
  else
    not_setup=1
    read -p "COPY AND PASTE YOUR TELEGRAM CHAT ID YOU GOT FROM @STAFICHATIDBOT ON TELEGRAM: " -e telegram_chat_id
    echo "telegram_chat_id=$telegram_chat_id" >> "$config_file"
    echo
  fi

#----------------------------------------------------------------------------------------------------#
# GET NODE NAME FROM THE USER OR TAKE IT FROM THE CONFIG FILE                                 #
#----------------------------------------------------------------------------------------------------#

  if get_config_value node_name
  then
    node_name="$global_value"
  else
    not_setup=1
    read -p "TYPE THE NAME OF YOUR NODE ITS JUST A LABEL: " -e node_name
    echo "node_name=$node_name" >> "$config_file"
    echo
  fi

#----------------------------------------------------------------------------------------------------#
# GET MAXIMUM DISKSPACE PERCENT OR TAKE IT FROM THE CONFIG FILE                                 #
#----------------------------------------------------------------------------------------------------#

  if get_config_value disk_max_percent
  then
    disk_max_percent="$global_value"
  else
    not_setup=1
    read -p "WHAT IS THE MAXIMUM USED DISK SPACE PERCENTAGE YOU WILL ALLOW BEFORE BEING NOTIFIED e.g.IF IT IS 80% FULL YOU WOULD WRITE 80: " -e disk_max_percent
    echo "disk_max_percent=$disk_max_percent" >> "$config_file"
    echo
  fi


#----------------------------------------------------------------------------------------------------#
# WHAT IS THE MAXIMUM CPU PERCENTAGE YOU WISH TO ALLOW BEFORE BEING NOTIFIED?
#----------------------------------------------------------------------------------------------------#

  if get_config_value cpu_max_percent
  then
    cpu_max_percent="$global_value"
  else
    not_setup=1
    read -p "WHAT IS THE MAXIMUM CPU PERCENTAGE YOU WISH TO ALLOW BEFORE BEING NOTIFIED? e.g. 85: " -e cpu_max_percent
    echo "cpu_max_percent=$cpu_max_percent" >> "$config_file"
    echo
  fi

#----------------------------------------------------------------------------------------------------#
# WHAT IS THE MAXIMUM MEMORY USED PERCENTAGE YOU WISH TO ALLOW BEFORE BEING NOTIFIED?
#----------------------------------------------------------------------------------------------------#

  if get_config_value memory_max_percent
  then
    memory_max_percent="$global_value"
  else
    not_setup=1
    read -p "WHAT IS THE MAXIMUM MEMORY USED PERCENTAGE YOU WISH TO ALLOW BEFORE BEING NOTIFIED? e.g. 85: " -e memory_max_percent
    echo "memory_max_percent=$memory_max_percent" >> "$config_file"
    echo
  fi

#----------------------------------------------------------------------------------------------------#
# ADD CRONJOB IF IT DOESNT EXIST FOR EVERY 5 MINUTES
# Note: to remove or modify the cronjob/scheduled task use crontab -e outside of this script
#----------------------------------------------------------------------------------------------------#

cronexists=$(crontab -l | grep -q 'copi-node-monitor.sh'  && echo '1' || echo '0')

if [[ $cronexists -eq 0 ]];
then
  run_file="$create_dir/stats.sh"
  (crontab -l 2>/dev/null; echo "*/15 * * * * $run_file") | crontab -
  echo "Added cron job to schedule the running of stats.sh every 15 minutes. Use crontab -e to view or amend"
fi




if [[ $not_setup -eq 0 ]];
then
  echo "It looks like everything is already setup.  If you wish to view the config or change values run the command: nano $config_file"
fi
