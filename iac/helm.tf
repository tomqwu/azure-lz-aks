data "azurerm_kubernetes_cluster" "cluster" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = azurerm_resource_group.aks_rg.name
  depends_on          = [azurerm_kubernetes_cluster.aks]
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.cluster.kube_admin_config[0].host
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config[0].client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config[0].client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.cluster.kube_admin_config[0].host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config[0].client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config[0].client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_admin_config[0].cluster_ca_certificate)
  }
}

resource "helm_release" "istio_base" {
  name            = "istio-base"
  repository      = "https://istio-release.storage.googleapis.com/charts"
  chart           = "base"
  version         = "1.18.0"
  namespace       = "istio-system"
  create_namespace = true
}

resource "helm_release" "istio_control" {
  name            = "istiod"
  repository      = "https://istio-release.storage.googleapis.com/charts"
  chart           = "istiod"
  version         = "1.18.0"
  namespace       = "istio-system"
  depends_on      = [helm_release.istio_base]
  values = [<<EOF
meshConfig:
  enableAutoInject: true
global:
  proxy:
    autoInject: enabled
EOF
  ]
}

resource "helm_release" "istio_ingress" {
  name       = "istio-ingressgateway"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "gateway"
  version    = "1.18.0"
  namespace  = "istio-system"
  depends_on = [helm_release.istio_control]
  values = [<<EOF
service:
  type: LoadBalancer
EOF
  ]
}

resource "helm_release" "kube_prometheus" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "51.0.0"
  namespace        = "monitoring"
  create_namespace = true
  depends_on       = [helm_release.istio_control]
  values = [<<EOF
grafana:
  adminPassword: "admin"
  service:
    type: LoadBalancer
alertmanager:
  enabled: false
EOF
  ]
}
