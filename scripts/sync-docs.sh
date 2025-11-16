#!/bin/bash
set -e

echo "🔄 Syncing documentation from tool repositories..."

# Define repositories and their docs paths
# Format: "owner/repo:source_path:dest_path"
REPOS=(
  "iqtoolkit/slow-query-doctor:docs:slow-query-doctor"
  # Add future tools here:
  # "iqtoolkit/another-tool:docs:another-tool"
  # "iqtoolkit/ml-toolkit:documentation:ml-toolkit"
)

# Base directory for temporary clones
TEMP_DIR="temp-repos"
mkdir -p "$TEMP_DIR"

for repo_config in "${REPOS[@]}"; do
  IFS=':' read -r repo source_path dest_path <<< "$repo_config"
  
  repo_name="${repo##*/}"
  clone_dir="$TEMP_DIR/$repo_name"
  
  echo "📦 Processing $repo..."
  
  # Clone or pull the repository (shallow clone for speed)
  if [ -d "$clone_dir" ]; then
    echo "  ↻ Updating existing clone..."
    cd "$clone_dir"
    git pull origin main --depth 1 2>/dev/null || git pull origin master --depth 1
    cd - > /dev/null
  else
    echo "  ⬇ Cloning repository..."
    git clone --depth 1 "https://github.com/$repo" "$clone_dir" 2>/dev/null || {
      echo "  ❌ Failed to clone $repo (might be private or not exist)"
      continue
    }
  fi
  
  # Create destination directory in VitePress docs structure
  mkdir -p "docs/tools/$dest_path"
  
  # Copy docs (if they exist)
  if [ -d "$clone_dir/$source_path" ]; then
    echo "  📄 Copying docs from $source_path to docs/tools/$dest_path..."
    cp -r "$clone_dir/$source_path/"* "docs/tools/$dest_path/" 2>/dev/null || echo "  ⚠ No docs found in $source_path"
    
    # Process markdown files to fix relative links if needed
    find "docs/tools/$dest_path" -name "*.md" -type f -exec sed -i.bak \
      -e 's|](docs/|](|g' \
      -e 's|](\.\./README\.md)|](https://github.com/'$repo')|g' \
      -e 's|](\.\./README)|](https://github.com/'$repo')|g' \
      -e 's|](\.\./ROADMAP\.md)|](https://github.com/'$repo'/blob/main/ROADMAP.md)|g' \
      -e 's|](\.\./ROADMAP)|](https://github.com/'$repo'/blob/main/ROADMAP.md)|g' \
      -e 's|](\.\./CONTRIBUTING\.md)|](https://github.com/'$repo'/blob/main/CONTRIBUTING.md)|g' \
      -e 's|](\.\./CONTRIBUTING)|](https://github.com/'$repo'/blob/main/CONTRIBUTING.md)|g' \
      -e 's|](\.\./CODE_OF_CONDUCT\.md)|](https://github.com/'$repo'/blob/main/CODE_OF_CONDUCT.md)|g' \
      -e 's|](\.\./CODE_OF_CONDUCT)|](https://github.com/'$repo'/blob/main/CODE_OF_CONDUCT.md)|g' \
      -e 's|](\.\./TECHNICAL_DEBT\.md)|](https://github.com/'$repo'/blob/main/TECHNICAL_DEBT.md)|g' \
      -e 's|](\.\./TECHNICAL_DEBT)|](https://github.com/'$repo'/blob/main/TECHNICAL_DEBT.md)|g' \
      -e 's|](\.\./examples)|](https://github.com/'$repo'/tree/main/examples)|g' \
      {} \; 2>/dev/null || true
    find "docs/tools/$dest_path" -name "*.bak" -delete 2>/dev/null || true
    
    # Create a metadata file for tracking
    cat > "docs/tools/$dest_path/.sync-info" << EOF
{
  "repository": "$repo",
  "source_path": "$source_path",
  "sync_time": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "commit_hash": "$(cd "$clone_dir" && git rev-parse HEAD 2>/dev/null || echo "unknown")"
}
EOF
    
  else
    echo "  ⚠ Warning: $source_path not found in $repo"
    # Create a placeholder file
    cat > "docs/tools/$dest_path/index.md" << EOF
# ${repo_name^} Documentation

Documentation for this tool is being prepared. Please check back soon or visit the [GitHub repository](https://github.com/$repo) for more information.

## Quick Links

- [Repository](https://github.com/$repo)
- [Issues](https://github.com/$repo/issues)
- [Releases](https://github.com/$repo/releases)

## Installation

\`\`\`bash
# Installation instructions will be available soon
\`\`\`

## Usage

\`\`\`bash
# Usage examples will be available soon
\`\`\`
EOF
  fi
  
  echo "  ✅ Done with $repo"
done

# Update VitePress config to include synced docs in sidebar
echo "📝 Updating VitePress sidebar configuration..."

# Create tools section in sidebar if it doesn't exist
TOOLS_SIDEBAR=""
for repo_config in "${REPOS[@]}"; do
  IFS=':' read -r repo source_path dest_path <<< "$repo_config"
  repo_name="${repo##*/}"
  # Convert repo name to title case
  title=$(echo "$repo_name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')
  
  TOOLS_SIDEBAR="$TOOLS_SIDEBAR            { text: '$title', link: '/tools/$dest_path/' },\n"
done

# Clean up temp directory (optional - comment out to speed up local builds)
echo "🧹 Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "✨ Documentation sync complete!"
echo ""
echo "📚 Synced documentation available at:"
for repo_config in "${REPOS[@]}"; do
  IFS=':' read -r repo source_path dest_path <<< "$repo_config"
  echo "  - /tools/$dest_path/ (from $repo)"
done