sonarqubeUsername: "${sonarqubeUsername}"
sonarqubePassword: "${sonarqubePassword}"

minHeapSize: 768m
maxHeapSize: 1520m

resources:
  requests:
    memory: "2.5Gi"

sysctl:
  enabled: false

postgresql:
  enabled: false

##connect to PostGres using cloud-sql-proxy sidecar container
externalDatabase:
  host: "127.0.0.1"
  user: "${postgres_user}"
  password: "${postgres_password}"

serviceAccount:
  create: false
  name: "${service_account_name}"

sidecars:
  - name: cloud-sql-proxy
    image: gcr.io/cloud-sql-connectors/cloud-sql-proxy:2.1.0
    imagePullPolicy: Always
    args:
      - "--structured-logs"
      - "--port=${postgres_port}"
      - "${postgres_connection_name}"
    ports:
      - name: db-port
        containerPort: ${postgres_port}
    securityContext:
      runAsNonRoot: true
    resources:
      requests:
        memory: "256Mi"
        cpu: "1"
