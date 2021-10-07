# Git variables

GIT_REPOSITORY_NAME := $(shell basename `git rev-parse --show-toplevel`)
GIT_VERSION := $(shell git describe --always --tags --long --dirty | sed -e 's/\-0//' -e 's/\-g.......//')

# Docker variables

DOCKER_IMAGE_TAG ?= $(GIT_REPOSITORY_NAME):$(GIT_VERSION)
DOCKER_IMAGE_NAME := docktermj/fpm

# -----------------------------------------------------------------------------
# The first "make" target runs as default.
# -----------------------------------------------------------------------------

.PHONY: default
default: help

# -----------------------------------------------------------------------------
# Docker-based builds
# -----------------------------------------------------------------------------

.PHONY: docker-build
docker-build:
	docker build \
		--tag $(DOCKER_IMAGE_NAME) \
		--tag $(DOCKER_IMAGE_NAME):$(GIT_VERSION) \
		.
		
.PHONY: docker-build-2
docker-build-2:
	docker build \
		--tag $(DOCKER_IMAGE_NAME) \
		--tag $(DOCKER_IMAGE_NAME):$(GIT_VERSION) \
		--file Dockerfile2 \
		.		

.PHONY: docker-build-3
docker-build-3:
	docker build \
		--tag $(DOCKER_IMAGE_NAME) \
		--tag $(DOCKER_IMAGE_NAME):$(GIT_VERSION) \
		--file Dockerfile3 \
		.		
		
.PHONY: docker-build-4
docker-build-4:
	docker build \
		--tag $(DOCKER_IMAGE_NAME) \
		--tag $(DOCKER_IMAGE_NAME):$(GIT_VERSION) \
		--file Dockerfile4 \
		.	
				
# -----------------------------------------------------------------------------
# Clean up targets
# -----------------------------------------------------------------------------

.PHONY: docker-rmi-for-build
docker-rmi-for-build:
	-docker rmi --force \
		$(DOCKER_IMAGE_NAME):$(GIT_VERSION) \
		$(DOCKER_IMAGE_NAME)

.PHONY: clean
clean: docker-rmi-for-build

.PHONY: print-make-variables
print-make-variables:
	@$(foreach V,$(sort $(.VARIABLES)), \
	   $(if $(filter-out environment% default automatic, \
	   $(origin $V)),$(warning $V=$($V) ($(value $V)))))
	   
# -----------------------------------------------------------------------------
# Help
# -----------------------------------------------------------------------------

.PHONY: help
help:
	@echo "All targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
