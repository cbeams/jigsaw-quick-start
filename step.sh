#!/usr/bin/env bash

set +x
cat << task

    Compile

task
(rm -rf bin && mkdir bin) || exit
mkdir bin/com.greetings
set -x

javac -d bin/com.greetings \
    $(find src/com.greetings -name '*.java') || exit

find bin -type f


set +x
cat << task

    Assemble

task
(rm -rf lib && mkdir lib) || exit
set -x

jar --create --archive=lib/com.greetings.jar \
    --main-class=com.greetings.Main \
    -C bin/com.greetings . || exit

jar --print-module-descriptor --archive=lib/com.greetings.jar || exit


set +x
cat << task

    Run

task
set -x

java \
    -modulepath lib \
    -m com.greetings
