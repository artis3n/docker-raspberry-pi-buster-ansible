#!/usr/bin/env make

.PHONY: lint
lint:
	hadolint --ignore DL3008 --ignore DL3013 Dockerfile

.PHONY: size
size: build
	if [ ! -f /usr/local/bin/dive ]; then brew install dive; fi;
	dive artis3n/docker-raspberry-pi-buster-ansible:$${TAG:-test}

.PHONY: test
test: build
	dgoss run -it --rm --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro artis3n/docker-raspberry-pi-buster-ansible:$${TAG:-test}
	# CI=true make size

.PHONY: test-edit
test-edit: build
	dgoss edit -it --rm --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro artis3n/docker-raspberry-pi-buster-ansible:$${TAG:-test}

.PHONY: build
build:
	docker build --platform linux/arm64 . -t artis3n/docker-raspberry-pi-buster-ansible:$${TAG:-test}

.PHONY: run
run: build
	docker run -id --rm --name runner --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro artis3n/docker-raspberry-pi-buster-ansible:$${TAG:-test}
	-docker exec -it runner /bin/sh
	docker stop runner
