.PHONY: all deps test build benchmark coveralls

DEP_VERSION=0.4.1
OS := $(shell uname | tr '[:upper:]' '[:lower:]')

prepare:
	@echo "Install pre-commit via Homebrew..."
	brew install pre-commit

	@echo "Initializing environment for git..."
	pre-commit install -t pre-commit
	pre-commit install -t pre-push
	pre-commit install -t commit-msg

	@echo "Installing dep..."
	@curl -L -s https://github.com/golang/dep/releases/download/v${DEP_VERSION}/dep-${OS}-amd64 -o ${GOPATH}/bin/dep
	@chmod a+x ${GOPATH}/bin/dep

	@echo "Installing goconvey"
	go get github.com/smartystreets/goconvey

	@echo "Installing richgo"
	go get -u github.com/kyoh86/richgo

	@echo "Installing realize"
	go get github.com/oxequa/realize

	@echo "Installing golangci-lint"
	go get github.com/golangci/golangci-lint/cmd/golangci-lint

	@echo "Installing go-critic"
	go get github.com/go-critic/go-critic/...

deps:
	@echo "Setting up the vendors folder..."
	@dep ensure -v
	@echo ""
	@echo "Resolved dependencies:"
	@dep status
	@echo ""

cover:
	@echo "Running coverage"
	${GOPATH}/bin/goconvey

test:
	@echo "Running test"
	${GOPATH}/bin/richgo test ./... -v

up:
	@echo "Running chat's service with database and cache"
	docker-compose up

down:
	@echo "Goodbye~"
	docker-compose down

ssh:
	@echo "Now, we're going to chat-app..."
	docker exec -it chat-app sh
