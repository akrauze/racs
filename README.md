# racs

A simple HTTP-to-HTTPS reverse proxy intended to run as a Kubernetes sidecar container. It accepts plain HTTP on a configurable port (default `8080`) and forwards requests to `https://localhost:8443` with TLS verification disabled.

## Sidecar setup

Add the proxy as a second container in your pod spec:

```yaml
containers:
  - name: your-app
    image: your-app:latest
    ports:
      - containerPort: 8443

  - name: racs
    image: ghcr.io/akrauze/racs:latest
    ports:
      - containerPort: 8080
```

Direct your service or ingress to port `8080`. Traffic arrives as plain HTTP, the sidecar proxies it to your app over HTTPS on `localhost:8443` within the same pod.

### Custom listen port

Set the `RACS_PORT` environment variable to change the listen port:

```yaml
  - name: racs
    image: ghcr.io/akrauze/racs:latest
    env:
      - name: RACS_PORT
        value: "9090"
    ports:
      - containerPort: 9090
```
