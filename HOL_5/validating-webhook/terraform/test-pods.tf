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
      hello = "world"
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

resource "kubernetes_pod" "test_app" {
  metadata {
    name = "test-app"

    labels = {
      hello = "universe"
    }
  }

  spec {
    container {
      name    = "test-app"
      image   = "ubuntu:focal"
      command = ["/bin/bash"]
      args    = ["-c", "sleep infinity"]
    }
  }
}

