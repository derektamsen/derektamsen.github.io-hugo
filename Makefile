.PHONY: all
all: server

.PHONY: server
server:
	@hugo server -D

.PHONY: update-deps
update-deps:
	@hugo mod get -u
	@hugo mod tidy
