# java-project-system.sh
修改.sh文件里面的参数
SYSTEM_PATH="jar包路径"
JAVA_PATH="JDK路径定位到bin里面的java"
PROJECT_NAME="jar包名称"

软链接.sh文件到 `/etc/init.d`

`sudo ln -s 你的.sh文件绝对路径 /etc/init.d`

添加到开启自启

`sudo update-rc.d java-project-system.sh defaults`

最后重启系统检查是否超过自启即可

### 最新修改

提供了三种启动方式,两种nohup一种远程调试的,自己根据情况去掉注释就行了

启动方式也改了,现在是 *.sh start|stop|restart|reload

### 修改可执行
chmod +x xxx.sh
