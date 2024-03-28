from flask import Flask, request, make_response
# from werkzeug.middleware.proxy_fix import ProxyFix

app = Flask(__name__)
# if __name__ == '__main__':
#     app = Flask(__name__)
#     app.run(debug=True)
    # app running via a proxy
    # app.wsgi_app = ProxyFix(
    # app.wsgi_app, x_for=1, x_proto=1, x_ip=1)

@app.route('/')
def index():
    content = "It's easier to ask forgiveness than it is to get permission."
    fwd_for = "X-Forwarded-For: {}".format(
        request.headers.get('x-forwarded-for', None)
    )
    real_ip = "X-Real-IP: {}".format(
        request.headers.get('x-real-ip', None)
    )
    fwd_proto = "X-Forwarded-Proto: {}".format(
        request.headers.get('x-forwarded-proto', None)
    )

    output = "\n".join([content, fwd_for, real_ip, fwd_proto])
    
    response = make_response(output, 200)
    response.headers["Content-Type"] = "text/plain"

    return response