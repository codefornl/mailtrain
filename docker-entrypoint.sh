#!/bin/bash
set -e

cp /app/config-docker.toml /app/config/$NODE_ENV.toml

ENV USE_REDIS true
ENV REDIS_HOST localhost
ENV REDIS_PORT 6379
sed -i "s^__MT_TITLE__^$MT_TITLE^g" /app/config/$NODE_ENV.toml
sed -i "s^__MT_LANGUAGE__^$MT_LANGUAGE^g" /app/config/$NODE_ENV.toml
sed -i "s^__MT_LOG_LEVEL__^$MT_LOG_LEVEL^g" /app/config/$NODE_ENV.toml
sed -i "s^__MT_PORT__^$MT_PORT^g" /app/config/$NODE_ENV.toml
sed -i "s^__MT_HOST_INTERFACE__^$MT_HOST_INTERFACE^g" /app/config/$NODE_ENV.toml
sed -i "s^__MT_SECRET__^$MT_SECRET^g" /app/config/$NODE_ENV.toml
sed -i "s^__MT_LOGGER__^$MT_LOGGER^g" /app/config/$NODE_ENV.toml
sed -i "s^__MT_USE_PROXY__^$MT_USE_PROXY^g" /app/config/$NODE_ENV.toml
sed -i "s^__MT_MAX_POST__^$MT_MAX_POST^g" /app/config/$NODE_ENV.toml
sed -i "s^__MYSQL_HOST__^$MYSQL_HOST^g" /app/config/$NODE_ENV.toml
sed -i "s^__MYSQL_USER__^$MYSQL_USER^g" /app/config/$NODE_ENV.toml
sed -i "s^__MYSQL_PASSWORD__^$MYSQL_PASSWORD^g" /app/config/$NODE_ENV.toml
sed -i "s^__MYSQL_DB__^$MYSQL_DB^g" /app/config/$NODE_ENV.toml
sed -i "s^__MYSQL_PORT__^$MYSQL_PORT^g" /app/config/$NODE_ENV.toml
sed -i "s^__USE_REDIS__^$USE_REDIS^g" /app/config/$NODE_ENV.toml
sed -i "s^__REDIS_HOST__^$REDIS_HOST^g" /app/config/$NODE_ENV.toml
sed -i "s^__REDIS_PORT__^$REDIS_PORT^g" /app/config/$NODE_ENV.toml

if [ ! -f "/app/config/$NODE_ENV.toml" ] ; then 
    echo "No $NODE_ENV.toml, copying from docker-production.toml.tmpl"
    cp /app/config/docker-production.toml.tmpl /app/config/$NODE_ENV.toml
fi
if [ ! -f "/app/workers/reports/config/$NODE_ENV.toml" ] ; then 
    echo "No $NODE_ENV.toml for reports"
    if [ -f "/app/config/$NODE_ENV.toml" ] ; then 
        echo "copying config/$NODE_ENV.toml to reports config directory"
        cp /app/config/$NODE_ENV.toml /app/workers/reports/config/$NODE_ENV.toml
    else
        echo "copying config/docker-production.toml.tmpl to reports config directory as $NODE_ENV.toml"
        cp /app/config/docker-production.toml.tmpl /app/workers/reports/config/$NODE_ENV.toml
    fi
fi
exec "$@"
