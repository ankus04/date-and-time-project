# This project reflects the current date & time on web

# Problem Statement 1:

1. Product Requirements -

  --Install image scanning tool like Trivy

  --Build backend scanner integration like high vulnerabilities.

  --Store per-image: name, tag, digest, scan timestamp, list of CVEs (ID, package, current & fixed versions, severity).

  --CSV/JSON export of filtered lists.

  --Schedule automated email/Slack report for new critical vulnerabilities.

  --Implement alerting mechanism via email/webhooks.

2. Low-Fidelity Wireframes -

  --Dashboard
  
          ┌────────────────────────────────────────────────────────────────────┐
          │ Logo | Repository [v] | Search [__________] [Scan Now]           │
          ├────────────────────────────────────────────────────────────────────┤
          │ Filters: Severity [All v] | Status [All v] | Last Scan [7d]      │
          ├────────────────────────────────────────────────────────────────────┤
          │ Image Name           │ Critical │ High │ Medium │ Low │ Actions  │
          ├────────────────────────────────────────────────────────────────────┤
          │ frontend-service     │ 2        │ 5    │ 10     │ 8   │ [View]   │
          │ backend-worker       │ 0        │ 1    │ 2      │ 3   │ [View]   │
          │ database-storage     | 0        |      |  2     | 4   | [View]   │
          ├───────────────────────────────────────────────────────────────────┤
          │ ← Prev 1 2 3 … 50 Next →                                         │
          └────────────────────────────────────────────────────────────────────┘



# Problem Statement 2:

  --Install K8s on local using K8s doc. based on OS
  
  --Install docker 

  --Install (e.g. kind, minikube) to create cluster

  --Install Kubespace:
        
          curl -s https://raw.githubusercontent.com/kubescape/kubescape/master/install.sh | /bin/bash


  --Run a scan and save JSON output:

          kubescape scan framework nsa --format json --output results.json

  --Review `results.json` and share with team          
        

# Problem Statement 3:Technical Implementation


1. Go Web App
  
   --main.go

          package main

          import (
              "fmt"
              "net/http"
              "time"
          )

          func handler(w http.ResponseWriter, r *http.Request) {
            now := time.Now().Format(time.RFC1123)
            fmt.Fprintf(w, "<h1>Current Date & Time:</h1><h2>%s</h2><p>", "<h2>"+now+"</h2>")
          }

          func main() {
            http.HandleFunc("/", handler)
            http.ListenAndServe(":8080", nil)
          }

   
2. Dockerfile

          FROM golang:latest

          WORKDIR /app

          COPY . .

          RUN go build -o bin .

          CMD ["./bin"]

3. Build & Push on GitHub

          git init && git add . && git commit -m "Add date-time app"
          git remote add origin git@github.com:youruser/date-time-app.git
          git push -u origin main

4. Docker login

          dockee login -u username
          passward Enter personal access token

          docker build -t username/date-time-app:latest .
          docker push username/date-time-app:latest



5. Declarative K8s Deployment

   --Create a namespace

          kubectl create ns date-time-app

   --Write deploment.yml file

          apiVersion: apps/v1
          kind: Deployment
          metadata:
            name: date-time-app
            namespace: date-time-app
            spec:
              replicas: 2
              selector:
                matchLabels:
                  app: date-time-app
             template:
               metadata:
                 labels:
                   app: date-time-app
               spec:
                 containers:
                 - name: datetime
                   image: username/date-time-app
                   ports:
                   - containerPort: 8080
      

   --Expose to Internet usind service.yml file

          apiVersion: v1
          kind: Service
          metadata:
            name: date-time-service
            namespace: date-time-app
          spec:
            type: LoadBalancer
            selector:
              app: datetime
            ports:
            - protocol: TCP
              port: 80
              targetPort: 8080


