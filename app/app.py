#!/usr/bin/env python3
"""DevOps student application.

Prints student information taken from environment variables.
RUN_ONCE=true  -> print and exit with code 0 (used by Jenkins).
otherwise      -> also serve the same information over HTTP on APP_PORT (5000).
"""
import os
import signal
import sys
from http.server import BaseHTTPRequestHandler, HTTPServer

DEFAULTS = {
    "STUDENT_NAME": "Nooruzbek",
    "STUDENT_SURNAME": "Toktobaev",
    "STUDENT_GROUP": "IT-2 2313",
    "STUDENT_ID": "38422",
}
LINE = "=" * 32


def get_student_info(env=None):
    """Return student data from environment variables, falling back to defaults."""
    env = os.environ if env is None else env
    return {key: env.get(key, default) for key, default in DEFAULTS.items()}


def render(info):
    """Build the text block shown in the console and over HTTP."""
    return "\n".join([
        LINE,
        "DevOps Student Application",
        LINE,
        f"Name: {info['STUDENT_NAME']}",
        f"Surname: {info['STUDENT_SURNAME']}",
        f"Group: {info['STUDENT_GROUP']}",
        f"Student ID: {info['STUDENT_ID']}",
        "Application is running successfully!",
    ])


class StudentHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = (render(get_student_info()) + "\n").encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        print(f"Request received: {self.command} {self.path} from {self.client_address[0]}", flush=True)


def stop(signum, frame):
    print("Application stopped (signal received)", flush=True)
    sys.exit(0)


def main():
    print(render(get_student_info()), flush=True)

    if os.environ.get("RUN_ONCE", "false").lower() == "true":
        return 0

    port = int(os.environ.get("APP_PORT", "5000"))
    signal.signal(signal.SIGTERM, stop)  # make `docker stop` fast and clean
    server = HTTPServer(("0.0.0.0", port), StudentHandler)
    print(f"HTTP server is listening on port {port}", flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass
    finally:
        server.server_close()
    return 0


if __name__ == "__main__":
    sys.exit(main())
