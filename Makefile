DISTRO ?= jessie

.PHONY: build
build:
	docker build -f Dockerfile.$(DISTRO) --rm --force-rm -t go-shim:$(DISTRO) .

.PHONY: run
run:
	@echo "running hello world in $(DISTRO):"
	@docker run --rm -it go-shim:$(DISTRO)