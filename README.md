# ws-challenge-2

# Install the Nginx application:

```bash
kubectl -n <your-namespace> apply -f nginx.yaml
```


# Generate load to Nginx

Enable port forwarding:

```
kubectl -n <your-namespace> port-forward svc/nginx 18080:80
```

Generate load:

```
python3 generate_load.py
```

# Patch Nginx deployment

```
kubectl -n <your-namespace> patch deployment nginx --patch-file nginx_patch.yaml
```

To undo the patch:

```
kubectl -n <your-namespace> rollout undo deployment nginx
```

# Development environment

tools:
- [kind](https://kind.sigs.k8s.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 
- [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator)

Documentation:
- [Prometheus Operator user guides](https://github.com/prometheus-operator/prometheus-operator/tree/main/Documentation/user-guides)


## install kind
To install kind, you need install docker and go, then run the following commands:

```bash
go install sigs.k8s.io/kind@v0.22.0 && kind create cluster --config=dev_cluster.yaml --name ws-challenge-02

```

## Install prometheus operator

1- install operator
Run the following commands to install the CRDs and deploy the operator in the default namespace:
```bash
curl -sL https://github.com/prometheus-operator/prometheus-operator/releases/download/v0.73.2/bundle.yaml | kubectl create -f -
```

It can take a few minutes for the operator to be up and running. You can check for completion with the following command:
```bash
kubectl wait --for=condition=Ready pods -l  app.kubernetes.io/name=prometheus-operator -n default
```
## Create the monitoring namespace

```bash
kubectl create namespace monitoring
```

## Install prometheus

1.- apply the ./monitoring_infra/prometheus.yaml file
```bash
kubectl apply -f ./monitoring_infra/prometheus.yaml -n monitoring
```
2-. verify the prometheus installation
```bash
kubectl get -n default prometheus prometheus -n monitoring
```

## Install alertmanager

1.- create the alertmanager configurations
```bash
kubectl apply -f ./monitoring_infra/alertmanagerConfig.yaml -n monitoring
```

2.- apply the ./monitoring_infra/alertmanager.yaml file
```bash
kubectl apply -f ./monitoring_infra/alertmanager.yaml -n monitoring
```
3-. verify the alertmanager installation
```bash
kubectl get alertmanager main -n monitoring
```

## Install Grafana
To install grafana, run the following steps:

1.- Set the configmaps with the grafana configuration and the datasources
```bash
kubectl create configmap grafana-config --from-file=./monitoring_infra/grafana.ini -n monitoring
kubectl create configmap grafana-datasources --from-file=./monitoring_infra/datasources.yaml -n monitoring
kubectl create -f ./monitoring_infra/alertmanagerConfig.yaml -n monitoring
```

```bash
kubectl apply -f ./monitoring_infra/grafana.yaml -n monitoring
```
To verify the installation, run the following command:
```bash
kubectl get service grafana -n monitoring
```

## Install service monitor

1.- generate the service namespace
```bash
kubectl create namespace ws-challenger-03
```

2.- apply the service-monitor.yaml file
```bash
kubectl apply -f service_monitor.yaml -n ws-challenger-03
```
3-. verify the service monitor installation
```bash
kubectl get -n ws-challenger-03 servicemonitor nginx
```

## Deploy the application

1 - Deploy the application
```bash
kubectl -n ws-challenger-03 apply -f nginx.yaml
```

2 - verify the deployment
```bash
kubectl -n ws-challenger-03 get pods
```











