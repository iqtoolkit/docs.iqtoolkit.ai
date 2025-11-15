# docs.iqtoolkit.ai

Comprehensive documentation hub for the IQToolkit open-source ecosystem.

## 🚀 Features

- **Automated Documentation Sync** - Pulls documentation from individual tool repositories
- **VitePress-Powered** - Fast, modern documentation site with excellent performance
- **GitHub Pages Deployment** - Automatically deploys to `docs.iqtoolkit.ai`
- **Multi-Repository Support** - Aggregates docs from multiple tool repositories
- **Search & Navigation** - Built-in search and intuitive navigation

## 📖 Local Development

### Prerequisites

- Node.js 18+ 
- npm (recommended over yarn)
- Git

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/iqtoolkit/docs.iqtoolkit.ai.git
   cd docs.iqtoolkit.ai
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Sync documentation from tool repositories**
   ```bash
   npm run sync-docs
   ```

4. **Start development server**
   ```bash
   npm run dev
   ```

5. **Visit** [http://localhost:5173](http://localhost:5173)

### Building for Production

```bash
npm run build
```

The built site will be in `docs/.vitepress/dist/`

## 🧪 Testing

We've included a comprehensive Makefile to make testing easy:

### Quick Start Testing

```bash
# Complete setup and test
make setup
make test

# Start development server
make dev
```

### Available Make Commands

```bash
make help          # Show all available commands
make setup         # Complete setup: install deps and sync docs
make install       # Install npm dependencies  
make sync          # Sync documentation from tool repositories
make dev           # Start development server
make build         # Build for production
make test          # Run all tests
make clean         # Clean all generated files
make deploy        # Deploy to GitHub Pages
make status        # Show project status
```

### Manual Testing Steps

1. **Test Dependencies**
   ```bash
   make check-deps
   ```

2. **Test Documentation Sync**
   ```bash
   make test-sync
   # This will clone tool repos and verify docs are copied correctly
   ```

3. **Test Build Process**
   ```bash
   make test-build
   # Ensures VitePress can build the site successfully
   ```

4. **Test Development Server**
   ```bash
   make dev
   # Visit http://localhost:5173 and test navigation
   ```

### What to Test

- ✅ All navigation links work
- ✅ Synced tool documentation appears
- ✅ Search functionality works
- ✅ No broken images or links
- ✅ Mobile responsiveness
- ✅ Build process completes without errors

### Continuous Integration

The project includes GitHub Actions that automatically:
- Sync documentation from tool repositories
- Build the VitePress site
- Deploy to GitHub Pages
- Run daily to keep docs updated

## 🔧 Adding New Tools

To add documentation for a new tool:

1. **Ensure your tool repository has a `/docs` folder** with markdown files
2. **Edit `scripts/sync-docs.sh`** and add your repository to the `REPOS` array:
   ```bash
   REPOS=(
     "iqtoolkit/slow-query-analyzer:docs:slow-query-analyzer"
     "iqtoolkit/your-tool:docs:your-tool"  # Add this line
   )
   ```
3. **Update the sidebar** in `docs/.vitepress/config.js` to include your tool
4. **Test locally** with `make test-sync`
5. **Submit a pull request**

The documentation will automatically sync and be deployed.

## 📁 Repository Structure

```
docs.iqtoolkit.ai/
├── docs/                           # VitePress documentation
│   ├── .vitepress/
│   │   └── config.js              # VitePress configuration
│   ├── guide/                     # Getting started guides
│   ├── api/                       # API documentation  
│   ├── tools/                     # Tool-specific docs (synced)
│   │   └── slow-query-analyzer/   # Auto-synced from tool repo
│   └── examples/                  # Usage examples
├── scripts/
│   └── sync-docs.sh              # Documentation sync script
├── .github/workflows/
│   ├── deploy.yml                # Deployment workflow
│   └── sync-docs.yml             # Manual sync workflow
└── package.json                  # Dependencies and scripts
```

## 🔄 How Documentation Sync Works

1. **GitHub Actions runs** (on push, schedule, or manual trigger)
2. **Script clones** each tool repository listed in `REPOS`
3. **Copies documentation** from each repo's `/docs` folder to `/tools/{tool-name}/`
4. **Builds VitePress site** with all documentation included
5. **Deploys to GitHub Pages** at `docs.iqtoolkit.ai`

## 🚀 Deployment

Documentation is automatically deployed via GitHub Actions:

- **Triggers**: Push to main, daily at 2 AM UTC, or manual dispatch
- **Destination**: GitHub Pages at `docs.iqtoolkit.ai`
- **Process**: Sync docs → Build VitePress → Deploy

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- **Documentation Site**: [docs.iqtoolkit.ai](https://docs.iqtoolkit.ai)
- **Main Organization**: [github.com/iqtoolkit](https://github.com/iqtoolkit)
- **Issues**: [GitHub Issues](https://github.com/iqtoolkit/docs.iqtoolkit.ai/issues)
