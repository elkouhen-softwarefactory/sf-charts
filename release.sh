#!/usr/bin/env bash

version=0.0.3

helm package --version $version ELK
helm package --version $version h2
helm package --version $version books-api

helm repo index . --url https://softeamouest-opus.github.io/charts/

git add .

git commit -am commit

git push
