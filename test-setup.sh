#!/bin/bash

echo "🧪 Testing IQToolkit documentation setup..."

# Test 1: Check required files exist
echo "📁 Checking file structure..."
files=(
  "package.json"
  "docs/.vitepress/config.js" 
  "docs/index.md"
  "scripts/sync-docs.sh"
  ".github/workflows/deploy.yml"
)

for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    echo "  ✅ $file"
  else
    echo "  ❌ $file (missing)"
  fi
done

# Test 2: Check script permissions
echo "🔐 Checking script permissions..."
if [ -x "scripts/sync-docs.sh" ]; then
  echo "  ✅ sync-docs.sh is executable"
else
  echo "  ❌ sync-docs.sh not executable (run: chmod +x scripts/sync-docs.sh)"
fi

# Test 3: Check Node.js and npm
echo "📦 Checking dependencies..."
if command -v node &> /dev/null; then
  echo "  ✅ Node.js $(node --version)"
else
  echo "  ❌ Node.js not found"
fi

if command -v npm &> /dev/null; then
  echo "  ✅ npm $(npm --version)"
else
  echo "  ❌ npm not found" 
fi

# Test 4: Install dependencies if package.json exists
if [ -f "package.json" ] && [ -d "node_modules" ]; then
  echo "  ✅ Dependencies installed"
elif [ -f "package.json" ]; then
  echo "  ⚠️  Dependencies not installed (run: npm install)"
fi

echo ""
echo "🚀 Ready to test!"
echo ""
echo "Next steps:"
echo "1. npm install                    # Install dependencies"
echo "2. npm run sync-docs             # Test documentation sync"  
echo "3. npm run dev                   # Start development server"
echo "4. Visit http://localhost:5173   # View the documentation"
echo ""
echo "To deploy:"
echo "1. git add ."
echo "2. git commit -m 'feat: implement docs sync system'"
echo "3. git push origin main"
echo "4. Enable GitHub Pages in repository settings"