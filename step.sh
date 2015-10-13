#!/usr/bin/env bash

set +x
cat << task

    Compile

task
(rm -rf bin && mkdir bin) || exit
mkdir bin/org.astro
mkdir bin/com.greetings
set -x

javac -d bin/org.astro \
    $(find src/org.astro -name '*.java') || exit

javac -d bin/com.greetings \
    --module-path bin \
    $(find src/com.greetings -name '*.java') || exit

find bin -type f


set +x
cat << task

    Assemble

task
(rm -rf lib && mkdir lib) || exit
set -x

jar --create --file=lib/org.astro-1.0.jar \
    --module-version=1.0 \
    -C bin/org.astro . || exit

jar --print-module-descriptor --file=lib/org.astro-1.0.jar || exit

jar --create --file=lib/com.greetings.jar \
    --main-class=com.greetings.Main \
    -C bin/com.greetings . || exit

jar --print-module-descriptor --file=lib/com.greetings.jar || exit


set +x
cat << task

    Run

task
set -x

java \
    --module-path lib \
    -m com.greetings
