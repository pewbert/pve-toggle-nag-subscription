#!/bin/zsh
#variables
str="res.data.status.toLowerCase()"
filepath="/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js"
filename=$filepath:t:r
#conditionals
if [[ -f "$filepath" ]]; then
        line=$(cat $filepath | grep -m 1 -n $str | cut -d: -f1)
        sed -n ${line},+3p $filepath
        echo "toggle nag message? (yes|no)"
        read ans
        if [[ ${ans:l} == y* ]]; then
                #backup file first
                cp --backup=t $filepath ~/scripts/${filename}.js
                tgt=$(sed -n ${line}p $filepath)
                if [[ $tgt = *"${str} !=="* ]]; then
                        sed -i ${line}s/!==/==/ $filepath
                elif [[ $tgt = *"${str} =="* ]]; then
                        sed -i ${line}s/==/!==/ $filepath
                else
                        echo "target: $tgt"
                fi
        fi
else
        echo "error: $filepath not found"
fi
cat -n $filepath | sed -n ${line}p
