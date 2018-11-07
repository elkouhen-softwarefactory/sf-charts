#!/usr/bin/env bash

version=0.1.58

#helm package --version $version api-gateway
#helm package --version $version evenement-parcours-integration
#helm package --version $version evenement-rappel
#helm package --version $version gestion-evenement
#helm package --version $version gestion-images
#helm package --version $version gestion-personnes
#helm package --version $version parcours-integration
#helm package --version $version referentiel-personnes-api
#helm package --version $version referentiel-personnes-mock
#helm package --version $version referentiel-personnes-ui
#helm package --version $version grav
#helm package --version $version skills-api

helm package --version $version elasticsearch

helm repo index . --url https://softeamouest.github.io/charts/

git add .

git commit -am commit

git push
