#!/bin/bash

kubectl -n ws-challenger-011 delete -f nginx.yaml

kubectl delete namespace ws-challenger-011

kubectl delete -f grafana.yaml -n default

kubectl delete configmap grafana-config -n default
kubectl delete configmap grafana-datasources -n default
kubectl delete -f alertmanagerConfig.yaml -n default

kubectl delete -f service_monitor.yaml

kubectl delete -f prometheus.yaml

curl -sL https://github.com/prometheus-operator/prometheus-operator/releases/download/v0.73.2/bundle.yaml | kubectl delete -f -