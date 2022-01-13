#! /bin/sh
### BEGIN INIT INFO
# Provides:		monitoring-system
# Required-Start:	$syslog $remote_fs
# Required-Stop:	$syslog $remote_fs
# Should-Start:		$local_fs
# Should-Stop:		$local_fs
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	monitoring-system
# Description:		monitoring-system
### END INIT INFO
echo "start server...."

#SYSTEM_PATH=$(dirname $(readlink -f "$0"))
SYSTEM_PATH="/web_zdm"
JAVA_PATH="jdk-11.0.13/bin/java"
PROJECT_NAME="AutoExtinguish.jar"
echo $SYSTEM_PATH

#nohup "$SYSTEM_PATH/$JAVA_PATH" -jar "$SYSTEM_PATH/$PROJECT_NAME" --spring.config.location="$SYSTEM_PATH"/config/application.yml >/dev/null 2>&1 &

# nohup run log
nohup "$SYSTEM_PATH/$JAVA_PATH" -jar "$SYSTEM_PATH/$PROJECT_NAME" --spring.config.location="$SYSTEM_PATH"/config/application.yml >"$SYSTEM_PATH"/log.log &

# no nohup run
#"$SYSTEM_PATH/$JAVA_PATH" -jar "$SYSTEM_PATH/$PROJECT_NAME" --spring.config.location="$SYSTEM_PATH"/config/application.yml

# test run
#"$SYSTEM_PATH/$JAVA_PATH" -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 -jar "$SYSTEM_PATH/$PROJECT_NAME"

