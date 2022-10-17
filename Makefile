.PHONY: debug exec flask flask-test serve test

test: flask-test
	docker run --rm -u `id -u`:`id -g` -v "$(PWD):/mnt" -w /mnt flask-test

flask-test: flask
	docker build -t flask-test -f test/Dockerfile .

flask:
	docker build -t flask .

serve: flask
	docker run --name flask -p 127.0.0.1:8080:80 --rm flask

debug: flask
	docker run --name flask -e LOGLEVEL=debug -p 127.0.0.1:8080:80 --rm flask

exec:
	docker exec -itu root flask /bin/sh
