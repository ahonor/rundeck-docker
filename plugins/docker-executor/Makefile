all: clean zip

clean:
	rm -rf dist
	mkdir dist
zip: 
	mkdir -p dist/docker-executor
	cp -r src/* dist/docker-executor
	(cd dist; zip -r ../dist/docker-executor.zip docker-executor)

check-env:
ifndef RDECK_BASE
    $(error RDECK_BASE is undefined)
endif

install: zip check-env
	cp dist/docker-executor.zip $(RDECK_BASE)/libext

