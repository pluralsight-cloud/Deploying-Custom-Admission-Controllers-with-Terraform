.PHONY: build
build:
	mkdir -p ./bin
	go build -o ./bin

.PHONY: build-image
build-image:
	docker build -t <USERNAME>/mutating-webhook:latest .

.PHONY: push-image
push-image:
	docker push <USERNAME>/mutating-webhook:latest

.PHONY: deploy-certs
deploy-certs:
	kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml
	kubectl apply -f ./cert-manager/ca-bootstrap.yaml
	kubectl apply -f ./cert-manager/ca-root-cert.yaml
	kubectl apply -f ./cert-manager/ca-root-ci.yaml
	kubectl apply -f ./cert-manager/webhook-cert.yaml
	kubectl apply -f ./cert-manager/kubernetes-api-cert.yaml
