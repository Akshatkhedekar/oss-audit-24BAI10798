#!/bin/bash
# =============================================================================
# Script 5: Open Source Manifesto Generator
# Author: Akshat Khedekar | Reg: 24BAI10798 | Slot: B22
# Course: Open Source Software | VITyarthi
# Purpose: Interactively asks the user three questions, then composes and
#          saves a personalised open-source philosophy statement to a .txt file.
# =============================================================================

# --- Note on aliases (concept demonstration) ---
# In a login shell you can define shortcuts like:
#   alias view_manifesto='cat ~/manifesto_$(whoami).txt'
# This creates a short name for a longer command.
# Aliases are session-scoped and typically defined in ~/.bashrc.

echo "============================================"
echo "   Open Source Manifesto Generator"
echo "   Student: Akshat Khedekar | 24BAI10798"
echo "   Audit subject: Git (GPL v2)"
echo "============================================"
echo ""
echo "Answer three questions to generate your"
echo "personal open-source philosophy statement."
echo ""

# --- Collect user input interactively using read ---
# -p flag prints a prompt before waiting for input
read -p "1. Name one open-source tool you use every day: " TOOL
read -p "2. In one word, what does 'freedom' mean to you? " FREEDOM
read -p "3. Name one thing you would build and share freely: " BUILD

echo ""

# --- Validate that the user actually typed something for each answer ---
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  ERROR: Please answer all three questions."
    exit 1
fi

# --- Get the current date and logged-in user for the manifesto header ---
DATE=$(date '+%d %B %Y')         # Format: 26 March 2026
USER_NOW=$(whoami)                # Username of the person running the script

# --- Build the output filename using string concatenation ---
# The filename includes the username so each user gets their own file
OUTPUT="manifesto_${USER_NOW}.txt"

# --- Write the manifesto to the output file ---
# Using > to create the file (overwrites if it exists)
# Using >> to append each subsequent line

# Create or clear the output file
> "$OUTPUT"

# Write the header
echo "============================================" >> "$OUTPUT"
echo "   MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "   Author : $USER_NOW" >> "$OUTPUT"
echo "   Date   : $DATE" >> "$OUTPUT"
echo "   Course : Open Source Software | VITyarthi" >> "$OUTPUT"
echo "============================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Compose the personalised manifesto paragraph using the three answers
# String concatenation happens naturally with adjacent echo calls and >>
echo "Every day, I depend on $TOOL — a tool built not by a single" >> "$OUTPUT"
echo "corporation for profit, but by a community for the common good." >> "$OUTPUT"
echo "To me, freedom in software means $FREEDOM: the right to use, study," >> "$OUTPUT"
echo "and change the tools that shape my work and my world without asking" >> "$OUTPUT"
echo "anyone's permission." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "If I could build one thing and give it away freely, it would be" >> "$OUTPUT"
echo "$BUILD — because the greatest software ever written was not locked" >> "$OUTPUT"
echo "behind a paywall or a proprietary license. It was shared." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "This is what Git taught us: a version control system written in ten" >> "$OUTPUT"
echo "days by one frustrated engineer, released under GPL v2, became the" >> "$OUTPUT"
echo "backbone of the entire global software industry. No company owns it." >> "$OUTPUT"
echo "No company can take it away. That is not an accident — it is the" >> "$OUTPUT"
echo "result of a deliberate choice to license knowledge as a public good." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Open source is not just a development model. It is a statement of" >> "$OUTPUT"
echo "values: that standing on the shoulders of giants is only honourable" >> "$OUTPUT"
echo "if you lift others up in return." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "— $USER_NOW  |  $DATE" >> "$OUTPUT"
echo "============================================" >> "$OUTPUT"

# --- Confirm the file was created and display it ---
echo "  Manifesto saved to: $OUTPUT"
echo "  ----------------------------------------"
echo ""

# Display the full manifesto using cat
cat "$OUTPUT"

echo ""
echo "============================================"
echo "   Done. Share freely."
echo "============================================"
