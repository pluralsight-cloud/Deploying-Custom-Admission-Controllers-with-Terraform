.PHONY: build
build:
	mkdir -p ./bin
	go build -o ./bin

.PHONY: build-image
build-image:
	docker build -t <USERNAME>/validating-webhook:latest .

.PHONY: push-image
push-image:
	docker push <USERNAME>/validating-webhook:latest

.PHONY: deploy-certs
deploy-certs:
	kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml
	sleep 10
	kubectl apply -f ./cert-manager/ca-bootstrap.yaml
	sleep 2
	kubectl apply -f ./cert-manager/ca-root-cert.yaml
	sleep 2
	kubectl apply -f ./cert-manager/ca-root-ci.yaml
	sleep 2
	kubectl apply -f ./cert-manager/webhook-cert.yaml
	sleep 2
	kubectl apply -f ./cert-manager/kubernetes-api-cert.yaml

.PHONY: deploy-webhook
deploy-webhook:
	kubectl apply -f ./kubernetes/webhook-deployment.yaml
	kubectl apply -f ./kubernetes/validating-webhook-config.yaml
