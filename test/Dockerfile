ARG base=flask

FROM ${base}
RUN set -ex; \
apk add --no-cache py3-coverage py3-flake8 py3-pytest-cov pytest

CMD ["flake8 rest_api test; pytest --junitxml=results.xml --cov=rest_api --cov-report=xml --cov-config=test/coverage.ini --cov-branch"]
