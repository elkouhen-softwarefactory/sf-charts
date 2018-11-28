#!/usr/bin/env bash

version=0.1.58

helm package --version $version ELK
helm package --version $version h2
helm package --version $version helloworld

helm repo index . --url https://softeamouest.github.io/charts/

git add .

git commit -am commit

git push
