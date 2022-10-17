ARG base=flask

FROM ${base}
RUN set -ex; \
apk add --no-cache py3-flake8 pytest
CMD ["flake8 rest_api test; pytest"]
