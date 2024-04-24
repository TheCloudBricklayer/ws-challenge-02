# ws-challenge-2

# Install the Nginx application:

```bash
kubectl -n <your-namespace> apply -f nginx.yaml
```


# Simulate load to Nginx

Enable port forwarding:

```
kubectl -n <your-namespace> port-forward svc/nginx 18080:80
```

Generate load:

```
python simulate_load.py
```
