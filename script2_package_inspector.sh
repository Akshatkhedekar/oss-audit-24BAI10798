#!/bin/bash
# =============================================================================
# Script 2: FOSS Package Inspector
# Author: Akshat Khedekar | Reg: 24BAI10798 | Slot: B22
# Course: Open Source Software | VITyarthi
# Purpose: Checks whether Git is installed, retrieves its version and license
#          metadata from the package manager, and prints a philosophy note
#          using a case statement.
# =============================================================================

# --- The package to inspect ---
PACKAGE="git"

echo "====================================="
echo "   FOSS Package Inspector"
echo "   Checking: $PACKAGE"
echo "====================================="
echo ""

# --- Detect which package manager is available ---
# Uses if-then-elif to handle both Debian/Ubuntu (dpkg) and Fedora/RHEL (rpm)
if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"
else
    PKG_MANAGER="unknown"
fi

echo "Package manager detected: $PKG_MANAGER"
echo ""

# --- Check if the package is installed ---
if [ "$PKG_MANAGER" = "dpkg" ] && dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
    echo "[INSTALLED] $PACKAGE is present on this system."
    echo ""
    echo "--- Package Metadata (via dpkg) ---"
    # Extract version using awk (field 3 of the dpkg -l output line)
    VERSION=$(dpkg -l "$PACKAGE" | grep "^ii" | awk '{print $3}')
    echo "  Version     : $VERSION"
    # Extract description and homepage from dpkg -s (status)
    dpkg -s "$PACKAGE" 2>/dev/null | grep -E "^(Description|Homepage|Maintainer)" | \
        sed 's/^/  /'

elif [ "$PKG_MANAGER" = "rpm" ] && rpm -q "$PACKAGE" &>/dev/null; then
    echo "[INSTALLED] $PACKAGE is present on this system."
    echo ""
    echo "--- Package Metadata (via rpm) ---"
    # Use rpm -qi for detailed info, filter relevant fields with grep
    rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary|URL)" | \
        sed 's/^/  /'

else
    echo "[NOT FOUND] $PACKAGE is NOT installed on this system."
    echo ""
    echo "To install Git on Ubuntu/Debian:"
    echo "  sudo apt update && sudo apt install git"
    echo ""
    echo "To install Git on Fedora/RHEL:"
    echo "  sudo dnf install git"
    exit 1
fi

echo ""
echo "--- Git version (direct check) ---"
# git --version gives the most reliable version string regardless of package manager
git --version 2>/dev/null || echo "  git binary not found in PATH"

echo ""
echo "--- Open Source Philosophy Note ---"

# --- Case statement: print a philosophy note based on package name ---
# Each case prints a short reflection on the open-source significance of that tool
case $PACKAGE in
    git)
        echo "  Git: Born from a licensing conflict in 2005, Git proved"
        echo "  that no company can permanently control the tools developers"
        echo "  depend on. A free tool built in 10 days by Linus Torvalds"
        echo "  now underlies the entire global software industry."
        ;;
    httpd|apache2)
        echo "  Apache HTTP Server: The web server that made the public"
        echo "  internet possible. Open, shared, and community-governed"
        echo "  since 1995."
        ;;
    mysql|mariadb)
        echo "  MySQL/MariaDB: A lesson in what happens when a community"
        echo "  forks software to protect its freedom from a corporate owner."
        ;;
    python3|python)
        echo "  Python: Shaped entirely by community consensus for 30+ years."
        echo "  Proof that a language can improve without corporate control."
        ;;
    vlc)
        echo "  VLC: Built by students in Paris who just wanted to stream"
        echo "  video over their university network. Now plays anything."
        ;;
    firefox)
        echo "  Firefox: A nonprofit's fight to keep the web open and"
        echo "  free from single-browser monopoly."
        ;;
    *)
        echo "  $PACKAGE: An open-source tool built on the principle"
        echo "  that knowledge shared freely is knowledge multiplied."
        ;;
esac

echo "====================================="
