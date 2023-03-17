resource "kubernetes_deployment" "mutating_webhook" {
  metadata {
    name = "mutating-webhook"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mutating-webhook"
      }
    }

    template {
      metadata {
        labels = {
          app = "mutating-webhook"
        }
      }

      spec {
        volume {
          name = "cert"

          secret {
            secret_name = "server-cert"
          }
        }

        container {
          name  = "mutating-webhook"
          image = "<USERNAME>/mutating-webhook:latest"

          port {
            container_port = 443
          }

          volume_mount {
            name       = "cert"
            read_only  = true
            mount_path = "/etc/opt"
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_service" "mutating_webhook" {
  metadata {
    name = "mutating-webhook"
  }

  spec {
    port {
      port        = 443
      target_port = "443"
    }

    selector = {
      app = "mutating-webhook"
    }
  }
}

