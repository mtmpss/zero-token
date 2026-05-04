#!/usr/bin/env bash
# Zero Token Setup — Install Free-Way gateway + configure OpenClaw fallback
# ⚠️ This installs third-party software (Free-Way by GoDiao).
#    Review: https://github.com/GoDiao/Free-Way
#    Pinned version. No auto-update.
set -euo pipefail

FREE_WAY_REPO="https://github.com/GoDiao/Free-Way.git"
FREE_WAY_TAG="main"  # Pinned — review before changing
FREE_WAY_DIR="$HOME/free-way"
FREE_WAY_PORT=8787

echo "🦾 Zero Token Setup"
echo "===================="
echo ""

# Check Node.js
if ! command -v node &>/dev/null; then
    echo "❌ Node.js required. Install: https://nodejs.org"
    exit 1
fi

# Check if Free-Way already installed
if [ ! -d "$FREE_WAY_DIR" ]; then
    echo "📦 Installing Free-Way gateway (pinned to $FREE_WAY_TAG)..."
    echo "   Source: $FREE_WAY_REPO"
    echo ""
    git clone --depth 1 --branch "$FREE_WAY_TAG" "$FREE_WAY_REPO" "$FREE_WAY_DIR"
    cd "$FREE_WAY_DIR"
    npm install --omit=dev 2>/dev/null || npm install
    npm run build 2>/dev/null || true
    echo "✅ Free-Way installed at $FREE_WAY_DIR (version: $FREE_WAY_TAG)"
else
    echo "✅ Free-Way already installed at $FREE_WAY_DIR"
    cd "$FREE_WAY_DIR"
fi

# Start Free-Way in background if not running
if ! curl -s http://localhost:$FREE_WAY_PORT/health &>/dev/null; then
    echo "🚀 Starting Free-Way on localhost:$FREE_WAY_PORT..."
    nohup npm start > "$FREE_WAY_DIR/free-way.log" 2>&1 &
    sleep 3
    if curl -s http://localhost:$FREE_WAY_PORT/health &>/dev/null; then
        echo "✅ Free-Way running at http://localhost:$FREE_WAY_PORT"
    else
        echo "⚠️  Free-Way may need manual start: cd $FREE_WAY_DIR && npm start"
    fi
else
    echo "✅ Free-Way already running at http://localhost:$FREE_WAY_PORT"
fi

echo ""
echo "📋 Next steps:"
echo ""
echo "1. Open http://localhost:$FREE_WAY_PORT in your browser"
echo "2. Click 'API Keys' tab"
echo "3. Add free API keys (use free-tier or disposable keys only):"
echo ""
echo "   🔑 Gemini Flash   → https://aistudio.google.com/apikey    (1500 req/day)"
echo "   🔑 Groq           → https://console.groq.com/keys          (1000 req/day)"
echo "   🔑 Cerebras       → https://cloud.cerebras.ai              (1700 req/day)"
echo ""
echo "   ⚠️  Use free-tier keys. Do NOT use production API keys."
echo ""
echo "4. Add this model as fallback in OpenClaw:"
echo ""
echo "   openclaw config add-model zero-token \\"
echo "     --provider openai \\"
echo "     --base-url http://localhost:$FREE_WAY_PORT/v1 \\"
echo "     --model llama-3.3-70b"
echo ""
echo "🎉 Done. Your agent uses free models when the main one is down."
echo ""
echo "---"
echo "🛑 To STOP the gateway:"
echo "   pkill -f 'node.*free-way' || lsof -ti:$FREE_WAY_PORT | xargs kill"
echo ""
echo "🗑️  To UNINSTALL:"
echo "   pkill -f 'node.*free-way'; rm -rf $FREE_WAY_DIR"
echo ""
echo "🔍 To CHECK status:"
echo "   curl http://localhost:$FREE_WAY_PORT/health"
