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
mr -rf commons-lang
#time git clone --depth=1 --branch 056a2244 https://github.com/apache/commons-lang >> time_log.txt
time git clone --depth=1 https://github.com/apache/commons-lang >> time_log.txt
cd commons-lang



(time mvn dependency:go-offline) 2>> time_log.txt
(time mvn clean) 2>> time_log.txt

(time mvn clean install -o) 2>> time_log.txt

echo "Process completed. Time measurements saved in time_log.txt."
