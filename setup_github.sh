#!/bin/bash

# GitHub Repository Setup Script for AARTREC Attack Corpus
# This script initializes a git repository and prepares it for GitHub

echo "════════════════════════════════════════════════════════════"
echo "  AARTREC Attack Corpus - GitHub Setup"
echo "════════════════════════════════════════════════════════════"
echo ""

# Navigate to repository directory
cd "$(dirname "$0")"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is not installed"
    echo "Please install git first: https://git-scm.com/downloads"
    exit 1
fi

echo "✅ Git is installed"
echo ""

# Initialize git repository
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already initialized"
fi

echo ""

# Create .gitignore
cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/
*.egg-info/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# Temporary files
*.tmp
*.bak

# Analysis output (generated)
*.png
*.pdf
*.log

EOF

echo "✅ Created .gitignore"
echo ""

# Display repository statistics
echo "📊 Repository Statistics:"
echo "──────────────────────────────────────────────────────────"
echo "  Amazon Books:    $(ls -1 amazon-books/*.json 2>/dev/null | wc -l | tr -d ' ') files"
echo "  MovieLens:       $(ls -1 movielens/*.json 2>/dev/null | wc -l | tr -d ' ') files"
echo "  Yelp:            $(ls -1 yelp/*.json 2>/dev/null | wc -l | tr -d ' ') files"
echo "  Analysis files:  $(ls -1 analysis/* 2>/dev/null | wc -l | tr -d ' ') files"
echo ""

# Count total attacks
AMAZON_COUNT=$(python3 -c "import json; print(len(json.load(open('amazon-books/attack_corpus.json'))))" 2>/dev/null || echo "0")
MOVIELENS_COUNT=$(python3 -c "import json; print(len(json.load(open('movielens/attack_corpus.json'))))" 2>/dev/null || echo "0")
YELP_COUNT=$(python3 -c "import json; print(len(json.load(open('yelp/attack_corpus.json'))))" 2>/dev/null || echo "0")
TOTAL=$((AMAZON_COUNT + MOVIELENS_COUNT + YELP_COUNT))

echo "  Total attacks:   $TOTAL"
echo "    - Amazon:      $AMAZON_COUNT"
echo "    - MovieLens:   $MOVIELENS_COUNT"
echo "    - Yelp:        $YELP_COUNT"
echo ""

# Stage all files
echo "Staging files..."
git add .
echo "✅ All files staged"
echo ""

# Create initial commit
if ! git rev-parse HEAD > /dev/null 2>&1; then
    echo "Creating initial commit..."
    git commit -m "Initial commit: AARTREC Attack Corpus

- 1,999 adversarial attacks across 3 datasets
- 16 attack categories from research taxonomy
- Dataset-aware attacks (books, movies, restaurants)
- Generated using GPT-4 via iterative red-teaming
- Comprehensive analysis and statistics included
"
    echo "✅ Initial commit created"
else
    echo "ℹ️  Repository already has commits"
fi

echo ""
echo "════════════════════════════════════════════════════════════"
echo "  📝 Next Steps:"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "1. Create a new repository on GitHub:"
echo "   https://github.com/new"
echo ""
echo "2. Set repository name: AARTREC-Attack-Corpus"
echo ""
echo "3. Add remote and push:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/AARTREC-Attack-Corpus.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "4. (Optional) Add topics on GitHub:"
echo "   - adversarial-attacks"
echo "   - llm-security"
echo "   - recommendation-systems"
echo "   - red-teaming"
echo "   - robustness-testing"
echo ""
echo "════════════════════════════════════════════════════════════"
echo "  ✅ Repository is ready for GitHub!"
echo "════════════════════════════════════════════════════════════"
echo ""
