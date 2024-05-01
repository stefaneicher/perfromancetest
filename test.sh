#!/bin/bash
clear
set -x
set -T

echo "System Information:" > time_log.txt
echo "------------------" >> time_log.txt
uname -a >> time_log.txt
echo "------------------" >> time_log.txt
#lscpu >> time_log.txt
#echo "------------------" >> time_log.txt
#free -h >> time_log.txt
#echo "------------------" >> time_log.txt

export M2_HOME=$(pwd)/.m2

echo "Cloning repository and checking out commit..."

#time git clone --depth=1 --branch 056a2244 https://github.com/apache/commons-lang >> time_log.txt
#rm -rf commons-lang
#time git clone --depth=1 https://github.com/apache/commons-lang >> time_log.txt
cd commons-lang


echo "go offline"
(time mvn dependency:go-offline) 2>> time_log.txt
echo "clean"
(time mvn clean) 2>> time_log.txt

echo "mvn clean install -o -Drat.skip=true"
(time mvn clean install -o -Drat.skip=true) 2>> time_log.txt

echo "Process completed. Time measurements saved in time_log.txt."
