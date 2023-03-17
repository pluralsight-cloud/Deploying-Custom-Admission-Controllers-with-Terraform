resource "kubernetes_validating_webhook_configuration" "pod_label_require" {
  metadata {
    name = "pod-label-require"

    annotations = {
      "cert-manager.io/inject-ca-from" = "default/client"
    }
  }

  webhook {
    name = "pod-label-require.trstringer.com"

    client_config {
      service {
        namespace = "default"
        name      = "validating-webhook"
        path      = "/validate"
      }
    }

    rule {
      operations = ["CREATE"]
      scope      = "Namespaced"
    }

    side_effects              = "None"
    admission_review_versions = ["v1"]
  }
}

