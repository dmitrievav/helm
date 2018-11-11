# Helm charts

## Charts:

- Simpleapp
- Statefulapp

## Install:

```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule \
  --clusterrole=cluster-admin \
  --serviceaccount=kube-system:tiller

helm init --upgrade --service-account tiller
helm repo add dmitrievav https://dmitrievav.github.io/helm/charts
helm repo update
```

## Examples:

```
cat > helm_values.yaml <<-EOF
ingress:
  enabled: true
  hosts:
    - hellogo.minikube

containerPort: 8080

replicaCount: 3

image:
  repository: dmitrievav/hellogo
  tag: latest
  pullPolicy: Always
EOF


if ! helm status hellogo 2>/dev/null; then
    echo "Creating initial release"
	helm install --wait \
		--name hellogo \
		--namespace default \
		-f helm_values.yaml \
		dmitrievav/statefulapp
else
    echo "Upgrading release"
	helm upgrade --wait \
		hellogo \
		--namespace default \
		-f helm_values.yaml \
		dmitrievav/statefulapp
fi
```