## Requeriments
---
* GKE/Kubernetes >= 1.20.8-gke.900
* Kubectl >= 1.22.0-rc.0
* Docker Engine >= 20.10.8
* Terraform >= v1.2.5
* Cluster: 4CPU 16RAM(minimum for one instance pods)
----
## Instalation Jenkins
* Configuration Deploy server:
  * By default the system would start with the following settings:
    * Replica:
       ```
        replicas: 1
        ```
    * Disk:
        ```
       apiVersion: v1
       kind: PersistentVolumeClaim
       metadata:
          name: jenkins-devops
        spec:
          accessModes: ["ReadWriteOnce"]
          storageClassName: standard
          resources:
            requests:
              storage: 10Gi
        ```
    * Default CPU:
       ```
       resources:
            requests:
              cpu: "500m"
              memory: "2000Mi"
            limits:
              cpu: "1"
              memory: "4000Mi"
        ```
   * Configure the parameter in ./jenkins/deploy.yaml
----
* Configuration HPA :
  * By default the system would start with the following settings:
    * HorizontalPodAutoscaler:
       ```
        spec:
          minReplicas: 1
          maxReplicas: 3
       ```
    * Metrics:
        ```
        metrics:
        - type: Resource
          resource:
            name: cpu
            targetAverageUtilization: 90
        - type: Resource
          resource:
            name: memory
            targetAverageUtilization: 95
        ```
  ----

  * Configure the parameter in ./jenkins/hpa.yaml

### Initializing the pods in
   ```
     kubectl apply -f jenkins/
   ```
----
* Get Secrets :
    * Secret:
       ```
      kubectl get pods;

      Get jenkins pod name;

      kubectl exec jenkins-devops-NamePod cat /var/jenkins_home/secrets/initialAdminPassword

      ```
----
* Configuration prometheus :
  * By default the system would start with the following settings:
     * Replica:
       ```
        replicas: 1
        ```
     * Default CPU:
          ```
          resources:
            requests:
              cpu: "250m"
              memory: "250Mi"
            limits:
              cpu: "500m"
              memory: "1000Mi"
        ```
   * Configure the parameter in ./prometheus/deploy.yaml
### Initializing the pods in
   ```
     kubectl apply -f prometheus/
   ```
----
* Configuration Deploy AlertManager:
  * By default the system would start with the following settings:
    * Replica:
       ```
        replicas: 1
        ```
    * Default CPU:
      ```
          resources:
            requests:
              cpu: "50m"
              memory: "50Mi"
            limits:
              cpu: "100m"
              memory: "100Mi"
        ```
* Configuration ConfigMap AlertManager:
  * By default the system would start with the following settings:
    * Default Configmap:
      ```
      - name: "slack"
        slack_configs:
          - api_url: URL_HERE
            channel: "#infraestructure-alerts"
            icon_url: https://avatars3.githubusercontent.com/u/3380462
            username: "Prometheus - Testing"
            text: "*Summary:* {{ .CommonAnnotations.summary }}\n*Description:* {{ .CommonAnnotations.description }}"
            send_resolved: false
        ```
* Alter resources to you slack
### Initializing the pods in
   ```
     kubectl apply -f alertemanager/
   ```
----
* Configuration Deploy ingress - https:
  * By default the system would start with the following settings:
    * ManagedCertificate:
        ```
         spec:
            domains:
             - mydomain.com
        ```
    * Ingress:
    ```
        metadata:
          name: jenkins-devops
          annotations:
            networking.gke.io/managed-certificates: "devops-monitoring"
          spec:
            rules:
              - host: mydomain.com
                http:
                  paths:
                    - backend:
                        serviceName: jenkins-devops
                        servicePort: 8080
       ```
  * Configure the parameter in ./ingress/ingress.yaml
    * Note: Change part of mydomain.com to your desired dns example jenkins-devops.xxx.com.br
### Initializing the pods in
   ```
     kubectl apply -f ingress/
   ```
----
* Configuration Deploy ingress - https:
  * By default the system would start with the following settings:
    * FrontendConfig:
        ```
        metadata:
          name: http-redirect-https
      spec:
        redirectToHttps:
          enabled: true
          responseCodeName: MOVED_PERMANENTLY_DEFAULT
        ```
  * Configure the parameter in ./ingress/front.yaml
### Initializing the pods in
   ```
     kubectl apply -f ingress/front.yaml
   ```
----
* Active Metrics:
    *  To enable metrics correctly apply deployment and rbac
        * kubectl apply -f ./kube-state-metrics/
        * kubectl apply -f ./node-exporter/
---
### Initializing Gluster GKE
  ```
    make install_cluster
   ```

### Initializing the entire project
  ```
    make install
   ```

### Remove the entire project
  ```
    make clean
   ```

## Download and branch
  ```
  git clone https://github.com/aoliveira94/fiap-monitoring.git
```
