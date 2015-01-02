NAME=benbreen/niftyspacesite
VERSION=$(shell git describe 2> /dev/null || echo 'g'`git rev-parse --short HEAD`)
CORE_VERSION=HEAD

all: prepare build

prepare:
#    git archive -o docker/echoapp.tar HEAD

build:
#   docker build -t niftyspacesite .
	docker build -t $(NAME):$(VERSION) .

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

test:
#    nosetests -sv

push:
	docker push $(NAME):$(VERSION)
