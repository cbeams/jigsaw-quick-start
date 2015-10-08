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
echo '(nothing to assemble yet)'
set -x


set +x
cat << task

    Run

task
set -x

java \
    --module-path bin \
    -m com.greetings/com.greetings.Main
