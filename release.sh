#!/usr/bin/env bash

version=0.1.58

helm package --version $version ELK

helm repo index . --url https://softeamouest.github.io/charts/

git add .

git commit -am commit

git push
