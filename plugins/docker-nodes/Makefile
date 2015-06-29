all: clean zip

clean:
	rm -rf dist
	mkdir dist
zip: 
	mkdir -p dist/docker-nodes
	cp -r src/* dist/docker-nodes
	(cd dist; zip -r ../dist/docker-nodes.zip docker-nodes)

check-env:
ifndef RDECK_BASE
    $(error RDECK_BASE is undefined)
endif

install: zip check-env
	cp dist/docker-nodes.zip $(RDECK_BASE)/libext

