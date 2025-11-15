# Installation

This guide covers general installation concepts for IQToolkit tools. For tool-specific installation instructions, visit the individual tool documentation pages.

## Overview

IQToolkit is a collection of independent tools rather than a single package. Each tool:
- Can be installed and used separately
- Has its own specific requirements
- Follows consistent installation patterns

## Available Tools

Visit our [Tools section](/tools/) to see all available tools and their specific installation instructions:

- **[Slow Query Doctor](/tools/slow-query-doctor/)** - AI-powered PostgreSQL slow query analysis
- *More tools coming soon...*

## General Requirements

Most IQToolkit tools have similar requirements:

- **Python**: 3.11+ (Python 3.12+ recommended) 
- **pip**: For package installation
- **Operating System**: Windows, macOS, or Linux
- **Dependencies**: Varies by tool (automatically handled by pip)

## Best Practices

### Use pip for Installation

We recommend using **pip** for installing IQToolkit tools because:

- ✅ **Universal**: Works on all platforms and Python installations
- ✅ **Standard**: The official Python package manager
- ✅ **Dependency Management**: Automatically handles dependencies
- ✅ **Virtual Environment Support**: Works seamlessly with venv
- ✅ **Version Control**: Easy to specify exact versions

### Virtual Environments

Always use virtual environments for better isolation:

```bash
# Create virtual environment
python -m venv iqtoolkit-env

# Activate (Linux/macOS)
source iqtoolkit-env/bin/activate

# Activate (Windows)
iqtoolkit-env\Scripts\activate

# Install tools
pip install slow-query-doctor

# Deactivate when done
deactivate
```

## Installation Methods

Most IQToolkit tools support multiple installation methods:

### 1. Package Manager (Recommended)
```bash
# Using pip (most common)
pip install tool-name

# Using conda (when available)
conda install -c conda-forge tool-name
```

### 2. From Source
```bash
# Clone and install for development
git clone https://github.com/iqtoolkit/tool-name.git
cd tool-name
pip install -e .
```

### 3. Container Deployment
Many tools provide Docker images for containerized deployment.

## Getting Help

If you encounter installation issues:

1. **Check tool-specific documentation** for detailed troubleshooting
2. **Visit the tool's GitHub repository** for issues and support  
3. **Use [GitHub Discussions](https://github.com/orgs/iqtoolkit/discussions)** for community help

## Next Steps

- **[Getting Started](/guide/getting-started)** - Learn how to choose and use tools
- **[Tools Overview](/tools/)** - Browse available tools and their installation guides

