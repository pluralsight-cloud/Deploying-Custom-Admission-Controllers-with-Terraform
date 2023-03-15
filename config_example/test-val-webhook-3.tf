resource "kubernetes_pod" "validating_test" {
  metadata {
    name = "validating-test"

    labels = {
      hello = "universe"
    }
  }

  spec {
    container {
      name    = "validating-test"
      image   = "ubuntu:focal"
      command = ["/bin/bash"]
      args    = ["-c", "sleep infinity"]
    }
  }
}

