resource "kubernetes_service" "validating_webhook" {
  metadata {
    name = "validating-webhook"
  }

  spec {
    port {
      port        = 443
      target_port = "443"
    }

    selector = {
      app = "validating-webhook"
    }
  }
}

