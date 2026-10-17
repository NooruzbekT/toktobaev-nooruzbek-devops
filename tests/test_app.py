"""Unit tests for app/app.py (standard library unittest only)."""
import contextlib
import importlib.util
import io
import os
import threading
import unittest
import urllib.request
from http.server import HTTPServer
from unittest import mock

APP_PATH = os.path.join(os.path.dirname(__file__), "..", "app", "app.py")
spec = importlib.util.spec_from_file_location("student_app", APP_PATH)
app = importlib.util.module_from_spec(spec)
spec.loader.exec_module(app)


class StudentInfoTest(unittest.TestCase):
    def test_defaults_are_used_without_env(self):
        info = app.get_student_info({})
        self.assertEqual(info["STUDENT_NAME"], "Nooruzbek")
        self.assertEqual(info["STUDENT_SURNAME"], "Toktobaev")
        self.assertEqual(info["STUDENT_GROUP"], "IT-2 2313")
        self.assertEqual(info["STUDENT_ID"], "38422")

    def test_env_overrides_defaults(self):
        info = app.get_student_info({"STUDENT_GROUP": "TEST"})
        self.assertEqual(info["STUDENT_GROUP"], "TEST")
        self.assertEqual(info["STUDENT_NAME"], "Nooruzbek")

    def test_render_contains_all_lines(self):
        text = app.render(app.get_student_info({}))
        self.assertIn("DevOps Student Application", text)
        self.assertIn("Group: IT-2 2313", text)
        self.assertIn("Student ID: 38422", text)
        self.assertTrue(text.endswith("Application is running successfully!"))


class MainTest(unittest.TestCase):
    def test_run_once_prints_and_exits_with_zero(self):
        out = io.StringIO()
        with mock.patch.dict(os.environ, {"RUN_ONCE": "true", "STUDENT_ID": "38422"}), \
                contextlib.redirect_stdout(out):
            code = app.main()
        self.assertEqual(code, 0)
        self.assertIn("Student ID: 38422", out.getvalue())


class HttpServerTest(unittest.TestCase):
    def test_http_get_returns_student_info(self):
        server = HTTPServer(("127.0.0.1", 0), app.StudentHandler)
        thread = threading.Thread(target=server.serve_forever, daemon=True)
        thread.start()
        try:
            with contextlib.redirect_stdout(io.StringIO()):
                url = f"http://127.0.0.1:{server.server_port}/"
                with urllib.request.urlopen(url, timeout=5) as resp:
                    body = resp.read().decode("utf-8")
                    status = resp.status
        finally:
            server.shutdown()
            server.server_close()
        self.assertEqual(status, 200)
        self.assertIn("Name: Nooruzbek", body)


if __name__ == "__main__":
    unittest.main()
