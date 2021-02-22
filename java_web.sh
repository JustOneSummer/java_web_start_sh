#!/bin/bash
# chkconfig: 2345 60 15
# description:auto_run

currenttime=$(date +%Y%m%d)
project_path="/web/http/am/"
jarName="web.jar"

springbootConfig="${project_path}/config/application.yml"
jarfile="${project_path}${jarName}"
logfile="${jarfile}_${currenttime}.log"
command="java -jar ${jarfile} --spring.config.location=${springbootConfig}"

if [ "springbootConfig" == ""]; then
    command = "java -jar ${jarfile}"
fi

echo "cmd $1"

case "$1" in
    start)
        echo "INFO: Starting $jarfile ..."
        exec nohup $command > $logfile 2>&1 &
    ;;

    stop)
        echo "INFO: stopping $jarfile ..."
        ps -ef | grep "$command" | awk '{print $2}' | while read pid
        do
            C_PID=$(ps --no-heading $pid | wc -l)
            if [ "$C_PID" == "1" ]; then
                echo "INFO: process(PID=$pid) end!"
                exec kill -9 $pid
            else
                echo "WARN: process(PID=$pid) does not exist!"
            fi
        done
        echo "INFO: $jarfile stopped!"
    ;;

esac
