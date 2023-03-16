.PHONY: build
build:
	mkdir -p ./bin
	go build -o ./bin

.PHONY: build-image
build-image-kind:
	docker build -t <USERNAME>/mutating-webhook:latest .

.PHONY: push-image
push-kind:
	docker push <USERNAME>/mutating-webhook:latest
