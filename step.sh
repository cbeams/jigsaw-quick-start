#!/usr/bin/env bash

set +x
cat << task

    Compile

task
(rm -rf bin && mkdir bin) || exit
echo '(nothing to compile yet)'
set -x

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
echo '(nothing to run yet)'
set -x
