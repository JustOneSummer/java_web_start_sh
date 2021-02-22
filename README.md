# java_web_start_sh
Java服务启动脚本

- 把脚本文件改为可执行
- chmod +x java_start.sh
- 注册到chkconfig
- chkconfig --add java_start.sh
- chkconfig java_start.sh on
- service 启动一次
- service java_start.sh start 
- 刷新systemctl
- systemctl daemon-reload
- service 关闭
- service java_start.sh stop
- 下面就可以用 systemctl管理服务了(.sh可以去掉)
- systemctl start java_start.sh.service
