#!/bin/sh
# chkconfig: 2345 56 26
# description: java Service

### BEGIN INIT INFO
# Provides:          java-web
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts java-web
# Description:       starts the java-web
### END INIT INFO

JAVA_HOME="/home/uuz/test/jdk-17.0.2"
export JAVA_HOME
PATH="$JAVA_HOME/bin:$PATH"
export PATH

java -version

echo "start server...."

# system path
#SYSTEM_PATH=$(dirname $(readlink -f "$0"))
SYSTEM_PATH="/home/uuz/test"

# jar name
PROJECT_NAME="system-web-0.0.1-SNAPSHOT.jar"
echo $SYSTEM_PATH

pid_file="$SYSTEM_PATH/$PROJECT_NAME".pid

function java_start() {
    nohup java -jar "$SYSTEM_PATH/$PROJECT_NAME" --spring.config.location="$SYSTEM_PATH"/config/application.yml >/dev/null 2>&1 &

    #nohup java -jar "$SYSTEM_PATH/$PROJECT_NAME" --spring.config.location="$SYSTEM_PATH"/config/application.yml >"$SYSTEM_PATH"/log.log &

    #jdk-version<=1.8 -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
    #java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 -jar "$SYSTEM_PATH/$PROJECT_NAME" --spring.config.location="$SYSTEM_PATH"/config/application.yml

    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        echo $! > ${pid_file}
    else exit 1
    fi
}


function java_stop() {
    # shellcheck disable=SC2046
    kill -9 $(cat ${pid_file})
    # shellcheck disable=SC2181
    if [[ $? -eq 0 ]]; then
        rm -f ${pid_file}
    else exit 1
    fi
    echo "java stop ok"
}

case "$1" in
	start)
		java_start
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
		java_start
		;;
	*)
		echo "Please use start or stop as first argument"
		;;
esac
