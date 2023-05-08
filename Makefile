.PHONY: build

GO_SRC := $(shell find -type f -name "*.go")

all: vet test email

# Simple go build
build: $(GO_SRC)
	CGO_ENABLED=0 GOOS=linux  GOARCH=amd64 go build -a -ldflags "-extldflags '-static' -X main.Version=$(shell git describe --long --dirty)" -o build/email.linux.amd64 .
	CGO_ENABLED=0 GOOS=linux  GOARCH=arm   go build -a -ldflags "-extldflags '-static' -X main.Version=$(shell git describe --long --dirty)" -o build/email.linux.arm64 .
	CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -a -ldflags "-extldflags '-static' -X main.Version=$(shell git describe --long --dirty)" -o build/email.darwin.arm64 .

vet:
	go vet .

test:
	go test -v .

.PHONY: test vet
