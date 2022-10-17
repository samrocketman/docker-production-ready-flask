.PHONY: test flask-test flask

test: flask-test
	docker run --rm -u `id -u`:`id -g` -v "$(PWD):/mnt" -w /mnt flask-test

flask-test: flask
	docker build -t flask-test -f test/Dockerfile .

flask:
	docker build -t flask .
