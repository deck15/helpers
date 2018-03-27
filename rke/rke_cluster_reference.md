RKE cluster.yml Reference
=========================

nodes
-----
 * nodes - Kubernetes nodes
   * address - IP or FQDN that is fully resolvable and used for SSH communication
   * port - Port used for SSH communication
   * internal\_address - Optional - Internal address that will be used for components communication
   * role - Node role in kubernetes cluster (controlplane, worker, or etcd)
   * hostname\_override - Optional - Hostname of the node
   * user - SSH usesr that will be used by RKE
   * docker\_socket - Optional - Docker socket on the node that will be used in tunneling
   * ssh\_key - SSH Private Key
   * ssh\_key\_path - SSH Private Key Path
   * labels - Node Labels

services
--------
 * services - Kubernetes components
   * etcd - Etcd Service
     * external\_urls - List of etcd urls
     * ca\_cert - External CA certificate
     * cert - External Client certificate
     * key - External Client key
     * path - External etcd prefix
   * scheduler - Scheduler Service
   * kubelet - Kubelet Service
     * cluster\_domain - Domain of the cluster (default: "cluster.local")
     * infra\_container\_image - The image whose network/ipc namespaces containers in each pod will use
     * cluster\_dns\_server - Cluster DNS service ip
     * fail\_swap\_on - Fail if swap is enabled
   * kubeproxy - KubeProxy Service

network
-------
 * network - Network configuration used in the kubernetes cluster (flannel, calico)
   * plugin - Network Plugin That will be used in kubernetes cluster
   * options - Plugin options to configure network properties

authentication
--------------
 * authentication - Authentication configuration used in the cluster (default: x509)
   * strategy - Authentication strategy that will be used in kubernetes cluster
   * options - Authentication options
   * sans - List of additional hostnames and IPs to include in the api server PKI cert

addons
------
 * addons - YAML manifest for user provided addons to be deployed on the cluster

addons\_include
--------------
 * addons\_include - List of urls or paths for addons

system\_images
-------------
 * system\_images - List of images used internally for proxy, cert downlaod and kubedns
   * etcd - etcd image
   * alpine - Alpine image
   * nginx\_proxy - rke-nginx-proxy image
   * cert\_downloader - rke-cert-deployer image
   * kubernetes\_services\_sidecar - rke-service-sidekick image
   * kubedns - KubeDNS image
   * dnsmasq - DNSMasq image
   * kubedns\_sidecar - KubeDNS side car image
   * kubedns\_autoscaler - KubeDNS autoscaler image
   * kubernetes - Kubernetes image
   * flannel - Flannel image
   * flannel\_cni - Flannel CNI image
   * calico\_node - Calico Node image
   * calico\_cni - Calico CNI image
   * calico\_controllers - Calico Controllers image
   * calico\_ctl - Calicoctl image
   * canal\_node - Canal Node Image
   * canal\_cni - Canal CNI image
   * canal\_flannel - analFlannel image
   * wave\_node - Weave Node image
   * weave\_cni - Weave CNI image
   * pod\_infra\_container - Pod infra container image
   * ingress - Ingress Controller image
   * ingress\_backend - Ingress Controller Backend image
   * dashboard - Dashboard image
   * heapster - Heapster addon image
   * grafana - Grafana image for heapster addon
   * influxdb - Influxdb image for heapster addon
   * tiller - Tiller addon image

ssh\_key\_path
------------
 * ssh\_key\_path - SSH Private Key Path

ssh\_agent\_auth
--------------
 * ssh\_agent\_auth - SSH Agent Auth enable

authorization
-------------
 * authorization - Authorization mode configuration used in the cluster
   * mode - Authorization mode used by kubernetes
   * options - Authorization mode options

ignore\_docker\_version
---------------------
 * ignore\_docker\_version - Enable/disable strict docker version checking

kubernetes\_version
------------------
 * kubernetes\_version - Kubernetes version to use (if kubernetes image is specifed, image version takes precedence)

private\_registries
------------------
 * private\_registries - List of private registries and their credentials
   * url - URL for the registry
   * user - User name for registry acces
   * password - Password for registry access

ingress
-------
 * ingress - Ingress controller used in the cluster
   * provider - Ingress controller type used by kubernetes
   * options - Ingress controller options
   * node\_selector - NodeSelector key pair

cluster\_name
------------
 * cluster\_name - Cluster Name used in the kube config

cloud\_provider
--------------
 * cloud\_provider - Cloud Provider options
   * name - Name of the Cloud Provider
   * cloud\_config - Configuration Options of Cloud Provider

-----

## Full cluster.yml:

```yaml
---
nodes:
  address: string...
  port: string...
  internal_address: string...
  role:
  - string1...
  - string2...
  - string3...
  hostname_override: string...
  user: string...
  docker_socket: string...
  ssh_key: string...
  ssh_key_path: string...
  labels:
    option1: value
    option2: value
services:
  etcd: 
  scheduler: 
  kubelet: 
  kubeproxy: 
etcd:
  external_urls:
  - string1...
  - string2...
  - string3...
  ca_cert: string...
  cert: string...
  key: string...
  path: string...
scheduler: {}
kubelet:
  cluster_domain: string...
  infra_container_image: string...
  cluster_dns_server: string...
  fail_swap_on: true
kubeproxy: {}
network:
  plugin: string...
  options:
    option1: value
    option2: value
authentication:
  strategy: string...
  options:
    option1: value
    option2: value
  sans:
  - string1...
  - string2...
  - string3...
system_images:
  etcd: string...
  alpine: string...
  nginx_proxy: string...
  cert_downloader: string...
  kubernetes_services_sidecar: string...
  kubedns: string...
  dnsmasq: string...
  kubedns_sidecar: string...
  kubedns_autoscaler: string...
  kubernetes: string...
  flannel: string...
  flannel_cni: string...
  calico_node: string...
  calico_cni: string...
  calico_controllers: string...
  calico_ctl: string...
  canal_node: string...
  canal_cni: string...
  canal_flannel: string...
  wave_node: string...
  weave_cni: string...
  pod_infra_container: string...
  ingress: string...
  ingress_backend: string...
  dashboard: string...
  heapster: string...
  grafana: string...
  influxdb: string...
  tiller: string...
authorization:
  mode: string...
  options:
    option1: value
    option2: value
private_registries:
  url: string...
  user: string...
  password: string...
ingress:
  provider: string...
  options:
    option1: value
    option2: value
  node_selector:
    option1: value
    option2: value
cloud_provider:
  name: string...
  cloud_config:
    option1: value
    option2: value

```
