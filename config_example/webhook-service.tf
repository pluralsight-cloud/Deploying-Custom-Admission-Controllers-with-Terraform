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

