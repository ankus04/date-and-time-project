package main

import (
    "fmt"
    "net/http"
    "time"
)

func handler(w http.ResponseWriter, r *http.Request) {
  now := time.Now().Format(time.RFC1123)
  fmt.Fprintf(w, "<h1>Current Date & Time</h1><p>%s</p>", "<h1>"+now+"</h1>")
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}