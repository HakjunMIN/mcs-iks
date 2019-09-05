
Forked from https://github.com/hoeghh/k8s-minecraft

## Docker image list for this k8s
* Repo: https://cloud.docker.com/repository/registry-1.docker.io/tbwlat/mc/tags

`tbwlat/mc` tag is same with spigot version as following

* spigot-1.14.4
* spigot-1.14.3
* spigot-1.14.2
* spigot-1.14.1
* spigot-1.14
* spigot-1.13.2
* spigot-1.12.2
* spigot-1.11.2
* spigot-1.10.2
* spigot-1.9.4
* spigot-1.8.8

This tag is used at the helm [`values.yaml`](helmchart/k8s-minecraft/values.yaml) file
In case of need for another version, you can make own docker image through changing `ARTIFACT` at [docker-entrypoint.sh](docker-image/docker-entrypoint.sh) file to get preferable version

# Running in Kubernetes
You need a Kubernetes cluster and Helm installed
```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --upgrade
```

Edit the PV file minecraft.pv.yaml to point to your nfs share.
Then apply the PV and PVC, and then helm install minecraft.

```
kubectl apply -f minecraft.pv.yaml
kubectl apply -f minecraft.pvc.yaml

helm install helmchart/k8s-minecraft --name overworld
```

# Connecting Minecraft client to our server
Start minecraft, and create a new server connection. Set the location to localhost and save. 
