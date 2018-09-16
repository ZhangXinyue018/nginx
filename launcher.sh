#!/bin/bash

set -e

nginx_log_path='~/Documents/nginx'
nginx_config_path='~/Documents/go_learning/src/nginx'
nginx_container='nginx'
nginx_image='nginx:1.11-alpine'

function run(){

    local args="--restart=always -p 80:80 -p 443:443"

    args="$args -v $nginx_config_path/nginx.conf:/etc/nginx/nginx.conf"

    args="$args -v $nginx_config_path/mime.types:/etc/nginx/mime.types"

    # for extra sites
    args="$args -v $nginx_config_path/extra:/etc/nginx/extra"

    # for app sites
    args="$args -v $nginx_config_path/app:/etc/nginx/app"

    # logs
    args="$args -v $nginx_log_path:/var/log/nginx"

    run_cmd "docker run -it -d $args --name $nginx_container $nginx_image"
}

function run_cmd() {
    t=`date`
    echo "$t: $1"
    eval $1
}

run