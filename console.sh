#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

function help_msg() {
    echo "===================== usage ====================="
    echo "./console.sh  - enter command line"
    echo "./console.sh status - show all configured process"
    echo "./console.sh start ${name} - start program"
    echo "./console.sh stop ${name} - stop program"
    echo "./console.sh restart ${name} - restart program"
    echo "./console.sh reread && ./logstashd.sh update - update config and just update the modified programs"
    echo "./console.sh reload - reload config files and restart all programs(stopeed not included)"
    echo "================================================="
    echo ""
}

help_msg

source env/bin/activate

CONFIG_FILE_PATH="${CURRENT_DIR}/conf/supervisord.conf"

supervisorctl -c $CONFIG_FILE_PATH $@

