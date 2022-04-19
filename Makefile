USER=lmestar
BASE_CONTAINER_NAME=dlog2csv-base
BASE_IMAGE=$(USER)/$(BASE_CONTAINER_NAME):0.1

args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

all: run 

build:
	docker build -t $(BASE_IMAGE) .

run:
	docker run -it --rm \
	-v $(PWD)/output:/app/output \
	--name $(USER) \
	--name $(BASE_CONTAINER_NAME) $(BASE_IMAGE) $(call args)

push:
	docker push $(BASE_IMAGE)