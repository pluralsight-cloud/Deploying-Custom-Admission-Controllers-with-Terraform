resource "kubernetes_pod" "mutating_test" {
  metadata {
    name = "mutating_test"
  }

  spec {
    container {
      name    = "mutating_test"
      image   = "ubuntu:focal"
      command = ["/bin/bash"]
      args    = ["-c", "sleep infinity"]
    }
  }
}

