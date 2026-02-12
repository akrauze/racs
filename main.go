package main

import (
	"crypto/tls"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
)

func main() {
	port := os.Getenv("RACS_PORT")
	if port == "" {
		port = "8080"
	}

	target, _ := url.Parse("https://localhost:8443")

	proxy := httputil.NewSingleHostReverseProxy(target)
	proxy.Transport = &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}

	log.Printf("listening on :%s, proxying to %s", port, target)
	log.Fatal(http.ListenAndServe(":"+port, proxy))
}
