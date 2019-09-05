# Prometheus exporter
https://github.com/sladkoff/minecraft-prometheus-exporter

# Prometheus Operator

Forked from https://github.com/coreos/prometheus-operator

## Quickstart

Note that this quickstart does not provision an entire monitoring stack; if that is what you are looking for see the [kube-prometheus](https://github.com/coreos/kube-prometheus) project. If you want the whole stack, but have already applied the `bundle.yaml`, delete the bundle first (`kubectl delete -f bundle.yaml`).

To quickly try out _just_ the Prometheus Operator inside a cluster, run the following command:

```sh
kubectl apply -f bundle.yaml
```

> Note: make sure to adapt the namespace in the ClusterRoleBinding if deploying in a namespace other than the default namespace.

To run the Operator outside of a cluster:

```sh
make
scripts/run-external.sh <kubectl cluster name>
```

## Removal

To remove the operator and Prometheus, first delete any custom re:sources you created in each namespace. The
operator will automatically shut down and remove Prometheus and Alertmanager pods, and associated ConfigMaps.

```sh
for n in $(kubectl get namespaces -o jsonpath={..metadata.name}); do
  kubectl delete --all --namespace=$n prometheus,servicemonitor,alertmanager
done
```

After a couple of minutes you can go ahead and remove the operator itself.

```sh
kubectl delete -f bundle.yaml
```

The operator automatically creates services in each namespace where you created a Prometheus or Alertmanager resources,
and defines three custom resource definitions. You can clean these up now.

```sh
for n in $(kubectl get namespaces -o jsonpath={..metadata.name}); do
  kubectl delete --ignore-not-found --namespace=$n service prometheus-operated alertmanager-operated
done

kubectl delete --ignore-not-found customresourcedefinitions \
  prometheuses.monitoring.coreos.com \
  servicemonitors.monitoring.coreos.com \
  podmonitors.monitoring.coreos.com \
  alertmanagers.monitoring.coreos.com \
  prometheusrules.monitoring.coreos.com
```
