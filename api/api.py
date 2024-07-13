from flask import Flask, jsonify, request
from pprint import pprint

app = Flask(__name__)

# Endpoint POST para printar o body


@app.route('/post_request', methods=['POST'])
def post_request():
    msg = jsonify("success")
    msg.status_code = 200
    request_data = request.get_json()
    pprint(request_data)
    return msg


if __name__ == '__main__':
    app.run(debug=True, port=5555)
