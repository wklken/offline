# offline

Install virtualenv and supervisord to a system without internet access(offline)

then you can maintain you daemon processes easily

-------------------------------

### packages

this package contains

```
supervisor-3.1.3.tar.gz
virtualenv-13.1.2.tar.gz
```

-------------------------------

### Usage

#### 1. download the tar.gz and copy/scp to the machine

https://github.com/wklken/offline/archive/v0.1.tar.gz

#### 2. extract

```
tar -xzvf xxx.tar.gz
cd xxx
```

then you got

```
.
├── console.sh   # supervisord console
├── pkgs
│   ├── elementtree-1.2.6-20050316.tar.gz
│   ├── meld3-0.6.5.tar.gz
│   ├── setuptools-18.5.tar.gz
│   ├── supervisor-3.1.3.tar.gz
│   └── virtualenv-13.1.2.tar.gz
├── setup.sh     # init env and setup
└── start_supervisord.sh  # start supervisord
```

#### 3. install virtualenv and supervisord

```
./setup.sh
```

then you got

```
conf/
└── supervisord.conf
env/
```

#### 4. start supervisord

```
./start_supervisord.sh

ps aux | grep supervisord
```

#### 5. DONE

edit the `conf/supervisord.conf` and use the `console.sh` to manage the process

```
$ ./console.sh
===================== usage =====================
./logstashd.sh  - enter command line
./logstashd.sh status - show all configured process
./logstashd.sh start  - start program
./logstashd.sh stop  - stop program
./logstashd.sh restart  - restart program
./logstashd.sh reread && ./logstashd.sh update - update config and just update the modified programs
./logstashd.sh reload - reload config files and restart all programs(stopeed not included)
=================================================

supervisor> status  # show processes status
supervisor> reread  # reread the config file
supervisor> update  # update and start the modified config processes
```

-------------------------------


### log

- 2015-11-22 version 0.1, first version


------------------------
------------------------


wklken

Email: wklken@yeah.net

Github: https://github.com/wklken

Blog: [http://www.wklken.me](http://www.wklken.me)
