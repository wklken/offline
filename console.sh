#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

function help_msg() {
    echo "===================== usage ====================="
    echo "./logstashd.sh  - enter command line"
    echo "./logstashd.sh status - show all configured process"
    echo "./logstashd.sh start ${name} - start program"
    echo "./logstashd.sh stop ${name} - stop program"
    echo "./logstashd.sh restart ${name} - restart program"
    echo "./logstashd.sh reread && ./logstashd.sh update - update config and just update the modified programs"
    echo "./logstashd.sh reload - reload config files and restart all programs(stopeed not included)"
    echo "================================================="
    echo ""
}

help_msg

source env/bin/activate

CONFIG_FILE_PATH="${CURRENT_DIR}/conf/supervisord.conf"

supervisorctl -c $CONFIG_FILE_PATH $@

