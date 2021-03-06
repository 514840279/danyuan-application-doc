
-- 1.1 容器标识符

容器创建后都会分配一个CONTAINER id 作为容器的唯一标识，后续启动，停止，删除都是通过CONTAINER ID 完成的，CONTAINER ID 默认是128位，但对于大多数来说，16位就保证本机唯一性，所以默认情况下使用 简略形式即可（id的前16位）使用 docker ps 可以查看到CONTAINER ID简略形式，查询完整使用 docker ps --no-trunc.

--简略形式

docker ps 

-- 完整形式

docker ps --no-trunc

有了CONTAINER ID就可以启动停止容器了

-- 查询状态

docker ps -a |grep [0ee24103a5cf]

*[0ee24103a5cf] 是容器的id

-- 停止运行 

docker stop 0ee24103a5cf

-- 启动

docker start 0ee24103a5cf

CONTAINER ID 虽然保证唯一性，单很难记忆，所以在启动容器是给容器一个别名，来带替CONTAINER ID 

-- 别名

docker start [MyWordPress]

*[MyWordPress] 是创建容器是 --name参数名称 即容器的别名

-- 1.2 容器信息

通过docker inspcet 命令查询容器所有基本信息，包含运行情况，存储位置，配置参数，网络设置

-- 查看信息

docker inspcet MyWordPress

-- 通过-f参数获取指定部分信息

```
  docker inspcet -f {{ .State.Status}} MyWordPress
  docker inspcet -f {{ .NETworkSettings.IPAddress}} MyWordPress
```

--查询日志

docker logs MyWordPress

-- 时时打印

docker logs -f MyWordPress

-- 查看系统资源占用

docker stats MyWordPress


-- 1.3 容器内部命令

docker倡导“一个容器一个进程”的原理 、所以docker提供原生的方式支持登录容器 exec

命令格式： docker exec + 容器名 + 容器内部需要执行的命令

-- 查看MyWordPress 容器内启动了那些进程

docker exec MyWordPress ps aux

-- 如果需要多次执行 添加参数 -it 通过exit退出
```
  docker exec -it MyWordPress /bin/bash
  pwd
  ls
  exit
```

-- 2  多容器管理

docker倡导“一个容器一个进程”，假如一个服务有多个进程组成，就需要多个容器来相互提供服务

比如 MyWordPress 由 web 和数据库，在同一台主机下通过 docker run 命令 --link 建立容器之间的互联，但有一个前提，--link 
containerA 时 ，容器A 需要已经创建并启动运行的状态， 就是容器A在容器B之前创建 并启动运行。对于容器有多个的情况下维护就会变得繁琐。

-- 2.1 安装docker-compress

  sudo curl -L https://githuab.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

-- 停掉mywordpress

docker stop db MyWordPress

-- 创建一个 docker-compose.yml
```
  version: '2'
  services:
    db:
      image: mysql:5.7
      volumes:
        - "./.data/db:/var/lib/mysql"
      restart: always
      environment:
        MYSQL_ROOT_PASSWORD: wordpress
        MYSQL_DATABASE: wordpress
        MYSQL_USER: wordpress
        MYSQL_PASSWORD: wordpress

    wordpress:
      depends_on:
        - db
      image: wordpress:latest
      links:
        - db
      ports:
        - "8000:80"
      restart: always
      environment:
        WORDPRESS_DB_HOST: db:3306
        WORDPRESS_DB_PASSWORD: wordpress
```    
-- 创建和启动 

docker-compose up

-- 启动

docker-compose start

-- 停止运行

docker-compose stop

-- 2.2 多容器配置

-- gitlab  docker-compose
```
  version: '2'
  services:
    postgresql:
      image: sameersbn/postgresql:9.4-12
      environment:
        - DB_USER=gitlab
        - DB_PASS=password
        - DB_NAME=gitlabhq_production
    redis:
      image: sameersbn/redis:latest
    gitlab:
      image: sameersbn/gitlab:8.4.4
      links:
        - redis:redisio
        - postgresql:postgresql
      ports:
        - "10080:80"
        - "10022:22"
      environment:
        - GITLAB_PORT=10080
        - GITLAB_SSH_PORT=10022
        - GITLAB_SECRETS_DB_KEY_BASE=long-and-random-alpha-numeric-string
```

-- 启动 

docker-compose up -d

-- 查看容器状态

docker-compose -f gitlab/docker-compose.yml ps

-- 停止运行

docker-compose -f gitlab/docker-compose.yml stop

-- 启动

docker-compose -f gitlab/docker-compose.yml start

-- 删除项目

docker-compose -f gitlab/docker-compose.yml download/1
