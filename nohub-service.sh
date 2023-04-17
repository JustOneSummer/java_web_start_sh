#!/bin/bash

# system path
#SYSTEM_PATH=$(dirname $(readlink -f "$0"))
SYSTEM_PATH="/root/proxy/glider_0.16.3_linux_amd64"
CMD_STR="./glider -config $SYSTEM_PATH/config/glider.conf"
echo "start service...."

echo $SYSTEM_PATH

pid_file="glider".pid

function dev() {
    $CMD_STR
    service_start
}

function noHupLog() {
    nohup $CMD_STR >"$SYSTEM_PATH"/log.log &
    service_start
}

function noHupNoLog() {
    nohup $CMD_STR >/dev/null 2>&1 &
    service_start
}

function service_start() {
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        echo $! > ${pid_file}
    else exit 1
    fi
}


function service_stop() {
    # shellcheck disable=SC2046
    kill -9 $(cat ${pid_file})
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        rm -f ${pid_file}
    else exit 1
    fi
    echo "service stop ok"
}

case "$1" in
  dev)
    dev
    ;;
  log)
    noHupLog
    ;;
	start)
		noHupNoLog
		;;
	stop)
		service_stop
		;;
	status)
		redis_status
		;;
	restart|reload)
		service_stop
		sleep 1
		noHupNoLog
		;;
	*)
		echo "Please use start or stop as first argument"
		;;
esac
