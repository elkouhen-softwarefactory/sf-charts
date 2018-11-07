#!/usr/bin/env bash

helm lint api-gateway
helm lint evenement-parcours-integration
helm lint evenement-rappel
helm lint gestion-evenement
helm lint gestion-personnes
helm lint parcours-integration
helm lint referentiel-personnes-mock
helm lint referentiel-personnes-api
helm lint skills-api
helm lint elasticsearch
