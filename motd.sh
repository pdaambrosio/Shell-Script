#!/bin/bash

human=1024
phys_mem=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
used_mem=$(awk '/^Cached/ {print $2}' /proc/meminfo)
total=$((${phys_mem} / $human))
used=$((${used_mem} / $human))
Hostname=$(tput setaf 1; echo Hostname:; tput sgr0; hostname)
OS=$(tput setaf 1; echo OS:; tput sgr0; uname -o)
Ker=$(tput setaf 1; echo Kernel:; tput sgr0; uname -srm)
Up=$(tput setaf 1; echo Uptime:; tput sgr0; uptime)
CPU=$(tput setaf 1; echo CPU:; tput sgr0; awk 'BEGIN{FS=":"} /model name/ {print $2; exit}' /proc/cpuinfo | awk 'BEGIN{FS=" @"; OFS="\n"} {print $1; exit}')
RAM=$(tput setaf 1; echo RAM Total:; tput sgr0)
IP01=$(tput setaf 1; echo wlan0:; tput sgr0; ip addr |grep wlan0 |grep "inet" |awk '{print$2}')
#IP02=$(tput setaf 1; echo eth0:; tput sgr0; ip addr |grep eth0 |grep "inet" |awk '{print$2}')

echo "
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⠶⠿⠿⠿⠿⠿⠿⠿⠿⠿⢿⣿⠿⠿⠿⠷⠶⠶⢶⣶⣶⣶⣤⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⢀⣶⠟⠁⠀⠀⠀⠀⣀⠤⠒⠉⣁⣀⠤⠤⠤⠤⠤⠄⣀⣀⡉⠉⠉⠉⠉⢉⣉⣉⣉⣉⣛⠛⢷⣦⣄⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⣠⡿⠁⠀⠀⢀⠤⠚⣁⠔⣚⡥⠐⠒⠒⠒⠒⠒⠲⡂⠀⠀⠀⠀⠀⠀⣀⡤⠤⠤⠤⠤⣄⠀⠀⠀⠀⠙⢿⣦⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⣴⡟⠀⠀⠀⠈⠀⠤⢉⠔⠉⠀⠀⢀⣀⣀⣀⠀⠀⠀⠹⠀⠀⠀⠀⠀⠀⣠⠀⠀⠀⠀⠀⠀⠈⢦⠀⠀⠀⠀⣿⡄⠀⠀⠀
    ⠀⠀⠀⣠⣾⠟⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⢿⣿⣿⣿⣿⠉⠛⠻⣶⣄⠀⠀⠀⠀⠀⠀⠘⣀⣤⣤⣶⣶⣦⣤⠀⠀⠀⠀⠀⠘⣿⣤⠀⠀
    ⠀⣤⡿⡯⠋⠉⣉⣭⣤⣤⣄⠉⠡⠀⠛⠛⠛⠛⢉⣽⠛⠛⠿⣶⣤⣿⠃⠀⠀⠀⠲⣶⣿⣿⠿⠛⠛⠛⠛⠛⠁⠉⠉⠉⠉⡙⠦⡉⢿⣦
    ⣾⠋⣼⠀⣠⡿⠋⠀⢠⣄⠉⠛⠻⢷⣶⣶⣶⠿⠛⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⣠⣄⣀⣤⣶⠿⠿⢷⣤⢻⠀⡆⣿
    ⣿⠀⣿⠀⣿⠀⣀⣤⣿⠛⢿⣶⣤⣀⠀⠀⠀⠀⢀⣀⣀⣀⠆⣤⣶⣦⠀⠀⠀⠀⠀⠀⠙⠻⣶⣄⠀⠀⠉⠉⠉⠀⣾⠀⠀⠀⣸⠀⢇⣿
    ⣿⣄⠹⠀⢻⣇⠀⠀⢻⣷⡀⠀⠈⠛⣿⣷⣶⣤⣄⣀⠀⠀⠘⣿⡄⢶⠷⠶⠶⠀⠀⠀⠀⣤⡿⠛⠛⠒⠤⡀⠀⣠⣿⣿⠀⣀⠤⢚⣿⠋
    ⠀⠻⣷⣌⠓⠀⠀⠀⠀⠻⣿⠿⣶⣤⣿⣦⠀⠀⠉⠉⠛⢿⣷⣶⣤⣤⣄⣀⣀⢀⠙⠛⠛⠉⠀⠀⣀⣠⣤⣶⣿⡟⣿⣿⡆⠀⠀⣿⠃⠀
    ⠀⠀⠈⠻⣷⡀⠀⠀⠀⠀⠉⢿⣄⠈⣿⡿⣿⣿⣶⣦⣤⣿⡇⠀⠀⠀⠀⠙⣿⠋⠛⠛⢻⣿⠛⠛⠉⢻⣧⠀⣸⣧⣼⣿⡇⠀⢸⣿⠀⠀
    ⠀⠀⠀⠀⠉⣿⡄⠀⠀⠀⠀⠀⠙⣷⣿⠁⠀⠀⠉⠙⢻⣿⢿⣿⣿⣷⣶⣶⣿⣶⣶⣶⣾⣿⣶⣶⣷⣿⣿⣿⣿⣿⣿⣿⠇⠀⢸⣿⠀⠀
    ⠀⠀⠀⠀⠀⠈⢿⣦⠀⠀⠀⠀⠀⠀⠉⠻⣶⣄⠀⠀⣿⠏⠀⠀⠀⠉⠙⣿⠛⠛⠿⠿⣿⣿⣿⣿⣿⣿⠿⣿⠟⣿⢯⣿⠀⠀⢸⣿⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠉⠻⣦⣀⠢⣄⠀⠀⣄⠀⠉⠛⠿⣿⣤⣄⣀⠀⠀⢀⣿⠀⠀⠀⢀⣿⠀⠀⣴⡿⠀⣾⣏⣤⣿⠿⠁⠀⠀⢸⣿⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠿⣶⣤⡉⠒⢤⣉⠒⠤⣄⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠋⠉⠁⢀⠀⠀⠀⠀⠈⣿⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⣶⣤⣄⠉⠒⠠⠭⣁⣒⠠⠤⠤⠤⣄⣀⣀⣀⣀⣀⣀⣀⣀⣠⠤⠒⠁⠀⣀⠞⠀⠀⣿⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠿⣶⣤⣀⠀⠀⠈⠉⠉⠀⠒⠒⠒⠀⠀⠐⠀⠠⠠⠠⠀⠒⠉⠀⠀⠀⣠⣿⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠿⣶⣶⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⠟⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠛⠛⠛⠛⠓⠒⠒⠒⠒⠛⠛⠛⠉⠀⠀⠀⠀⠀⠀

                                       .___       
                            ______   __| _/____   
                            \____ \ / __ |\__  \  
                            |  |_> > /_/ | / __ \_
                            |   __/\____ |(____  /
                            |__|        \/     \/  
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

echo $Hostname
echo $OS
echo $Ker
echo $Up
echo $CPU
echo $RAM ${total}MB "| Used:" ${used}MB
echo $IP01