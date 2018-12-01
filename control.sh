#!/bin/bash
source env.properties
if [ $? -ne 0 ];then
    echo "[ERROR] Source env.properties failed"
    exit -1
fi

if [ -z "$PROJECT" ]
then
    echo "[ERROR] PORJECT is empty"
    exit 1
fi

if [ -z "$MODULE" ]
then
    echo "[ERROR] MODULE is empty"
    exit 1
fi

case "$1" in
    start)
        echo "[INFO] Start command: $START_CMD"
        eval $START_CMD
        sleep 1
        pid=`ps -ef|grep $PROJECT-$MODULE|grep -v grep|grep -v "\.sh"|awk '{print $2}'`
        if [ "$pid" == "" ]; then
            echo "[ERROR] $PROJECT-$MODULE start failed"
            exit 1
        else
            echo "[INFO] $PROJECT-$MODULE start success, Pid:$pid"
        fi
        ;;
    stop)
        pid=`ps -ef|grep $PROJECT-$MODULE|grep -v grep|grep -v "\.sh"|awk '{print $2}'`
        if [ "$pid" == "" ];then
            echo "[INFO] Service $PROJECT-$MODULE not exist or stop success"
        else
            echo "[INFO] Service $PROJECT-$MODULE pid is $pid"
            echo "[INFO] Killing $PROJECT-$MODULE ......"
            kill $pid
            sleep 5
            pid=`ps -ef|grep $PROJECT-$MODULE|grep -v grep|grep -v "\.sh"|awk '{print $2}'`
            if [ "$pid" == "" ]; then
                echo "[INFO] Stop service $PROJECT-$MODULE success"
            else
                echo "[WARN] Stop service $PROJECT-$MODULE failed"
                echo "[INFO] Start force killing ......"
                kill -9 $pid
            fi
        fi
        ;;
    restart)
        $0 stop
        sleep 2
        $0 start
        echo "[INFO] Service $PROJECT-$MODULE restarted"
        ;;
esac
