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

resource "kubernetes_mutating_webhook_configuration" "pod_label_add" {
  depends_on = [kubernetes_deployment.mutating_webhook]
  metadata {
    name = "pod-label-add"

    annotations = {
      "cert-manager.io/inject-ca-from" = "default/client"
    }
  }

  webhook {
    name = "pod-label-add.guru.com"

    client_config {
      service {
        namespace = "default"
        name      = "mutating-webhook"
        path      = "/mutate"
      }
    }

    rule {
      api_groups   = [""]
      api_versions = ["v1"]
      resources   = ["pods"]
      operations  = ["CREATE"]
      scope       = "Namespaced"
    }

    side_effects              = "None"
    admission_review_versions = ["v1"]
  }
}

