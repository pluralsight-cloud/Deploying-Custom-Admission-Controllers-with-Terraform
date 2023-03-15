resource "kubernetes_deployment" "label_add" {
  metadata {
    name = "label-add"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "label-add"
      }
    }

    template {
      metadata {
        name = "label-add"

        labels = {
          app = "label-add"
        }
      }

      spec {
        container {
          name  = "label-add"
          image = "USERNAME/label-add:1.0"

          port {
            container_port = 8443
          }

          image_pull_policy = "Always"
        }
      }
    }
  }
}

resource "kubernetes_service" "label_add" {
  metadata {
    name = "label-add"
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 443
      target_port = "8443"
    }

    selector = {
      app = "label-add"
    }
  }
}

