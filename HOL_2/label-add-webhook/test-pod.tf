resource "kubernetes_pod" "label_tester" {
  metadata {
    name = "label-tester"
  }

  spec {
    container {
      name  = "nginx"
      image = "docker.io/nginx:1.23"
    }
  }
}

