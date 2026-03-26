#!/bin/bash
# =============================================================================
# Script 1: System Identity Report
# Author: Akshat Khedekar | Reg: 24BAI10798 | Slot: B22
# Course: Open Source Software | VITyarthi
# Purpose: Displays a formatted system welcome screen for the Git OSS audit.
#          Shows kernel version, user info, uptime, date, and license context.
# =============================================================================

# --- Student and software identity variables ---
STUDENT_NAME="Akshat Khedekar"
REG_NUMBER="24BAI10798"
SOFTWARE_CHOICE="Git"
SOFTWARE_LICENSE="GPL v2 (GNU General Public License version 2)"

# --- Gather system information using command substitution $() ---
KERNEL=$(uname -r)                            # Linux kernel version
ARCH=$(uname -m)                              # CPU architecture (x86_64, arm64, etc.)
USER_NAME=$(whoami)                           # Currently logged-in user
HOME_DIR=$HOME                                # Home directory of the current user
UPTIME=$(uptime -p)                           # Human-readable uptime (e.g., "up 2 hours")
DATETIME=$(date "+%A, %d %B %Y  %H:%M:%S")   # Formatted current date and time

# --- Get Linux distribution name ---
# lsb_release works on Ubuntu/Debian; fallback to /etc/os-release if unavailable
if command -v lsb_release &>/dev/null; then
    DISTRO=$(lsb_release -d | cut -f2)
elif [ -f /etc/os-release ]; then
    DISTRO=$(grep "^PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"')
else
    DISTRO="Unknown Linux Distribution"
fi

# --- Get the OS license (Linux kernel is GPL v2, same as Git) ---
OS_LICENSE="GPL v2 — GNU General Public License version 2"

# --- Display the formatted output ---
echo "=============================================="
echo "   OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT"
echo "=============================================="
echo "  Student     : $STUDENT_NAME"
echo "  Reg. Number : $REG_NUMBER"
echo "  Software    : $SOFTWARE_CHOICE"
echo "----------------------------------------------"
echo "  OS          : $DISTRO"
echo "  Kernel      : Linux $KERNEL ($ARCH)"
echo "  User        : $USER_NAME"
echo "  Home        : $HOME_DIR"
echo "  Uptime      : $UPTIME"
echo "  Date/Time   : $DATETIME"
echo "----------------------------------------------"
echo "  OS License  : $OS_LICENSE"
echo ""
echo "  Both the Linux kernel and Git are licensed"
echo "  under GPL v2. This grants every user the four"
echo "  essential freedoms: to run, study, modify, and"
echo "  redistribute the software freely."
echo "=============================================="
