#!/bin/bash

# Check if the loki release exists
if helm list -n loki | grep loki; then
  # If it does, uninstall it
  helm uninstall loki -n loki
fi

# Check if the kube-prometheus-stack release exists
if helm list -n monitoring | grep kube-prometheus-stack; then
  # If it does, uninstall it
  helm uninstall kube-prometheus-stack -n monitoring
fi

# If the --storage argument is provided
if [[ $1 == "--storage" ]]; then

  while kubectl get pods -n loki --field-selector=status.phase!=Succeeded,status.phase!=Failed | grep 'loki'; do  
    echo "Waiting for loki pods to terminate..."
    sleep 5
  done

  # Wait for all pods to disappear
  while kubectl get pods -n monitoring | grep 'kube-prometheus-stack'; do
    echo "Waiting for kube-prometheus-stack pods to terminate..."
    sleep 5
  done

  # Delete Loki PVC
  kubectl get pvc -n loki | tail -n+2 | awk '{print $1}' | while read pvc; do kubectl delete pvc $pvc -n loki; done

  # Delete the PVC
  kubectl delete pvc -l app.kubernetes.io/instance=kube-prometheus-stack-prometheus -n monitoring
fi
