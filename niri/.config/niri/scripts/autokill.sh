#!/bin/bash
# Usage: ./autokill.sh "Name to Kill"

TARGET="$1"

if [ "$TARGET" = "" ]; then
    echo "Error: No target specified."
    echo "Usage: $0 <string-to-match>"
    exit 1
fi

echo "Listening for windows containing: '$TARGET'..."

# 1. 'recurse': Digs through every single nested level of JSON.
# 2. 'select': Finds ANY object that has a title containing your target string.
# 3. --arg: safely passes your search string into jq.
niri msg -j event-stream | jq --unbuffered -r --arg target "$TARGET" '
    recurse | 
    select(type == "object" and .title? and (.title | contains($target))) | 
    .id
' | while read -r win_id; do
    echo "Detected ID $win_id. Killing..."
    niri msg action close-window --id "$win_id"
done
