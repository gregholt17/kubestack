helm uninstall prometheus-kafka-exporter
helm uninstall kafka

# If the --storage argument is provided
if [[ $1 == "--storage" ]]; then

  # Wait for all pods to disappear
  while kubectl get pods -n monitoring | grep 'kafka'; do
    echo "Waiting for kafka pods to terminate..."
    sleep 5
  done

  # Delete Kafka PVC
  kubectl get pvc | grep kafka | awk '{print $1}' | while read pvc; do kubectl delete pvc $pvc; done
fi
