# Testing Guide

This guide covers how to test the IQToolkit documentation system locally and in production.

## Prerequisites

Before testing, ensure you have:

- **Node.js 18+** and **npm**
- **Git** for cloning repositories
- **Make** (usually pre-installed on Unix systems)

## Quick Start Testing

### 1. Complete Setup and Test

```bash
# Clone the repository
git clone https://github.com/iqtoolkit/docs.iqtoolkit.ai.git
cd docs.iqtoolkit.ai

# Run complete setup and testing
make setup
make test
```

### 2. Start Development

```bash
# Start development server with live reload
make dev

# Visit http://localhost:5173 to view the documentation
```

## Make Commands Reference

Our Makefile provides convenient commands for all testing scenarios:

### Setup Commands
```bash
make help          # Show all available commands
make setup         # Complete first-time setup
make install       # Install npm dependencies only
make check-deps    # Verify system dependencies
```

### Documentation Sync Commands
```bash
make sync          # Sync docs from tool repositories
make sync-clean    # Clean temp files and sync
make test-sync     # Test sync process and verify results
```

### Development Commands
```bash
make dev           # Start development server
make build         # Build for production
make preview       # Preview production build locally
make serve         # Serve built documentation
```

### Testing Commands
```bash
make test          # Run all tests
make test-deps     # Test system dependencies
make test-sync     # Test documentation sync
make test-build    # Test build process
make test-links    # Test for broken links
make test-ci       # Run CI-like tests
make validate      # Validate configuration
```

### Maintenance Commands
```bash
make clean         # Clean all generated files
make clean-cache   # Clean only caches
make status        # Show project status
```

### Deployment Commands
```bash
make commit MSG="your message"  # Commit and push changes
make deploy        # Deploy to GitHub Pages
```

## Manual Testing Procedures

### 1. Test Documentation Sync

```bash
# Test the sync script manually
make test-sync

# Check what was synced
ls -la docs/tools/
cat docs/tools/slow-query-analyzer/.sync-info
```

**Expected Results:**
- `docs/tools/slow-query-analyzer/` directory exists
- Contains markdown files from the source repository
- `.sync-info` file contains metadata about the sync

### 2. Test Development Server

```bash
# Start development server
make dev
```

**Manual Tests:**
1. Visit `http://localhost:5173`
2. Test navigation: Home → Guide → Tools
3. Visit `/tools/slow-query-analyzer/`
4. Test search functionality
5. Check mobile responsiveness
6. Verify all links work

### 3. Test Build Process

```bash
# Test production build
make test-build

# Check build output
ls -la docs/.vitepress/dist/
```

**Expected Results:**
- Build completes without errors
- `docs/.vitepress/dist/` contains generated HTML files
- All assets are properly bundled

### 4. Test Configuration

```bash
# Validate all configuration files
make validate
```

**Expected Results:**
- `package.json` is valid
- VitePress config loads correctly
- Scripts have proper permissions

## Automated Testing

### GitHub Actions Testing

The repository includes automated testing via GitHub Actions:

1. **Push to main branch** triggers the deployment workflow
2. **Daily schedule** syncs docs automatically
3. **Manual dispatch** allows on-demand testing

### Local CI Testing

```bash
# Simulate CI environment locally
make test-ci
```

This runs a clean test from scratch, similar to CI.

## Common Testing Scenarios

### Testing New Tool Addition

1. **Add repository to sync script:**
   ```bash
   # Edit scripts/sync-docs.sh
   REPOS=(
     "iqtoolkit/slow-query-analyzer:docs:slow-query-analyzer"
     "iqtoolkit/new-tool:docs:new-tool"  # Add this
   )
   ```

2. **Test the sync:**
   ```bash
   make test-sync
   ```

3. **Update navigation:**
   ```bash
   # Edit docs/.vitepress/config.js sidebar configuration
   ```

4. **Test locally:**
   ```bash
   make dev
   # Visit /tools/new-tool/ to verify
   ```

### Testing Documentation Updates

1. **Sync latest docs:**
   ```bash
   make sync-clean
   ```

2. **Verify changes:**
   ```bash
   make dev
   # Check that updates appear correctly
   ```

### Testing Deployment

1. **Test build process:**
   ```bash
   make test-build
   ```

2. **Deploy to staging:**
   ```bash
   make commit MSG="test: verify deployment"
   ```

3. **Monitor GitHub Actions** for deployment status

## Troubleshooting

### Common Issues

#### Sync Script Fails
```bash
# Check git configuration
git config --list

# Ensure script is executable
chmod +x scripts/sync-docs.sh

# Test manually
bash scripts/sync-docs.sh
```

#### Build Fails
```bash
# Clean and retry
make clean
make install
make build
```

#### Dependencies Missing
```bash
# Check system dependencies
make check-deps

# Install Node.js if needed
# Install git if needed
```

### Debug Commands

```bash
# Show detailed project status
make status

# Check npm dependencies
npm list

# Verify VitePress config
node -e "console.log(require('./docs/.vitepress/config.js'))"
```

## Performance Testing

### Build Performance
```bash
# Time the build process
time make build

# Check build size
make build && du -sh docs/.vitepress/dist
```

### Sync Performance
```bash
# Time the sync process
time make sync

# Check temp directory size
make sync && du -sh temp-repos/
```

## Integration Testing

### Testing with Real Repositories

1. **Verify repository access:**
   ```bash
   git clone https://github.com/iqtoolkit/slow-query-analyzer.git test-clone
   ls test-clone/docs/
   rm -rf test-clone
   ```

2. **Test sync with different repository structures:**
   - Repositories with `/docs` folders
   - Repositories without documentation
   - Private vs public repositories

### Testing Documentation Quality

1. **Check for broken links:**
   ```bash
   make test-links
   ```

2. **Validate markdown:**
   ```bash
   # Use tools like markdownlint if needed
   npm install -g markdownlint-cli
   markdownlint docs/**/*.md
   ```

3. **Test accessibility:**
   - Use browser developer tools
   - Test with screen readers
   - Verify color contrast

## Continuous Testing

### Pre-commit Testing

```bash
# Add to your workflow
make test
git add .
git commit -m "your changes"
```

### Automated Testing Schedule

The GitHub Actions workflow runs:
- **On every push** to main branch
- **Daily at 2 AM UTC** for doc updates
- **On manual trigger** for testing

## Next Steps

After testing locally:

1. **Submit pull requests** for any changes
2. **Monitor GitHub Actions** for automated testing
3. **Verify production deployment** at docs.iqtoolkit.ai
4. **Set up monitoring** for the live site

For more information, see the [deployment documentation](https://github.com/iqtoolkit/docs.iqtoolkit.ai) and [contributing guidelines](https://github.com/iqtoolkit).