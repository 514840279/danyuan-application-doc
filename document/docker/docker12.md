
-- 镜像加速 windos  docker tools 方法

    docker-machine ssh default
    sudo sed -i "s|EXTRA_ARGS='|EXTRA_ARGS='--registry-mirror=http://dcfc451e.m.daocloud.io |g" /var/lib/boot2docker/profile
    exit
    docker-machine restart default 


* http://dcfc451e.m.daocloud.io 是在daoclould 上注册的加速器

==================== WordPress ============================

    -- mysql
    docker run --name db --env MYSQL_ROOT_PASSWORD=example -d mariadb

    -- WordPress
    docker run --name MyWordPress --link db:mysql -p 8080:80 -d wordpress

http://192.168.10.103:8080

系统默认 用户 root 密码 5iveL!fe

===================== gitlab ============================

    -- postgresql
    docker run --name gitlab-postgresql -d \
    --env 'DB_NAME=gitlabhq_production' \
    --env 'DB_USER=gitlab' --env 'DB_PASS=password' \
    sameersbn/postgresql:9.4-12

    -- redis
    docker run --name gitlab-redis -d sameersbn/redis:latest

    -- gitlab 
    docker run --name gitlab -d \
    --link gitlab-postgresql:postgresql --link gitlab-redis:redisio \
    --publish 10022:22 --publish 10080:80 \
    --env 'GITLAB_PORT=10080' --env 'GITLAB_SSH_PORT=10022' \
    --env 'GITLAB_SECRETS_DB_KEY_BASE=long-and-random-alpha-numeric-string' \
    sameersbn/gitlab:8.4.4


http://192.168.10.103:10080

系统默认 用户 root 密码 5iveL!fe

===================== Redmine ==============================

    -- postgresql
    docker run --name=postgresql-redmine -d \
    --env 'DB_NAME=redmine_production' \
    --env 'DB_USER=redmine' --env 'DB_PASS=password' \
    sameersbn/postgresql:9.4-12

    -- Redmine 
    docker run --name=redmine -d \
    --link=postgresql-redmine:postgresql --publish=10083:80 \
    --env='REDMINE_PORT=10083' \
    sameersbn/redmine:3.2.0-4

http://192.168.10.103:10083

系统默认 用户 admin 密码 admin

==========================================================
