helm install kafka kafka -f kafka/values-override.yaml

sleep 2

# Get the number of replicas from the statefulset
replicas=$(kubectl get statefulset kafka-controller -o jsonpath='{.spec.replicas}')

# Wait for Kafka pods to be ready
for ((i=0; i<$replicas; i++)); do
  kubectl wait --for=condition=ready pod/kafka-controller-$i --timeout=300s
done

helm install prometheus-kafka-exporter prometheus-kafka-exporter -f prometheus-kafka-exporter/values-override.yaml