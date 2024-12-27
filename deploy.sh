helm install kafka bitnami/kafka -f stack/kafka/values.yaml

sleep 2

# Get the number of replicas from the statefulset
replicas=$(kubectl get statefulset kafka-controller -o jsonpath='{.spec.replicas}')

# Wait for Kafka pods to be ready
for ((i=0; i<$replicas; i++)); do
  kubectl wait --for=condition=ready pod/kafka-controller-$i --timeout=300s
done

helm install prometheus-kafka-exporter prometheus-community/prometheus-kafka-exporter -f stack/prometheus-kafka-exporter/values.yaml

helm install minio bitnami/minio -f stack/minio/values.yaml

helm install mongodb bitnami/mongodb -f stack/mongodb/values.yaml

helm install redis bitnami/redis -f stack/redis/values.yaml

helm install postgresql bitnami/postgresql -f stack/postgresql/values.yaml

helm install elasticsearch bitnami/elasticsearch -f stack/elasticsearch/values.yaml
