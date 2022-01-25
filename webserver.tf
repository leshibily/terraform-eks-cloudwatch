resource "kubernetes_deployment" "web_server" {
  metadata {
    name = "web-server"
    labels = {
      app = "web-server"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "web-server"
      }
    }
    template {
      metadata {
        labels = {
          app = "web-server"
        }
      }
      spec {
        container {
          image             = "nginx:latest"
          image_pull_policy = "IfNotPresent"
          name              = "web-server"
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "web_server" {
  metadata {
    name = "web-server"
  }
  spec {
    selector = {
      app = "web-server"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}