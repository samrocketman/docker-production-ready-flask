# Purpose

Create the smallest feasible Docker container for a Python flask app using a
production-ready WSGI server.

Follow Python, Flask, and Docker best practices:

- Python
  - Flake8 formatted code.
  - Organize code into modules.
  - Unit tests with pytest.
  - Code coverage report generated from unit tests.
- Flask
  - Run Flask from a production WSGI server; Apache httpd
  - Web server supports HTTP/2.
- Docker
  - PID 1 init program to handle process signals and child processes.
  - Web server starts in foreground.
  - Web server logs to stdout and stderr to be handled by Docker instead of
    writing logs to disk.

# Running Docker container

The resulting Docker image is `flask`.  To build and start web service run the
following.

    make serve

Open in a web browser:

* http://localhost:8080 to see the JSON API response.
* http://localhost:8080/media/example.txt example asset

Run tests with

    make test

# ARM image support

The restulting Docker image is `flaskarm`.

Building an arm image from an amd64 machines (in my case Ubuntu) requires some
extra packages to be installed on the host.

    sudo apt install -y qemu-user-static binfmt-support

Then, you can run the ARM version of the flask app.

    make serve-arm

Tests can be run as well.

    make test-arm

# Result

Flask app running apache2 runs as a normal user (`apache`) via wsgi.  Final
container size is just under 62MB.

Complete with unit testing and 100% test coverage.

# License

CC0 or Public Domain
