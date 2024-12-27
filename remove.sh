#!/bin/bash

# Define the list of services
services=("prometheus-kafka-exporter" "kafka" "minio" "mongodb" "redis" "postgresql" "elasticsearch")

# Uninstall Helm releases for all services
for service in "${services[@]}"; do
  echo "Uninstalling Helm release: $service"
  helm uninstall "$service" || echo "Release $service not found."
done

# Function to wait for pods to terminate and delete their PVCs
cleanup_resources() {
  local app_name=$1
  echo "Cleaning up resources for $app_name..."

  # Wait for all pods with the given app label to disappear
  while [[ $(kubectl get pods -l app.kubernetes.io/name=$app_name --no-headers 2>/dev/null | wc -l) -gt 0 ]]; do
    echo "Waiting for $app_name pods to terminate..."
    sleep 5
  done

  # Delete PVCs for the app
  echo "Deleting PVCs for $app_name..."
  kubectl delete pvc -l app.kubernetes.io/name=$app_name || echo "No PVCs found for $app_name."
}

# If the --storage argument is provided
if [[ $1 == "--storage" ]]; then
  for service in "${services[@]}"; do
    cleanup_resources "$service"
  done
fi

kubectl delete pod -l app.kubernetes.io/name=elasticsearch
