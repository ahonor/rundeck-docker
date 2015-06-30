all: clean zip

clean:
	rm -rf dist
	mkdir dist
zip: 
	mkdir -p dist/docker-command
	cp -r src/* dist/docker-command
	(cd dist; zip -r ../dist/docker-command.zip docker-command)

check-env:
ifndef RDECK_BASE
    $(error RDECK_BASE is undefined)
endif

install: zip check-env
	cp dist/docker-command.zip $(RDECK_BASE)/libext

