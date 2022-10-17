# Purpose

Create the smallest feasible Docker container for a Python flask app using a
production-ready WSGI server.

Follow Docker best practices:

- Smart init program to handle proces signals.
- Web server starts in foreground with HTTP/2 support.
- Web server logs to stdout and stderr to be handled by Docker instead of
  writing to disk.

# Running Docker container

The resulting Docker image is `flask`.  To build and start web service run the
following.

    make serve

or alternately with extra debug logging.

    make debug


Open in a web browser:

* http://localhost:8080 to see the JSON API response.
* http://localhost:8080/media/example.txt example asset

# ARM image support

The restulting Docker image is `flaskarm`.

Building an arm image from an amd64 machines (in my case Ubuntu) requires some
extra packages to be installed on the host.

    sudo apt install -y qemu-user-static binfmt-support

Then, you can build the ARM version of the flask app.

    make test-arm


# Result

Flask app running apache2 runs as a normal user (`apache`) via wsgi.  Final
container size is just under 62MB.

Complete with unit testing and 100% test coverage.

# License

CC0 or Public Domain
