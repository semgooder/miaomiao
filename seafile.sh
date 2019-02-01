＃！/斌/庆典
＃ ###############一键安装Seafile脚本##################
＃作者：xiaoz.me
＃更新：2017-12-06
＃ ###################### END #######################

＃防火墙放行端口
function  chk_firewall（） {
	if [ -e  “ / etc / sysconfig / iptables ” ]
	然后
		iptables -I INPUT -p tcp --dport 8000 -j ACCEPT
		iptables -I INPUT -p tcp --dport 8082 -j ACCEPT
		服务iptables保存
		service iptables restart
	其他
		firewall-cmd --zone = public --add-port = 8000 / tcp --permanent
		firewall-cmd --zone = public --add-port = 8082 / tcp --permanent
		firewall-cmd --reload
	科幻
}

＃安装seafile函数
function  install_sea（） {
	cd / home / MyCloud
	＃下载安装包6.2.9 64bit
	wget https://download.seafile.com/seafhttp/files/c1e37829-88d9-4d13-a833-1b0f35cce282/seafile-pro-server_6.3.11_x86-64.tar.gz
	＃解压
	tar -zxvf seafile-pro-server_6.2.9_x86-64.tar.gz	
	mkdir已安装
	mv seafile-pro-server * .tar.gz ./installed
	mv seafile-pro-server-6 * seafile-server
	＃安装依赖环境
	yum -y install python-setuptools python-imaging python-ldap MySQL-python python-memcached python-urllib3
	＃进行安装
	cd seafile-server && ./setup-seafile.sh
	
	＃启动服务
	./seafile.sh start &&   ./seahub.sh start
	＃防火墙放行端口
	chk_firewall
	＃开机启动
	echo  “ /home/MyCloud/seafile-server/seafile.sh start ”  >> /etc/rc.d/rc.local
	echo  “ /home/MyCloud/seafile-server/seahub.sh start ”  >> /etc/rc.d/rc.local
	chmod u + x /etc/rc.d/rc.local
	＃获取IP
	约瑟夫= $（卷曲http://https.tn/ip/myip.php ？键入= onlyip ）
	echo  “ ------------------------------------------------ ------ “
	echo  “恭喜，安装完成。请访问：http：// $ {osip}：8000 ”
	echo  “帮助文档请访问：https：//www.xiaoz.me/archives/8480 ”
	echo  “阿里云用户请注意放行端口（8000/8082）：https：//www.xiaoz.me/archives/9310 ”
	echo  “ ------------------------------------------------ ------ “
}

echo  “ ##########欢迎使用Seafile一键安装脚本^ _ ^ 2018年3月6日20:42:39 ########## ”

echo  “ 1.安装Seafile ”
回声 “ 2.卸载Seafile ”
echo  “ 3.退出”
declare -i stype
read -p “请输入选项：（1.2.3）：” stype

如果 [ “ $ stype ”  == 1]
	然后
		＃检查目录是否存在
		如果 [ -e  “ / home / MyCloud ” ]
			然后
			echo  “目录存在，请检查是否已经安装。”
			出口
		其他
			echo  “目录不存在，创建目录...... ”
			mkdir -p / home / MyCloud
			＃执行安装函数
			install_sea
		科幻
	elif [ “ $ stype ”  == 2]
		然后
			/home/MyCloud/seafile-server/seafile.sh停止
			/home/MyCloud/seafile-server/seahub.sh停止
			rm -rf / home / MyCloud
			rm -rf / tmp / seahub_cache / *
			echo  '卸载完成。“
			出口
	elif [ “ $ stype ”  == 3]
		然后
			出口
	其他
		echo  “参数错误！”
	科幻	
