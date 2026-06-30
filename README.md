# 🛡️ Kernel Security Toolkit

> *A complete suite for kernel security analysis, vulnerability research, and CVE intelligence*

---

## 📌 About This Repository

This repository is a **professional toolkit** for security researchers, bug hunters, and system administrators. It includes:

- 🔍 **Static analysis scripts** to find vulnerabilities in Linux/Android kernels
- 🧠 **Coccinelle rules** for advanced pattern matching
- 🧪 **Proof-of-Concept (PoC)** examples for educational purposes
- 🦈 **CVE Advisor Pro** – an advanced threat intelligence tool that fetches and analyzes CVE data

All scripts are designed to run on **minimal systems** (even on a 15-year-old laptop or Termux on a phone!) and require **no kernel compilation**.

---

## 🛠️ What's Inside?

| File/Directory | Description |
|----------------|-------------|
| `scripts/find_dangerous_patterns.sh` | Searches for dangerous kernel functions (`copy_from_user`, `mutex_lock`, `kmalloc`, etc.) |
| `scripts/cve_advisor.sh` | **New!** Advanced CVE intelligence tool – fetches, analyzes, and provides mitigation advice |
| `scripts/coccinelle_checks/kmalloc_check.cocci` | Coccinelle script to find missing NULL checks after `kmalloc` |
| `scripts/coccinelle_checks/mutex_check.cocci` | Coccinelle script to find missing `mutex_unlock` in error paths |
| `scripts/poc_examples/null_pointer_poc.c` | Sample PoC for a NULL pointer dereference |
| `scripts/poc_examples/deadlock_poc.c` | Sample PoC for a mutex deadlock (similar to QPSIIR-2072) |
| `scripts/setup_env.sh` | One‑click script to install all required tools (Coccinelle, grep, build-essential, etc.) |
| `docs/quick_start.md` | A step‑by‑step guide for beginners to start kernel analysis |
| `For Windows users.md` | Complete setup guide for Windows 10/11 using WSL |

---

## 🦈 CVE Advisor Pro – Advanced Threat Intelligence

One of the most powerful features of this toolkit is **CVE Advisor Pro**. This script:

- Fetches full CVE details from the **NVD (National Vulnerability Database)**
- Analyzes **CVSS vector** (Attack Vector, Privileges, Scope, etc.)
- Extracts **affected products** (CPE)
- Generates a **professional advisory report** with risk level assessment
- Provides **practical mitigation steps** based on severity

### Usage

```bash
./scripts/cve_advisor_pro.sh CVE-2024-6387
```

### Sample Output

```
╔═══════════════════════════════════════════════════════════════════════╗
║         🛡️  CVE ADVISORY PRO  -  ADVANCED THREAT INTELLIGENCE        ║
╚═══════════════════════════════════════════════════════════════════════╝

📌 CVE ID          : CVE-2024-6387
📅 Published       : 2024-07-09T16:15:00.000
📊 Severity        : CRITICAL
🎯 Risk Level      : 🔴 CRITICAL
💥 CVSS Score      : 9.8 / 10.0

📖 DESCRIPTION:
A vulnerability in OpenSSH server (sshd) allows remote code execution...

🔐 ATTACK VECTOR ANALYSIS:
│ Attack Vector        : NETWORK
│ Privileges Required  : NONE
│ User Interaction     : NONE
│ Scope                : UNCHANGED
│ Confidentiality      : HIGH
│ Integrity            : HIGH
│ Availability         : HIGH

🔧 RECOMMENDED ACTIONS:
- 🔴 CRITICAL: Apply patch immediately.
- Restrict network access to affected systems
- Enable logging and monitoring
```

---

## 🚀 Quick Start

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/danieldevir/Kernel-Security-Toolkit.git
cd Kernel-Security-Toolkit
```

### 2️⃣ Set Up the Environment

```bash
chmod +x scripts/setup_env.sh
./scripts/setup_env.sh
```

### 3️⃣ Download a Kernel Source

```bash
# Example for Android kernel:
git clone https://android.googlesource.com/kernel/common.git android-kernel
cd android-kernel
```

### 4️⃣ Run the Analysis Scripts

```bash
# Find dangerous patterns
../scripts/find_dangerous_patterns.sh .
```

```bash
# Run Coccinelle checks
spatch --sp-file ../scripts/coccinelle_checks/kmalloc_check.cocci --dir . --no-includes
```

### 5️⃣ Use CVE Advisor Pro

```bash
../scripts/cve_advisor_pro.sh CVE-2024-6387
```

---

## 🪟 For Windows Users

You can run this toolkit on Windows 10/11 using **WSL (Windows Subsystem for Linux)**.  
See the full guide: [For Windows users.md](For%20Windows%20users.md)

---

## 📖 How to Contribute

If you find a new pattern, have a better script, or want to add a new feature:

- Open an **Issue** with your suggestion
- Submit a **Pull Request** with your changes
- Star ⭐ the repository if you find it useful!

---

## ⚠️ Disclaimer

> These tools are for **educational and research purposes** only.  
> Always test on your own devices and never use these on systems you don't own.

---

## 🏆 Why This Toolkit?

| Feature | Benefit |
|---------|---------|
| **Lightweight** | Runs on minimal hardware (even 15-year-old laptops!) |
| **Educational** | Perfect for learning kernel security analysis |
| **Practical** | Used to find real bugs reported to Google and Qualcomm |
| **CVE Intelligence** | Get instant, actionable insights on any CVE |
| **Cross-platform** | Works on Linux, Windows (WSL), and Android (Termux) |
| **Open Source** | MIT License – free to use, modify, and share |

---

## 📬 Contact

**Daniel Baradaran**  
🔗 [GitHub](https://github.com/danieldevir) · 📧 daniel.ir.dev@gmail.com

---

✨ *Stay curious. Stay kind.* — Daniel Baradaran
