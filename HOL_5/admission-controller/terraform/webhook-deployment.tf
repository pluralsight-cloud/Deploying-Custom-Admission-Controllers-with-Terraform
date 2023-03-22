terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

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
          image = "<USERNAME>/validating-webhook:latest"

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

resource "kubernetes_validating_webhook_configuration" "pod_label_require" {
  depends_on = [kubernetes_deployment.validating_webhook]
  metadata {
    name = "pod-label-require"

    annotations = {
      "cert-manager.io/inject-ca-from" = "default/client"
    }
  }

  webhook {
    name = "pod-label-require.guru.com"

    client_config {
      service {
        namespace = "default"
        name      = "validating-webhook"
        path      = "/validate"
      }
    }

    rule {
      api_groups   = [""]
      api_versions = ["v1"]
      resources   = ["pods"]
      operations = ["CREATE"]
      scope      = "Namespaced"
    }

    side_effects              = "None"
    admission_review_versions = ["v1"]
  }
}
