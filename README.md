# ASH Action Test Repository

[![Security Scan with ASH Action](https://github.com/rickardl/ash-action-test/actions/workflows/security-scan.yml/badge.svg)](https://github.com/rickardl/ash-action-test/actions/workflows/security-scan.yml)

This repository demonstrates the [AWS Automated Security Helper (ASH) GitHub Action](https://github.com/rickardl/automated-security-helper-action) security scanning capabilities across multiple technology stacks.

## ⚠️ WARNING: DO NOT DEPLOY

**This repository contains intentional security vulnerabilities for testing purposes. Do not deploy any code or infrastructure from this repository to production or development environments.**

## Purpose

This test repository contains intentional security vulnerabilities across three categories to demonstrate ASH action capabilities:

- **Frontend** (JavaScript/Node.js) - Web application security issues
- **Backend** (Python) - Server-side application vulnerabilities  
- **Infrastructure** (Terraform/CloudFormation) - Infrastructure-as-Code security misconfigurations

## 📁 Repository Structure

```
ash-action-test/
├── frontend/
│   ├── package.json          # Node.js dependencies with vulnerabilities
│   └── app.js                # Express app with security issues
├── backend/
│   ├── app.py                # Flask app with vulnerabilities
│   └── requirements.txt      # Python dependencies
├── infrastructure/
│   ├── main.tf               # Terraform with misconfigurations
│   └── cloudformation.yaml   # CloudFormation with security issues
└── .github/workflows/
    └── security-scan.yml     # ASH action CI/CD configuration
```

## 🔍 Security Issues Included

### Frontend Issues
- **Code Injection**: `eval()` usage with user input
- **SQL Injection**: Unsafe query construction
- **Hardcoded Secrets**: API keys in source code
- **Vulnerable Dependencies**: Outdated packages with known CVEs

### Backend Issues
- **Command Injection**: `subprocess.run()` with shell=True
- **SQL Injection**: Direct string interpolation in queries
- **Path Traversal**: Unsafe file access
- **Hardcoded Credentials**: Database passwords in code
- **Debug Mode**: Flask debug mode enabled in production

### Infrastructure Issues
- **Unencrypted Storage**: S3 buckets and RDS without encryption
- **Overly Permissive Security Groups**: Open to 0.0.0.0/0
- **Public Resources**: Publicly accessible databases
- **Hardcoded Passwords**: Database credentials in templates

## 🚀 CI/CD Configuration

The workflow (`.github/workflows/security-scan.yml`) demonstrates two scanning approaches:

### Matrix Strategy Scan
Scans each category separately with targeted scanners:

```yaml
strategy:
  matrix:
    target:
      - { path: './frontend', scanners: 'semgrep,npm-audit', category: 'frontend' }
      - { path: './backend', scanners: 'bandit,semgrep', category: 'backend' }
      - { path: './infrastructure', scanners: 'checkov,cfn-nag', category: 'infrastructure' }
```

### Comprehensive Scan
Scans the entire repository with all available scanners:

```yaml
- name: Run Comprehensive Security Scan
  uses: rickardl/automated-security-helper-action@v2
  with:
    source-directory: '.'
    output-format: 'both'
    fail-on-findings: false
    severity-threshold: 'low'
```

## 🔧 Scanner Coverage

| Category | Scanners Used | Purpose |
|----------|---------------|---------|
| **Frontend** | `semgrep`, `npm-audit` | JavaScript/TypeScript SAST + dependency scanning |
| **Backend** | `bandit`, `semgrep` | Python security linter + multi-language SAST |
| **Infrastructure** | `checkov`, `cfn-nag` | Terraform/CloudFormation security scanning |
| **Secrets** | `detect-secrets` | Hardcoded credentials detection |

## 📊 Expected Results

When the workflow runs, you should see:

1. **GitHub Security Tab**: SARIF results uploaded automatically
2. **Pull Request Comments**: Inline security findings (if on PR)
3. **Workflow Artifacts**: Detailed scan reports downloadable
4. **Multiple Categories**: Separate results for each scanning strategy

### Sample Findings Count
- **Frontend**: ~3-5 findings (eval usage, hardcoded secrets, vulnerable deps)
- **Backend**: ~4-6 findings (injection flaws, debug mode, credentials)  
- **Infrastructure**: ~5-8 findings (encryption, network security, access control)

## 🛠️ Usage Instructions

### 1. Fork or Clone This Repository
```bash
git clone https://github.com/your-username/ash-action-test.git
cd ash-action-test
```

### 2. Enable GitHub Actions
- Go to repository Settings → Actions → General
- Allow GitHub Actions to run

### 3. Set Required Permissions
The workflow needs these permissions (already configured):
```yaml
permissions:
  contents: read         # Access repository code
  security-events: write # Upload SARIF to Security tab  
  pull-requests: write   # Add PR comments
```

### 4. Trigger a Scan
- **Push to main/develop**: Triggers full scan
- **Create Pull Request**: Triggers scan with PR comments
- **Manual trigger**: Use "Run workflow" button in Actions tab

### 5. Review Results
- **Security Tab**: View uploaded SARIF findings
- **Actions Tab**: Download detailed reports
- **Pull Requests**: See inline security comments

## 🔄 Customization

### Modify Scanner Selection
```yaml
# Only run specific scanners
scanners: 'bandit,semgrep'

# Exclude certain scanners  
exclude-scanners: 'grype,npm-audit'
```

### Adjust Severity Threshold
```yaml
# Only report high/critical issues
severity-threshold: 'high'

# Report all findings
severity-threshold: 'low'
```

### Control Workflow Behavior
```yaml
# Fail builds on findings
fail-on-findings: true

# Continue despite findings (recommended for testing)
fail-on-findings: false
```

## 📚 Learning Resources

- [ASH Action Documentation](https://github.com/rickardl/automated-security-helper-action)
- [AWS Automated Security Helper](https://github.com/awslabs/automated-security-helper)
- [SARIF Format Specification](https://docs.oasis-open.org/sarif/sarif/v2.1.0/sarif-v2.1.0.html)
- [GitHub Security Features](https://docs.github.com/en/code-security)

## ⚠️ Security Warning

**CRITICAL: This repository contains intentional security vulnerabilities. Do not deploy or use this code in any environment.**

- All security issues are synthetic and created for demonstration purposes
- Code is designed to trigger ASH security scanners
- Infrastructure templates contain deliberate misconfigurations
- Use this repository only for testing ASH action functionality

## 🤝 Contributing

Feel free to:
- Add more test cases for different languages
- Improve the CI/CD configuration
- Add additional scanner configurations
- Submit issues or improvements

## 📄 License

This test repository is provided as-is for educational and testing purposes.
