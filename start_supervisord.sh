#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

source env/bin/activate

env/bin/supervisord -c ${CURRENT_DIR}/conf/supervisord.conf
