Minecraft server for IBM Kubernetes
=============

## List of node port
This project exposes service IP as node port as following
   ```
   * FTP: 30080
   * Minecraft: 31111
   * Prometheus: 30900
   * Exporter for Prometheus: 31225
   * Grafana: 30300 
   ```
Loadbalancer or Ingress can be used with proper configuration as well   
## Prerequisite

* Download and install a few CLI tools and the Kubernetes Service plug-in.
    ```bash
    $ curl -sL https://ibm.biz/idt-installer | bash
    ```

* Config local environment to use IKS  
    ```bash
    $ ibmcloud ks cluster-config --cluster <cluster-name>
    ```
    
> To get a detailed info, visit https://www.ibm.com/cloud/container-service 

## Quick Start

1. Make helm account and init
    ```bash
    $ kubectl create serviceaccount --namespace kube-system tiller
    $ kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
    $ helm init --service-account tiller --upgrade
    ```
2. Make PV and PVC
    ```bash
    $ cd <root>/k8s-minecraft
    $ kubectl apply -f minecraft.pv.yaml
    $ kubectl apply -f minecraft.pvc.yaml
    ```

3. Install MCS (spigot)
    ```bash
    $ cd <root>/
    $ helm install k8s-minecraft/helmchart/k8s-minecraft --name overworld
    ```    
    
## Install FTP service for editing configuratin and applying plugins
This FTP service uses same volume that is assigned by above PVC 

1. Make secret for ftp user and password
    ```bash
    $ kubectl create secret generic mysecret --from-literal=ftpuser=<user-name> --from-literal=ftppassword=<user-password>    
    ```

2. IP configuration for using `PASSIVE MODE`
   
    Change `PASV_ADDRESS` in [`ftp-deployment.yaml`](kubernetes-ftp/ftp-deployment.yaml) to proper `EXTERNAL-IP` that can be retrieved via 
    ```bash
    $ export EXTERNAL_IP=`kubectl get node -o=jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}'`
 
    ```    
    
3. Deploy ftp service
    ```bash
    $ cd <root>/kubernetes-ftp
    $ cat ftp-deployment.yaml | sed 's/\<EXTERNAL_IP\>/'$EXTERNAL_IP'/' | kubectl apply -f -
    $ kubectl apply -f ftp-service.yaml
    ```    

## Monitoring MCS
#### Install Prometheus and Grafana for monitoring MCS

1. Install basic Prometheus Operator set
    ```bash
    $ cd <root>/monitoring
    $ kubectl apply -f bundle.yaml 
    ``` 

2. Install Prometheus Server and Grafana
    ```bash
    $ kubectl apply -f prometheus-server.yaml -f grafana.yaml
    ```

#### Upload a plugin for MCS metrics
* Upload `./monitoring/plugins/minecraft-prometheus-exporter-1.2.0.jar` to `plugins` folder through FTP Service
* Restart MCS is mandatory to be applied

#### Configure Data source in Grafana
1. Go to `Configuration > Data Sources`, then click`Add Data Sources`
2. Select `Prometheus`
3. Enter the URL of Prometheus at `url` field 
4. Click `Save & Test` to test

#### Make up for MCS Systam Dashboard
1. Copy the content in `./monitoring/grafana-dashboard/minecraf-server-dashboard.json`
2. Go to `Create > Import`
3. Paste at `Or paste JSON` area then click `Load`

#### (Optional) Players Dashboard
This dashboard needs more load to the machine. Recommend not to use under small size machine
1. change `individual-player-statistics` to true in `config.yml` placed in plugins folder
    ```yaml
    port: 9225
    individual-player-statistics: true 

    ```
2. Copy the content in `./monitoring/grafana-dashboard/minecraf-players-dashboard.json`
3. Go to `Create > Import`
4. Paste at `Or paste JSON` area then click `Load`


