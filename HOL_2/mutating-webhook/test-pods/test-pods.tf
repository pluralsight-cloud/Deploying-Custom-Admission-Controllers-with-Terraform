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

resource "kubernetes_pod" "test_app_1" {
  metadata {
    name = "test-app-1"
  }

  spec {
    container {
      name    = "test-app-1"
      image   = "ubuntu:focal"
      command = ["/bin/bash"]
      args    = ["-c", "sleep infinity"]
    }
  }
}

resource "kubernetes_pod" "test_app_2" {
  metadata {
    name = "test-app-2"

    labels = {
      hello = "universe"
    }
  }

  spec {
    container {
      name    = "test-app-2"
      image   = "ubuntu:focal"
      command = ["/bin/bash"]
      args    = ["-c", "sleep infinity"]
    }
  }
}

