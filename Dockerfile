FROM golang:1.23-alpine AS build
WORKDIR /src
COPY go.mod main.go ./
RUN go build -o /proxy .

FROM alpine:3.21
LABEL org.opencontainers.image.title="racs" \
      org.opencontainers.image.description="HTTP-to-HTTPS reverse proxy sidecar" \
      org.opencontainers.image.url="https://github.com/akrauze/racs" \
      org.opencontainers.image.source="https://github.com/akrauze/racs" \
      org.opencontainers.image.version="0.0.1" \
      org.opencontainers.image.licenses="AGPL-3.0-only" \
      org.opencontainers.image.authors="akrauze"
COPY --from=build /proxy /proxy
ENTRYPOINT ["/proxy"]
