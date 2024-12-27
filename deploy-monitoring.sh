if [[ $1 == "--loki" ]]; then
  helm install loki grafana/loki --version 6.24.0 -n loki -f monitoring/loki/values-override.yaml
fi
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack --version 67.5.0 -n monitoring -f monitoring/kube-prometheus-stack/values-override.yaml
