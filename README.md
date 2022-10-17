# Purpose

Create the smallest feasible Docker container for a Python flask app using a
production-ready WSGI server.

Follow docker best practices:

- Smart init program to handle proces signals.
- Web server starts in foreground with HTTP/2 support.
- Web server logs to stdout and stderr to be handled by Docker instead of
  writing to disk.

# Building Container

    docker build -t flask .

# Running Docker container

    docker run -p localhost:8080:80 --rm flask

or alternately with extra debug logging.

    docker run -e LOGLEVEL=debug -p localhost:8080:80 --rm flask

# Visit the website

Open http://localhost:8080 to see the JSON API response.

See example asset at http://localhost:8080/media/example.txt

# ARM image support

Building an arm image from an amd64 machines (in my case Ubuntu) requires some
extra packages to be installed on the host.

    sudo apt install -y qemu-user-static binfmt-support

Then, you can build the ARM version of the flask app.

    docker buildx build --platform linux/arm64 --build-arg base=arm64v8/alpine -t flaskarm .

# Result

Flask app running apache2 runs as a normal user (`apache`) via wsgi.  Final
container size is just under 62MB.

Complete with unit testing and 100% test coverage.

# License

CC0 or Public Domain
