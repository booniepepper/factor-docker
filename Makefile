arch := $(shell uname -m)
tag = booniepepper/factor:latest

.PHONY: build
build:
	docker buildx build . -t $(tag) >build.log

.PHONY: test
test: build
	docker run $(tag)

.PHONY: release
release: build test
	docker push $(tag)
