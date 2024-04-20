arch := $(shell uname -m)
repo = booniepepper/factor
tag = linux-x86-64-0.100

.PHONY: build
build:
	docker buildx build . -t $(repo):latest >build.log
	docker buildx build . -t $(repo):$(tag) >>build.log

.PHONY: test
test: build
	docker run $(repo):latest factor -e='1 2 3'

.PHONY: release
release: build test
	docker push $(repo):latest
	docker push $(repo):$(tag)
