#!/bin/bash
clear
set -x
set -T

initial_dir=$(pwd)
log_file="$initial_dir/time_log.txt"

echo "System Information:" > "$log_file"
echo "------------------" >> "$log_file"
uname -a >> "$log_file"
echo "------------------" >> "$log_file"
#lscpu >> "$log_file"
#echo "------------------" >> "$log_file"
#free -h >> "$log_file"
#echo "------------------" >> "$log_file"

export M2_HOME="$initial_dir/.m2"

echo "Cloning repository and checking out commit..."

if [ -d "commons-lang" ]; then
    rm -rf commons-lang
fi
echo "clone"
time git clone --depth=1 https://github.com/apache/commons-lang >> "$log_file"
cd commons-lang
git checkout e8944ba1bee6d459e0e28a562d545bfd40aa5774
exit


echo "go offline"
(time mvn dependency:go-offline >> "$log_file") 2>&1
echo "clean"
(time mvn clean >> "$log_file") 2>&1

echo "mvn clean install -o -Drat.skip=true"
(time mvn clean install -o -Drat.skip=true >> "$log_file") 2>&1

echo "Process completed. Time measurements saved in $log_file."
