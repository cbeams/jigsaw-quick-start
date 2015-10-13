#!/usr/bin/env bash

git tag -l | grep ^step | xargs git tag -d
let i=0
for sha in $(git log --grep openjdk --reverse --pretty=%h)
do
    git tag -f step$i $sha
    let i=i+1
done
