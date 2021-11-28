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
            if [ ! -n "$INTERVAL" ];then
                if [ ! -n "$TRY_INTERVAL" ]; then
                    INTERVAL=5
                else
                    INTERVAL=$TRY_INTERVAL
                fi
                
            fi
            if [ ! -n "$NUMBER" ];then
                if [ ! -n "$TRY_NUMBER" ]; then
                    NUMBER=12
                else
                    NUMBER=$TRY_NUMBER
                fi
                
            fi
            if [ ! -n "$COMMAND" ];then
                if [ ! -n "$TRY_COMMAND" ]; then
                    echo "There is no command in parameters or env..." >&2
                    exit 1
                else
                    COMMAND=$TRY_COMMAND
                fi
                
            fi            
            for (( i=1; i<=$NUMBER; i++ )); do
                ($COMMAND)
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