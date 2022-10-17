from flask import Flask, jsonify


app = Flask(__name__)


@app.route('/')
def index():
    return jsonify({'name': 'alice', 'email': 'alice@outlook.com'})
