package main

import (
    "fmt"
    "log"
    "net/http"
    "os"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "Hello from AKS Service Mesh GitOps Demo!")
}

func main() {
    http.HandleFunc("/", helloHandler)
    port := os.Getenv("PORT")
    if port == "" {
        port = "8080"
    }
    log.Printf("Starting server on port %s...", port)
    log.Fatal(http.ListenAndServe(":"+port, nil))
}
