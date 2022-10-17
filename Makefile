.PHONY: debug exec flask flask-test serve test

test: flask-test
	docker run --rm -u `id -u`:`id -g` -v "$(PWD):/mnt" -w /mnt flask-test

test-arm:
	docker run --rm -u `id -u`:`id -g` -v "$(PWD):/mnt" -w /mnt flaskarm-test

flask-test: flask
	docker build -t flask-test -f test/Dockerfile .

flask:
	docker build -t flask .

flaskarm:
	docker buildx build --platform linux/arm64 --build-arg base=arm64v8/alpine -t flaskarm .

flaskarm-test:
	docker buildx build --platform linux/arm64 --build-arg base=flaskarm -t flaskarm-test -f test/Dockerfile .

serve: flask
	docker run --name flask -p 127.0.0.1:8080:80 --rm flask

debug: flask
	docker run --name flask -e LOGLEVEL=debug -p 127.0.0.1:8080:80 --rm flask

exec:
	docker exec -itu root flask /bin/sh
