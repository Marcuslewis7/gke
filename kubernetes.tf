# Namespace
resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
    labels = {
      name = "nginx"
    }
  }

  depends_on = [google_container_node_pool.primary_nodes]
}

resource "kubernetes_service_account" "nginx" {
  metadata {
    name = "nginx-sa"
    namespace = kubernetes_namespace.nginx.metadata[0].name
    labels = {
      app = "nginx"
    }
  }
}

resource "kubernetes_cluster_role" "nginx" {
  metadata {
    name = "nginx-cluster-role"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "pods/logs"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["services"]
    verbs      = ["get", "list"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "nginx" {
  metadata {
    name = "nginx-cluster-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.nginx.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.nginx.metadata[0].name
    namespace = kubernetes_namespace.nginx.metadata[0].name
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deployment"
    namespace = kubernetes_namespace.nginx.metadata[0].name
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.nginx.metadata[0].name

        container {
          name  = "nginx"
          image = "nginx:alpine"

          port {
            container_port = 80
          }

          resources {
            requests = {
              cpu    = "50m"
              memory = "64Mi"
            }
            limits = {
              cpu    = "100m"
              memory = "128Mi"
            }
          }

          # Liveness probe - restart if unhealthy
          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }

          # Readiness probe - only send traffic when ready
          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }
        }
      }
    }
  }
}

# Service to expose NGINX

resource "kubernetes_service" "nginx" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace.nginx.metadata[0].name
    labels = {
      app = "nginx"
    }
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }
}
