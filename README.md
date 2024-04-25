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
kubectl -n user1 rollout undo deployment nginx
```
