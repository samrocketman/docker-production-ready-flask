import pytest
from rest_api import app
# See also https://flask.palletsprojects.com/en/2.2.x/testing/


@pytest.fixture()
def client():
    return app.test_client()


@pytest.fixture()
def runner(app):
    return app.test_cli_runner()


def test_request_example(client):
    response = client.get("/")
    assert b"""{"email":"alice@outlook.com","name":"alice"}""" in response.data
