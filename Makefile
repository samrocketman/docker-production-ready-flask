.PHONY: debug debug-arm exec flask flask-test flaskarm flaskarm-test help serve serve-arm test test-arm

help:
	@echo This is a help document.  Rerun make with one of the following commands.
	@echo
	@echo AMD64 architecture
	@echo '    'make test  - Run tests and coverage.
	@echo '    'make serve - Start web service on localhost:8080
	@echo '    'make debug - Same as make serve but with web server debug logging.
	@echo '    'make flask - Only build docker image.
	@echo
	@echo ARM64 architecture
	@echo '    'make test-arm  - Run tests and coverage.
	@echo '    'make serve-arm - Start web service on localhost:8080
	@echo '    'make debug-arm - Same as make serve but with web server debug logging.
	@echo '    'make flaskarm  - Only build docker image.
	@echo
	@echo All architectures
	@echo '    'make exec - Start a root shell inside of running flask container.
	@false


#
# AMD64 targets
#
test: flask-test
	docker run --rm -u `id -u`:`id -g` -v "$(PWD):/mnt" -w /mnt flask-test

flask-test: flask
	docker build -t flask-test -f test/Dockerfile .

flask:
	docker build --no-cache -t flask .

serve: flask
	docker run -w /app --name flask -e API_HOST=https://api.github.com -p 127.0.0.1:8000:5000 --rm flask

debug: flask
	docker run --name flask -e API_HOST=https://api.github.com/ -e LOGLEVEL=debug -p 127.0.0.1:8000:80 --rm flask

#
# ARM64 targets
#
test-arm: flaskarm-test
	docker run --rm -u `id -u`:`id -g` -v "$(PWD):/mnt" -w /mnt flaskarm-test

flaskarm:
	docker buildx build --platform linux/arm64 --build-arg base=arm64v8/alpine -t flaskarm .

flaskarm-test: flaskarm
	docker buildx build --platform linux/arm64 --build-arg base=flaskarm -t flaskarm-test -f test/Dockerfile .
serve-arm: flaskarm
	docker run --name flask -p 127.0.0.1:8080:80 --rm flask

debug-arm: flaskarm
	docker run --name flask -e LOGLEVEL=debug -p 127.0.0.1:8080:80 --rm flask

exec:
	docker exec -itu root flask /bin/sh
