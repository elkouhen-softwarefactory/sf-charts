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

helm init --client-only

cd $package

helm dependency update --skip-refresh

cd -

helm package -d bin --version $version $package

helm repo index . --url https://elkouhen-softwarefactory.github.io/sf-charts/
