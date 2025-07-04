module.exports = {
    "env": {
        "browser": true,
        "commonjs": true,
        "es2021": true,
        "node": true
    },
    "extends": "eslint:recommended",
    "parserOptions": {
        "ecmaVersion": 12
    },
    "rules": {
        // Intentionally permissive for testing
        "no-eval": "off",
        "no-unused-vars": "warn"
    }
};