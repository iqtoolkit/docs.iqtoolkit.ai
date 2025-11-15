# Configuration

This guide covers general configuration concepts that apply across IQToolkit tools. Each tool may have its own specific configuration requirements - refer to individual tool documentation for detailed configuration options.

## General Configuration Principles

Most IQToolkit tools follow similar configuration patterns:

### 1. Configuration Files

Tools typically support configuration through:

1. Tool-specific config files (e.g., `tool-name.config.json`)
2. Command-line arguments
3. Environment variables
4. Default settings

### 2. Common Configuration Patterns

#### JSON Configuration Example
```json
{
  "logging": {
    "level": "info",
    "file": "./logs/tool.log"
  },
  "output": {
    "format": "json",
    "verbose": true
  }
}
```

#### Environment Variables
```bash
export TOOL_LOG_LEVEL=debug
export TOOL_OUTPUT_FORMAT=csv
```

#### Command Line Arguments
```bash
tool-name --log-level debug --output-format csv --verbose
```

## Tool-Specific Configuration

Each tool in the IQToolkit ecosystem has its own configuration requirements. Visit the individual tool documentation for detailed configuration options:

- **[Slow Query Doctor](/tools/slow-query-doctor/)** - PostgreSQL connection settings, AI analysis parameters, performance thresholds
- *More tools coming soon...*

## Best Practices

1. **Use configuration files** for complex setups
2. **Use environment variables** for deployment-specific settings
3. **Use command-line arguments** for one-time operations
4. **Document your configuration** for team members
5. **Version control your config files** (excluding sensitive data)

## Security Considerations

- **Never commit sensitive data** (passwords, API keys) to version control
- **Use environment variables** for sensitive configuration
- **Set appropriate file permissions** on configuration files
- **Consider using secret management tools** for production deployments

## Next Steps

- **[Browse Tools](/tools/)** - Explore specific tool configurations
- **[Installation Guide](/guide/installation)** - Learn about tool setup
- **[Getting Started](/guide/getting-started)** - Start using IQToolkit tools