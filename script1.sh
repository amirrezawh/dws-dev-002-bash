#!/bin/bash


if [ $1 != "try" ];then
    echo "There is no try parameter"
    exit 1
else
    shift 1
fi


while true; do
    case "$1" in
        -i)
            INTERVAL=$2
            shift 2
            ;;
        -n)
            NUMBER=$2
            shift 2
            ;;
        *)
            COMMAND=$@
            for (( i=1; i<=$NUMBER; i++ )); do
                ($@)
                STATUS=$?
                
                if [[ $i == $NUMBER ]]; then
                    if [[ $STATUS == 0 ]]; then
                        exit 0
                    else
                        echo "Couldn't run command..." >&2
                        exit 1
                    fi
                fi
                sleep $INTERVAL
            done
            exit 0
            ;;
    esac
done