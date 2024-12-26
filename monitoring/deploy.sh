helm install loki loki -n loki -f loki/values-override.yaml
helm install kube-prometheus-stack kube-prometheus-stack -n monitoring -f kube-prometheus-stack/values-override.yaml
