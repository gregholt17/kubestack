export MINIO_ROOT_USER=$(kubectl get secret --namespace default minio -o jsonpath="{.data.root-user}" | base64 -d)
export MINIO_ROOT_PASSWORD=$(kubectl get secret --namespace default minio -o jsonpath="{.data.root-password}" | base64 -d)

export MONGODB_ROOT_USER="admin"
export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace default mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 -d)

export REDIS_PASSWORD=$(kubectl get secret --namespace default redis -o jsonpath="{.data.redis-password}" | base64 -d)

export CLICKHOUSE_USER="default"
export CLICKHOUSE_PASSWORD=$(kubectl get secret --namespace default clickhouse -o jsonpath="{.data.admin-password}" | base64 -d)
