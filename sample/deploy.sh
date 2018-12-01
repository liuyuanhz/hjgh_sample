#!/bin/bash
PROJECT_DIR=$(cd `dirname $0`; pwd)
PROJECT_DIR_SIMPLE_NAME=`basename $PROJECT_DIR`
PROJECT=${PROJECT_DIR_SIMPLE_NAME%%-*}
ENV_PROPERTIES_DIR=$PROJECT_DIR/env
MODULE=${PROJECT_DIR_SIMPLE_NAME#*-}
DEPLOY_DIR=/data
OIFS=$IFS
IFS='-'
MODULES=($PROJECT_DIR_SIMPLE_NAME)
IFS=$OIFS
for DEPLOY_MODULE in ${MODULES[@]}
do
	DEPLOY_DIR=$DEPLOY_DIR/$DEPLOY_MODULE
done
BACKUP_DIR=$DEPLOY_DIR/backup
PUBLISH_DIR=$DEPLOY_DIR/publish
MODULE_EXT=tar
MODULE_TAR=$PROJECT-$MODULE.$MODULE_EXT
MODULE_TAR_FILE=""
ENV=dev
DST_IPS=0.0.0.256
PROCESS=all

# If ip valid
function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

function do_package()
{
    ENV_PROPERTIES=$ENV_PROPERTIES_DIR/$ENV.properties

    if [ ! -f "$ENV_PROPERTIES" ]
    then
        echo "[ERROR] $ENV_PROPERTIES not exists.."
        exit 1
    fi

    # maven clean and package
    cd $PROJECT_DIR
    mvn clean package -P$ENV -DskipTests -U
    if [ $? -ne 0 ];then
        echo "[ERROR] mvn package failed!"
        exit 1
    fi

    # prepare tar
    cd $PROJECT_DIR/target
    JARS=`ls $PROJECT-$MODULE-*.jar | grep -v $PROJECT-$MODULE-*-sources.jar`
    if [ ${#JARS[@]} -lt 1 ]
    then
        echo "[ERROR] More than one $PROJECT-$MODULE-*.jar exists, exit...."
        exit 1
    fi
    JAR=${JARS[0]}

    cp $PROJECT_DIR/control.sh .
    cp $ENV_PROPERTIES ./env.properties
    # For both BSD and GNU version of sed, especially for OS X users
    sed -ie "s/ENVIRONMENT=local/ENVIRONMENT=$ENV/g" env.properties
    sed -ie "s/PROJECT=project/PROJECT=$PROJECT/g" env.properties
    sed -ie "s/MODULE=module/MODULE=$MODULE/g" env.properties
    sed -ie "s/JAR=jar/JAR=$JAR/g" env.properties
    tar -cf $MODULE_TAR conf/ lib/ $JAR control.sh env.properties
    MODULE_TAR_FILE=$MODULE_TAR
    echo ""
    echo "====================================================="
    echo "[INFO] Maven package successed"
    return 0
}

function do_deploy()
{
    # Parse argument
    OLD_IFS="$IFS"
    IFS=","
    DST_IP_ARRAY=($DST_IPS)
    IFS="$OLD_IFS"
    for DST_IP in ${DST_IP_ARRAY[@]}
    do
        if ! valid_ip $DST_IP
        then
            echo "[ERROR] Server:$DST_IP invalid, exit..."
            exit 1
        fi
    done
    echo "[INFO] Start to deploy $JAR for $ENV environment on ${DST_IP_ARRAY[@]}"
    for DST_IP in ${DST_IP_ARRAY[@]}
    do
        echo "[INFO] Transmit $MODULE_TAR_FILE to $DST_IP"
        # Scp to home directory to avoid $DEPLOY_DIR not exists
        scp -r $MODULE_TAR_FILE root@$DST_IP:~/$MODULE_TAR
        if [ $? -ne 0 ];then
            # If any Transmission failed, No service will be redeploied
            echo "[ERROR] Transmission $PROJECT-$MODULE.tar failed"
            exit 1
        fi
    done
    echo "====================================================="
    for DST_IP in ${DST_IP_ARRAY[@]}
    do
        echo "[INFO] Start to install on $DST_IP"
        ssh -T root@$DST_IP << commands
            echo "[INFO] Prepare directories"

            # If backup directory exists
            if [ ! -d "$BACKUP_DIR" ]
            then
                mkdir -p $BACKUP_DIR
            fi

            # If deploied before
            if [ -f $DEPLOY_DIR/$MODULE_TAR ]
            then
                echo "[INFO] Backup last deploy...."
                rm -rf $BACKUP_DIR/*
                mv $DEPLOY_DIR/$MODULE_TAR $BACKUP_DIR/$PROJECT-$MODULE-`date +"%y%m%d%H%M%S"`.$MODULE_EXT
            fi
            mv ~/$PROJECT-$MODULE.tar $DEPLOY_DIR
            cd $DEPLOY_DIR

            echo "[INFO] Launching $PROJECT-$MODULE"
            if [ -d "$PUBLISH_DIR" ]
            then
                cd $PUBLISH_DIR
                ./control.sh stop
                cd $DEPLOY_DIR
                rm -rf $PUBLISH_DIR
            fi

            mkdir -p $PUBLISH_DIR
            tar -xf $MODULE_TAR -C $PUBLISH_DIR

            cd $PUBLISH_DIR
            chmod +x control.sh
            sed -i "s/SERVER_IP=0.0.0.0/SERVER_IP=$DST_IP/g" env.properties
            ./control.sh restart
            echo "====================================================="
commands
    done
}

while getopts ":e:s:m:t:" opt
do
    case $opt in
        e)
            ENV=$OPTARG;;
        s)
            DST_IPS=$OPTARG;;
        m)
            PROCESS=$OPTARG;;
        t)
            MODULE_TAR_FILE=$OPTARG;;
        ? )
            echo "unknow argument"
            exit 1;;
    esac
done

case $PROCESS in
    "all" )
        do_package
        do_deploy;;
    "package" )
        do_package;;
    "deploy" )
        do_deploy;;
    ?)
        exit 1;;
esac
