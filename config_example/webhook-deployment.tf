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
          image = "localhost:5000/mutating-webhook:latest"

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

