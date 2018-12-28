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

helm package --version $version $package
#helm package --version $version h2
#helm package --version $version books-api

helm repo index . --url https://softeamouest-opus.github.io/charts/

git add .

git commit -am commit

git push
