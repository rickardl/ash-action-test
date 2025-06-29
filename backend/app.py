#!/usr/bin/env python3
"""
Backend Python application with intentional security issues for ASH testing
"""

import os
import sqlite3
import subprocess

from flask import Flask, request

app = Flask(__name__)

# Hardcoded credentials - should be detected by secrets scanners
DATABASE_PASSWORD = "super_secret_password_123"
API_TOKEN = "token_abcdef123456789"


@app.route("/execute")
def execute_command():
    """Command injection vulnerability"""
    cmd = request.args.get("cmd", "ls")
    # Security issue: shell injection
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    return result.stdout


@app.route("/user/<user_id>")
def get_user(user_id):
    """SQL injection vulnerability"""
    conn = sqlite3.connect("users.db")
    cursor = conn.cursor()
    # Security issue: SQL injection
    query = f"SELECT * FROM users WHERE id = {user_id}"
    cursor.execute(query)
    result = cursor.fetchall()
    conn.close()
    return str(result)


@app.route("/file")
def read_file():
    """Path traversal vulnerability"""
    filename = request.args.get("file", "default.txt")
    # Security issue: path traversal
    with open(filename, "r") as f:
        content = f.read()
    return content


if __name__ == "__main__":
    # Security issue: debug mode in production
    app.run(debug=True, host="0.0.0.0")

