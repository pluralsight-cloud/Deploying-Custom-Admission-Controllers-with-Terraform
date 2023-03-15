resource "kubernetes_deployment" "validating_webhook" {
  metadata {
    name = "validating-webhook"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "validating-webhook"
      }
    }

    template {
      metadata {
        labels = {
          app = "validating-webhook"
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
          name  = "validating-webhook"
          image = "localhost:5000/validating-webhook:latest"

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

