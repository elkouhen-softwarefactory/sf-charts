#!/usr/bin/env bash

while getopts "v:c:" arg; do
  case $arg in
    v)
      version=$OPTARG
      ;;
    c)
      package=$OPTARG
      ;;
  esac
done

git add .


echo "StrictHostKeyChecking no" > ~/.ssh/config

chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 644 ~/.ssh/config

git config --global user.email "startech.ouest@gmail.com"

git config --global user.name "Startech Ouest"

git commit -am "release chart $package:$version"

git push --set-upstream origin master