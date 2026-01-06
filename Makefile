APP      := goserver
VERSION  := $(shell git describe --tags --always --dirty)
OUTDIR   := dist

LDFLAGS  := -s -w -X main.version=$(VERSION)

PLATFORMS := \
	linux/amd64 \
	linux/arm64 \
	darwin/amd64 \
	darwin/arm64

.PHONY: all clean build

all: build

build:
	@mkdir -p $(OUTDIR)
	@for p in $(PLATFORMS); do \
		GOOS=$${p%/*} GOARCH=$${p#*/} \
		go build -ldflags "$(LDFLAGS)" \
		-o $(OUTDIR)/$(APP)-$${p%/*}-$${p#*/} ; \
		echo "built $(APP)-$${p%/*}-$${p#*/}"; \
	done

clean:
	rm -rf $(OUTDIR)
