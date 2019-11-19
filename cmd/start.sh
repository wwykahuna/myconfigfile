PROCMAX=1

APP_NAME=lsms2-simulate
JAVA_HOME=/opt/jdk1.8.0_91/

BIN_PATH=`dirname $0`
cd ${BIN_PATH}/..
RUN_HOME=`pwd`


PS_ALIVE="ps -ef"
if [ `uname` == "SunOS" ];then
        PS_ALIVE="/usr/ucb/ps -auxww"
fi

echo "`date +'%Y%m%d %T'` Before startup:"
echo "-----------------------------------------------------------------"
${PS_ALIVE}| grep java| grep -v grep | grep -w ${APP_NAME}
echo "--------------------------------------------------------------------------------"

procnum=`${PS_ALIVE}| grep java| grep -v grep | grep  -w ${APP_NAME} |wc -l`
if [ $procnum -lt $PROCMAX ]
then
        echo ""
else
        echo "Already running!"
        exit 2
fi

echo ${RUN_HOME}

BOOTUP=${RUN_HOME}/lib/${APP_NAME}-0.0.1-SNAPSHOT.jar
echo ${BOOTUP}

JAVACMD="auto"
if [ -z "${JAVACMD}" ] || [ "${JAVACMD}" = "auto" ] ; then
        if [ -n "$JAVA_HOME"  ] ; then
                if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
                        # IBM's JDK on AIX uses strange locations for the executables
                        JAVACMD="$JAVA_HOME/jre/sh/java"
                else
                        JAVACMD="$JAVA_HOME/bin/java"
                fi
        fi
fi

if [ ! -x "${JAVACMD}" ] ; then
                JAVACMD=`which java 2> /dev/null `
                if [ -z "${JAVACMD}" ] ; then
                                JAVACMD=java
                fi
fi

if [ ! -x "${JAVACMD}" ] ; then
        echo "ERROR: Configuration variable JAVA_HOME or JAVACMD is not defined correctly."
        echo "       (JAVA_HOME='$JAVAHOME', JAVACMD='${JAVACMD}')"
        exit 4
fi
echo ${JAVACMD}


ENVFILE=${RUN_HOME}/config/application.yml
LOGFILE=${RUN_HOME}/config/logback-spring.xml

nohup ${JAVACMD} -jar ${BOOTUP} -Dspring.config.location=${ENVFILE} -Dlogging.config=${LOGFILE} >> ${RUN_HOME}/logs/console.log 2>&1 &


echo "`date +'%Y%m%d %T'` $0 $1 execute complete!"
echo "--------------------------------------------------------------------------------"
${PS_ALIVE}| grep java| grep -v grep | grep -w  ${APP_NAME}
echo "--------------------------------------------------------------------------------"
