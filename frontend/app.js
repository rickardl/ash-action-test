// Simple Express app with potential security issues for testing
const express = require('express');
const app = express();

// Potential security issue: eval usage
app.get('/eval', (req, res) => {
    const userInput = req.query.code;
    const result = eval(userInput); // Security vulnerability
    res.send(`Result: ${result}`);
});

// Potential security issue: SQL injection vulnerability
app.get('/user/:id', (req, res) => {
    const userId = req.params.id;
    const query = `SELECT * FROM users WHERE id = ${userId}`; // SQL injection
    res.send(`Query: ${query}`);
});

// Hardcoded secret
const API_KEY = "sk-1234567890abcdef"; // Secret detection test

app.listen(3000, () => {
    console.log('Server running on port 3000');
});