#!/bin/bash
set -x

mkdir -p charts
helm init --client-only
helm version --client

for chart in src/*; do
	helm package $chart -d charts
done

cd charts
helm repo index . --url https://dmitrievav.github.io/helm/charts
cat index.yaml