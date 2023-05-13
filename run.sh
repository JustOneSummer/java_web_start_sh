#!/bin/bash
# system path
#ROOT_PATH=$(dirname $(readlink -f "$0"))
ROOT_PATH="/root/wows"
JDK_NAME="jdk-20.0.1"
JAR_NAME="api-wows-0.0.1-SNAPSHOT.jar"
CONFIG_PATH="--spring.config.location="$ROOT_PATH"/config/application.properties"


JAVA_HOME="$ROOT_PATH/$JDK_NAME"
export JAVA_HOME
PATH="$JAVA_HOME/bin:$PATH"
export PATH

java -version

echo "start server...."

echo $ROOT_PATH

pid_file="$ROOT_PATH/$JAR_NAME".pid

function dev() {
    java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 -jar "$ROOT_PATH/$JAR_NAME" "$CONFIG_PATH"
    java_start
}

function noHupLog() {
    nohup java -jar "$ROOT_PATH/$JAR_NAME" "$CONFIG_PATH" >"$ROOT_PATH"/log.log &
    java_start
}

function noHupNoLog() {
    nohup java -jar "$ROOT_PATH/$JAR_NAME" "$CONFIG_PATH" >/dev/null 2>&1 &
    java_start
}

function java_start() {
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        echo $! > ${pid_file}
    else exit 1
    fi
}


function java_stop() {
    # shellcheck disable=SC2046
    # kill -9 $(cat ${pid_file})
    kill $(cat ${pid_file})
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        rm -f ${pid_file}
    else exit 1
    fi
    echo "java stop ok"
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
		java_stop
		;;
	status)
		redis_status
		;;
	restart|reload)
		java_stop
		sleep 1
		noHupNoLog
		;;
	*)
		echo "Please use start or stop as first argument"
		;;
esac
