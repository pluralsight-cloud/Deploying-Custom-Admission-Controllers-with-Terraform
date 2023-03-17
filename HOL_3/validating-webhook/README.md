# HOL - Deploy a Dynamic Admission Controller with Terraform

This shows a basic implementation of a mutating webhook.

## Build the Webhook Docker Image

This Lab utilizes an EKS cluster.

```bash
$ make build
$ make build-image
$ make push-image
$ make deploy-certs
```
