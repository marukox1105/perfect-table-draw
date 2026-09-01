#!/bin/bash
PORT=8080
QR_PAGE="qr-perfect-table-draw.html"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

IP=$(ipconfig getifaddr en0 2>/dev/null)
[ -z "$IP" ] && IP=$(ipconfig getifaddr en1 2>/dev/null)
[ -z "$IP" ] && IP=$(ipconfig getifaddr en2 2>/dev/null)
[ -z "$IP" ] && IP="localhost"

QR_URL="http://localhost:$PORT/$QR_PAGE?host=$IP:$PORT"

echo ""
echo "  ┌─────────────────────────────────────────┐"
echo "  │        Perfect Table Draw Server         │"
echo "  └─────────────────────────────────────────┘"
echo ""
echo "  Serving : http://$IP:$PORT"
echo "  Draw    : http://$IP:$PORT/perfect-table-draw.html#draw"
echo "  Admin   : http://$IP:$PORT/perfect-table-draw.html#admin"
echo "  QR page : $QR_URL"
echo ""
echo "  Press Ctrl+C to stop."
echo ""

cd "$SCRIPT_DIR"
lsof -ti tcp:$PORT | xargs kill -9 2>/dev/null
(sleep 2 && open "$QR_URL") &
python3 -m http.server $PORT
