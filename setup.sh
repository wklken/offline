#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

echo "CURRENT_DIR: $CURRENT_DIR"
echo "begin to init environments"

# ===============================
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`

function echo_info() {
    echo "${GREEN}$1${RESET}"
}

function echo_error(){
    echo "${RED}$1${RESET}"
}

# ========== virtualenv begin ========== 
echo "1. install virtualenv"

PKG_DIR=${CURRENT_DIR}/pkgs

cd ${PKG_DIR}

tar -xzf virtualenv-13.1.2.tar.gz

if [ -e ./virtualenv ]
then
    rm -rf virtualenv
fi

mv virtualenv-13.1.2 virtualenv
cd virtualenv

echo "create virtualenv $CURRENT_DIR/env"

/usr/bin/python virtualenv.py $CURRENT_DIR/env
if [ $? -eq 0 ]
then
    echo_info "make virtualenv success"
    echo_info $CURRENT_DIR/env
else
    echo_error "make virtualenv fail"
    exit 1
fi


cd ${PKG_DIR}
rm -rf virtualenv

echo "activate virtualenv"

cd ${CURRENT_DIR}
source env/bin/activate

PYTHON=`which python`
echo_info "current python: $PYTHON"

# ========== virtualenv end ========== 


# ========== supervisord begin ========== 

echo "2. install suprevisord"

cd ${PKG_DIR}

echo "2.1 install setuptools"


tar -xzf setuptools-18.5.tar.gz
cd setuptools-18.5
python setup.py install > /dev/null
cd ..
rm -rf setuptools-18.5

echo "2.2 install elementtree"

tar -xzf elementtree-1.2.6-20050316.tar.gz
cd elementtree-1.2.6-20050316
python setup.py install > /dev/null
cd ..
rm -rf elementtree-1.2.6-20050316

echo "2.3 install meld3"
tar -xzf meld3-0.6.5.tar.gz
cd meld3-0.6.5
python setup.py install > /dev/null
cd ..
rm -rf meld3-0.6.5

echo "2.4 install supervisor"
tar -xzf supervisor-3.1.3.tar.gz
cd supervisor-3.1.3
python setup.py install > /dev/null
cd ..
rm -rf supervisor-3.1.3

SUPERVISORD=`which supervisord`

echo_info "supervisord path: $SUPERVISORD"

# ========== supervisord end ========== 


# ========== init basic conf begin ========== 

cd ${CURRENT_DIR}
echo "3. generate supervisord conf"

if [ ! -e ${CURRENT_DIR}/conf ]
then
    mkdir ${CURRENT_DIR}/conf
fi

SUPERVISORD_CONF=${CURRENT_DIR}/conf/supervisord.conf

if [ ! -e ${SUPERVISORD_CONF} ]
then
    ${CURRENT_DIR}/env/bin/echo_supervisord_conf > ${SUPERVISORD_CONF}
    VERSION=$RANDOM
    sed -i "s#/tmp/supervisor.sock#/tmp/supervisor_$VERSION.sock#g" ${SUPERVISORD_CONF}
    sed -i "s#/tmp/supervisord.log#/tmp/supervisord_$VERSION.log#g" ${SUPERVISORD_CONF}
    sed -i "s#/tmp/supervisord.pid#/tmp/supervisord_$VERSION.pid#g" ${SUPERVISORD_CONF}
    echo_info "create ${SUPERVISORD_CONF} success"
fi

# ========== init basic conf end ========== 
