#!/bin/bash
# =============================================================================
# Script 3: Disk and Permission Auditor
# Author: Akshat Khedekar | Reg: 24BAI10798 | Slot: B22
# Course: Open Source Software | VITyarthi
# Purpose: Loops through key system directories, reports permissions, owner,
#          group, and disk usage. Also checks Git-specific config locations.
# =============================================================================

# --- Array of important system directories to audit ---
# These are standard Linux Filesystem Hierarchy Standard (FHS) locations
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share" "/usr/lib")

echo "========================================"
echo "   Directory Audit Report"
echo "   Auditor: Akshat Khedekar | 24BAI10798"
echo "========================================"
echo ""

# --- For loop: iterate over each directory in the array ---
for DIR in "${DIRS[@]}"; do

    # Check if the directory exists using the -d test flag
    if [ -d "$DIR" ]; then

        # Extract permissions string using ls -ld and awk (field 1)
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')

        # Extract owner (field 3) and group (field 4) from ls -ld output
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # Get human-readable disk usage; redirect stderr to suppress permission errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Display the collected information
        echo "  Directory   : $DIR"
        echo "  Permissions : $PERMS"
        echo "  Owner/Group : $OWNER / $GROUP"
        echo "  Disk Usage  : ${SIZE:-N/A}"
        echo "  ----------------------------------------"

    else
        # Directory does not exist on this system
        echo "  SKIP: $DIR — does not exist on this system"
        echo "  ----------------------------------------"
    fi

done

echo ""
echo "========================================"
echo "   Git-Specific Path Audit"
echo "========================================"
echo ""

# --- Check Git's user-level configuration file ---
GIT_CONFIG="$HOME/.gitconfig"

if [ -f "$GIT_CONFIG" ]; then
    echo "  [FOUND] Git user config: $GIT_CONFIG"
    # Get permissions and owner of the config file
    PERMS=$(ls -l "$GIT_CONFIG" | awk '{print $1}')
    OWNER=$(ls -l "$GIT_CONFIG" | awk '{print $3}')
    echo "  Permissions : $PERMS  |  Owner: $OWNER"
    echo ""
    echo "  Contents preview (first 5 lines):"
    head -5 "$GIT_CONFIG" | sed 's/^/    /'
else
    echo "  [NOT FOUND] No ~/.gitconfig found."
    echo "  Set it up with:"
    echo "    git config --global user.name \"Your Name\""
    echo "    git config --global user.email \"you@example.com\""
fi

echo "  ----------------------------------------"

# --- Check Git's system-wide templates directory ---
GIT_TEMPLATES="/usr/share/git-core/templates"

if [ -d "$GIT_TEMPLATES" ]; then
    echo "  [FOUND] Git templates directory: $GIT_TEMPLATES"
    # Show permissions of the templates directory
    ls -ld "$GIT_TEMPLATES" | awk '{print "  Permissions: " $1 "  Owner: " $3 "/" $4}'
    echo "  Templates installed:"
    ls "$GIT_TEMPLATES" 2>/dev/null | sed 's/^/    - /'
else
    echo "  [NOT FOUND] Git templates directory not present."
fi

echo "  ----------------------------------------"

# --- Check the git binary location ---
GIT_BIN=$(which git 2>/dev/null)

if [ -n "$GIT_BIN" ]; then
    echo "  [FOUND] Git binary: $GIT_BIN"
    PERMS=$(ls -l "$GIT_BIN" | awk '{print $1}')
    SIZE=$(ls -lh "$GIT_BIN" | awk '{print $5}')
    echo "  Permissions : $PERMS  |  Size: $SIZE"
else
    echo "  [NOT FOUND] git binary not in PATH"
fi

echo ""
echo "========================================"
echo "   Audit Complete"
echo "========================================"
