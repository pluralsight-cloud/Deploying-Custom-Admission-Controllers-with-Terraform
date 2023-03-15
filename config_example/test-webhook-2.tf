resource "kubernetes_pod" "mutating_test" {
  metadata {
    name = "mutating-test"

    labels = {
      hello = "universe"
    }
  }

  spec {
    container {
      name    = "mutating-test"
      image   = "ubuntu:focal"
      command = ["/bin/bash"]
      args    = ["-c", "sleep infinity"]
    }
  }
}

