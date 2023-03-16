resource "kubernetes_mutating_webhook_configuration" "pod_label_add" {
  metadata {
    name = "pod-label-add"

    annotations = {
      "cert-manager.io/inject-ca-from" = "default/client"
    }
  }

  webhook {
    name = "pod-label-add.trstringer.com"

    client_config {
      service {
        namespace = "default"
        name      = "mutating-webhook"
        path      = "/mutate"
      }
    }

    rule {
      api_groups   = ["apps"]
      api_versions = ["v1"]
      operations   = ["CREATE"]
      resources    = ["pods"]
      scope        = "Namespaced"
    }

    side_effects              = "None"
    admission_review_versions = ["v1"]
  }
}

