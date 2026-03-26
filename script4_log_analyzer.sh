#!/bin/bash
# =============================================================================
# Script 4: Log File Analyzer
# Author: Akshat Khedekar | Reg: 24BAI10798 | Slot: B22
# Course: Open Source Software | VITyarthi
# Purpose: Reads a log file line by line, counts how many lines match a
#          keyword, and prints the last 5 matching lines.
# Usage:   ./script4_log_analyzer.sh /var/log/syslog error
#          ./script4_log_analyzer.sh /var/log/auth.log warning
# =============================================================================

# --- Accept command-line arguments ---
# $1 is the log file path; $2 is the search keyword (defaults to "error")
LOGFILE=$1
KEYWORD=${2:-"error"}    # Default keyword is 'error' if none is provided

# --- Counter for matching lines ---
COUNT=0

# --- Temporary file to store matching lines (used to display the last 5) ---
MATCHES_FILE=$(mktemp /tmp/log_matches_XXXXXX)

echo "====================================="
echo "   Log File Analyzer"
echo "   Student: Akshat Khedekar | 24BAI10798"
echo "====================================="

# --- Validate that a log file argument was supplied ---
if [ -z "$LOGFILE" ]; then
    echo ""
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    rm -f "$MATCHES_FILE"   # Clean up temp file before exiting
    exit 1
fi

# --- Check that the file actually exists ---
if [ ! -f "$LOGFILE" ]; then
    echo ""
    echo "  ERROR: File '$LOGFILE' not found."
    echo "  Check the path and try again."
    rm -f "$MATCHES_FILE"
    exit 1
fi

# --- Check if the file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo ""
    echo "  WARNING: '$LOGFILE' exists but is empty."
    echo "  Nothing to analyze."
    rm -f "$MATCHES_FILE"
    exit 0
fi

echo ""
echo "  File    : $LOGFILE"
echo "  Keyword : '$KEYWORD' (case-insensitive)"
echo "  ----------------------------------------"
echo "  Scanning..."
echo ""

# --- While-read loop: read the log file one line at a time ---
# IFS= preserves leading/trailing whitespace; -r prevents backslash interpretation
while IFS= read -r LINE; do

    # if-then: check if the current line contains the keyword (case-insensitive)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))             # Increment the match counter
        echo "$LINE" >> "$MATCHES_FILE"  # Append matching line to temp file
    fi

done < "$LOGFILE"    # Redirect the log file into the while loop as input

# --- Display the results ---
echo "  RESULT: Keyword '$KEYWORD' found in $COUNT line(s)."
echo "  ----------------------------------------"

if [ $COUNT -gt 0 ]; then
    echo ""
    echo "  --- Last 5 Matching Lines ---"
    # tail -n 5 shows the last 5 lines of the matches file
    tail -n 5 "$MATCHES_FILE" | while IFS= read -r MATCH_LINE; do
        echo "  > $MATCH_LINE"
    done
    echo ""
    echo "  (Showing last 5 of $COUNT total matches)"
else
    echo ""
    echo "  No lines matching '$KEYWORD' were found in $LOGFILE."
    echo "  Try a different keyword: ERROR, WARNING, FAILED, ssh, sudo"
fi

# --- Clean up temporary file ---
rm -f "$MATCHES_FILE"

echo "====================================="
echo "   Analysis complete."
echo "====================================="
