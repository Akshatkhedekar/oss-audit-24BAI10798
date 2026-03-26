# oss-audit-24BAI10798

**The Open Source Audit — Git**  
Open Source Software | VITyarthi | OSS NGMC Course  

| Field | Details |
|---|---|
| Student Name | Akshat Khedekar |
| Registration Number | 24BAI10798 |
| Slot | B22 |
| Software Audited | Git (GPL v2) |
| Course | Open Source Software |

---

## About This Project

This repository contains the five shell scripts submitted as part of the OSS Capstone Project. The project audits **Git** — a distributed version control system licensed under GPL v2 — across its origin story, license, Linux footprint, ecosystem, and a comparison with its proprietary alternatives.

---

## Scripts

| File | Script Name | Purpose |
|---|---|---|
| `script1_system_identity.sh` | System Identity Report | Displays OS, kernel, user, uptime, date, and license context |
| `script2_package_inspector.sh` | FOSS Package Inspector | Checks if Git is installed and prints metadata + philosophy note |
| `script3_disk_auditor.sh` | Disk and Permission Auditor | Audits key system directories for permissions and disk usage |
| `script4_log_analyzer.sh` | Log File Analyzer | Counts keyword occurrences in a log file and shows last 5 matches |
| `script5_manifesto_generator.sh` | Manifesto Generator | Interactively generates a personalised open-source philosophy statement |

---

## Dependencies

All scripts run on standard Ubuntu/Debian Linux with no additional packages required.  
Built-in tools used: `bash`, `uname`, `whoami`, `uptime`, `date`, `lsb_release`, `dpkg`, `ls`, `du`, `awk`, `grep`, `cut`, `tail`, `mktemp`, `cat`.

Git must be installed for Script 2 to report metadata:
```bash
sudo apt update && sudo apt install git
```

---

## How to Run Each Script

### Setup — make all scripts executable
```bash
chmod +x script1_system_identity.sh
chmod +x script2_package_inspector.sh
chmod +x script3_disk_auditor.sh
chmod +x script4_log_analyzer.sh
chmod +x script5_manifesto_generator.sh
```

---

### Script 1 — System Identity Report
```bash
./script1_system_identity.sh
```
No arguments required. Outputs system info and open-source license context.

---

### Script 2 — FOSS Package Inspector
```bash
./script2_package_inspector.sh
```
No arguments required. Checks if `git` is installed and prints metadata.

---

### Script 3 — Disk and Permission Auditor
```bash
./script3_disk_auditor.sh
```
No arguments required. Audits `/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, `/usr/share`, `/usr/lib`, and Git config paths.

---

### Script 4 — Log File Analyzer
```bash
./script4_log_analyzer.sh /var/log/syslog error
```
**Arguments:**
- `$1` — Path to the log file (required)
- `$2` — Keyword to search for (optional, defaults to `error`)

**Examples:**
```bash
./script4_log_analyzer.sh /var/log/syslog error
./script4_log_analyzer.sh /var/log/auth.log warning
./script4_log_analyzer.sh /var/log/syslog ssh
```

If `/var/log/syslog` does not exist on your system, try:
```bash
./script4_log_analyzer.sh /var/log/kern.log error
```

---

### Script 5 — Open Source Manifesto Generator
```bash
./script5_manifesto_generator.sh
```
Interactive — the script will ask you three questions and generate a `manifesto_<username>.txt` file.

---

## Notes

- Scripts are written for **Ubuntu 22.04 / 24.04** (Debian-based). Script 2 falls back to `rpm` on Fedora/RHEL systems.
- All scripts include inline comments explaining every non-obvious line.
- Screenshots of each script running are included in the project report PDF.
