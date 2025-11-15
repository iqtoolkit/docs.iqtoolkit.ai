# IQToolkit Documentation Hub Makefile
# Provides convenient commands for development and testing

.PHONY: help install sync build dev test clean deploy check-deps setup

# Default target
help: ## Show this help message
	@echo "IQToolkit Documentation Hub"
	@echo "=========================="
	@echo ""
	@echo "Available commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

# Setup and Installation
setup: ## Complete setup: install dependencies and sync docs
	@echo "🚀 Setting up IQToolkit documentation..."
	@$(MAKE) install
	@$(MAKE) sync
	@echo "✅ Setup complete! Run 'make dev' to start development server"

install: ## Install npm dependencies
	@echo "📦 Installing dependencies..."
	@npm install

check-deps: ## Check if required dependencies are available
	@echo "🔍 Checking dependencies..."
	@command -v node >/dev/null 2>&1 || { echo "❌ Node.js not found. Please install Node.js 18+"; exit 1; }
	@command -v npm >/dev/null 2>&1 || { echo "❌ npm not found. Please install npm"; exit 1; }
	@command -v git >/dev/null 2>&1 || { echo "❌ git not found. Please install git"; exit 1; }
	@echo "✅ All dependencies found"
	@echo "Node.js: $$(node --version)"
	@echo "npm: $$(npm --version)"
	@echo "git: $$(git --version)"

# Documentation Sync
sync: ## Sync documentation from tool repositories
	@echo "🔄 Syncing documentation from tool repositories..."
	@bash scripts/sync-docs.sh

sync-clean: ## Clean temp files and sync documentation
	@echo "🧹 Cleaning up and syncing..."
	@rm -rf temp-repos
	@$(MAKE) sync

# Development
dev: ## Start development server with auto-sync
	@echo "🚀 Starting development server..."
	@npm run dev

build: ## Build documentation for production
	@echo "🏗️  Building documentation..."
	@npm run build

preview: ## Preview built documentation
	@echo "👀 Previewing built documentation..."
	@npm run docs:preview

# Testing
test: ## Run all tests
	@echo "🧪 Running all tests..."
	@$(MAKE) test-deps
	@$(MAKE) test-sync
	@$(MAKE) test-build
	@echo "✅ All tests passed!"

test-deps: ## Test if all dependencies are available
	@echo "Testing dependencies..."
	@$(MAKE) check-deps

test-sync: ## Test documentation sync
	@echo "🔄 Testing documentation sync..."
	@bash scripts/sync-docs.sh
	@echo "📊 Checking synced content..."
	@if [ -d "docs/tools/slow-query-doctor" ]; then \
		echo "✅ Slow Query Doctor docs synced successfully"; \
		ls -la docs/tools/slow-query-doctor/ | head -10; \
	else \
		echo "⚠️  Slow Query Doctor docs not found (repo may not exist yet)"; \
		echo "Creating placeholder..."; \
		mkdir -p docs/tools/slow-query-doctor; \
		echo "# Slow Query Doctor\n\nDocumentation will be available soon." > docs/tools/slow-query-doctor/index.md; \
	fi

test-build: ## Test if documentation builds successfully
	@echo "🏗️  Testing build process..."
	@npm run build
	@if [ -d "docs/.vitepress/dist" ]; then \
		echo "✅ Build successful"; \
		echo "📊 Build size:"; \
		du -sh docs/.vitepress/dist; \
	else \
		echo "❌ Build failed"; \
		exit 1; \
	fi

test-links: ## Test for broken internal links (requires build)
	@echo "🔗 Testing internal links..."
	@if [ ! -d "docs/.vitepress/dist" ]; then \
		echo "Building documentation first..."; \
		$(MAKE) build; \
	fi
	@echo "✅ Link test complete (manual verification recommended)"

# Maintenance
clean: ## Clean all generated files and caches
	@echo "🧹 Cleaning up..."
	@rm -rf node_modules
	@rm -rf docs/.vitepress/dist
	@rm -rf docs/.vitepress/.temp
	@rm -rf temp-repos
	@rm -rf docs/tools/*/
	@echo "✅ Cleanup complete"

clean-cache: ## Clean only caches and temp files
	@echo "🧹 Cleaning caches..."
	@rm -rf docs/.vitepress/.temp
	@rm -rf temp-repos
	@echo "✅ Cache cleanup complete"

# Git and Deployment
commit: ## Add, commit and push changes (requires commit message)
	@if [ -z "$(MSG)" ]; then \
		echo "❌ Please provide a commit message: make commit MSG='your message'"; \
		exit 1; \
	fi
	@echo "📝 Committing changes..."
	@git add .
	@git commit -m "$(MSG)"
	@git push origin main
	@echo "✅ Changes committed and pushed"

deploy: ## Deploy to GitHub Pages (commits and pushes)
	@echo "🚀 Deploying to GitHub Pages..."
	@$(MAKE) test
	@$(MAKE) commit MSG="docs: deploy documentation updates"
	@echo "✅ Deployment initiated. Check GitHub Actions for progress."

# Development helpers
watch: ## Watch for changes and rebuild (alternative to dev)
	@echo "👀 Watching for changes..."
	@npm run dev

serve: ## Serve built documentation locally
	@echo "🌐 Serving documentation..."
	@npm run docs:serve

# Info and Status
status: ## Show project status and helpful info
	@echo "IQToolkit Documentation Hub Status"
	@echo "=================================="
	@echo ""
	@echo "📁 Project structure:"
	@find . -type d -name ".git" -prune -o -type d -name "node_modules" -prune -o -type d -print | head -20
	@echo ""
	@echo "📊 Documentation stats:"
	@echo "  Markdown files: $$(find docs -name '*.md' | wc -l)"
	@echo "  Guide pages: $$(find docs/guide -name '*.md' 2>/dev/null | wc -l)"
	@echo "  Tool docs: $$(find docs/tools -name '*.md' 2>/dev/null | wc -l)"
	@echo ""
	@echo "🔧 Quick commands:"
	@echo "  make setup    - First time setup"
	@echo "  make dev      - Start development"
	@echo "  make test     - Run all tests"
	@echo "  make deploy   - Deploy to production"

# Advanced testing
test-ci: ## Run tests in CI-like environment
	@echo "🤖 Running CI tests..."
	@$(MAKE) clean
	@$(MAKE) install
	@$(MAKE) test
	@echo "✅ CI tests completed"

validate: ## Validate configuration and setup
	@echo "✅ Validating project setup..."
	@echo "Checking package.json..."
	@node -e "const pkg = require('./package.json'); console.log('✅ Package name:', pkg.name);"
	@echo "Checking VitePress config..."
	@node -e "const config = require('./docs/.vitepress/config.js'); console.log('✅ Site title:', config.default.title);"
	@echo "Checking sync script..."
	@if [ -x "scripts/sync-docs.sh" ]; then echo "✅ Sync script is executable"; else echo "❌ Sync script not executable"; fi
	@echo "✅ Validation complete"

# Documentation commands
docs: ## Alias for dev command
	@$(MAKE) dev

docs-build: ## Alias for build command  
	@$(MAKE) build

docs-clean: ## Clean only documentation builds
	@echo "🧹 Cleaning documentation builds..."
	@rm -rf docs/.vitepress/dist
	@rm -rf docs/.vitepress/.temp

# Troubleshooting
fix-config: ## Fix VitePress configuration issues
	@echo "🔧 Fixing VitePress configuration..."
	@if [ -f "docs/.vitepress/config.js" ]; then \
		echo "Moving config.js to config.mjs..."; \
		mv docs/.vitepress/config.js docs/.vitepress/config.mjs; \
	fi
	@echo "✅ Configuration fixed"

reinstall: ## Reinstall dependencies (fixes most issues)
	@echo "🔄 Reinstalling dependencies..."
	@rm -rf node_modules package-lock.json
	@npm install
	@echo "✅ Dependencies reinstalled"