# java-project-system.sh
修改.sh文件里面的参数
SYSTEM_PATH="jar包路径"
JAVA_PATH="JDK路径定位到bin里面的java"
PROJECT_NAME="jar包名称"

软链接.sh文件到 `/etc/init.d`

`sudo ln -s 你的.sh文件路径 /etc/init.d`

添加到开启自启

`sudo update-rc.d java-project-system.sh defaults`

最后重启系统检查是否超过自启即可

# java_web_start_sh(已弃用)
Java服务启动脚本

- 把脚本文件改为可执行
- - chmod +rx java_start.sh
- 注册到chkconfig
- - chkconfig --add java_start.sh
- - chkconfig java_start.sh on
- service 启动一次
- - service java_start.sh start 
- 刷新systemctl
- - systemctl daemon-reload
- service 关闭
- - service java_start.sh stop
- 下面就可以用 systemctl管理服务了(.sh可以去掉)
- - systemctl start java_start.sh.service
### 脚本内容修改
- project_path是项目绝对路径
- jarName是你jar包名称
- springbootConfig是你spring项目配置文件路径(project_path路径+相对路径)，如果是内置那就设置为""
