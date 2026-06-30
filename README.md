# 🛡️ Kernel Security Toolkit

> *A collection of scripts, patterns, and PoCs for static analysis of Linux/Android kernels*

---

## 📌 About This Repository

This repository contains tools and scripts I use to find **security vulnerabilities** in the Linux kernel (especially Android and Qualcomm MSM kernels).  
All scripts are designed to be run on a **minimal system** (even on Termux on a phone!) and are focused on **static source‑code analysis**.

---

## 🛠️ What's Inside?

| File/Directory | Description |
|----------------|-------------|
| `scripts/find_dangerous_patterns.sh` | Searches for dangerous kernel functions (like `copy_from_user`, `mutex_lock`, `kmalloc`) using `grep` |
| `scripts/coccinelle_checks/kmalloc_check.cocci` | Coccinelle script to find missing NULL checks after `kmalloc` |
| `scripts/coccinelle_checks/mutex_check.cocci` | Coccinelle script to find missing `mutex_unlock` in error paths |
| `scripts/poc_examples/null_pointer_poc.c` | Sample PoC for a NULL pointer dereference |
| `scripts/poc_examples/deadlock_poc.c` | Sample PoC for a mutex deadlock (similar to QPSIIR-2072) |
| `scripts/setup_env.sh` | One‑click script to install all required tools (Coccinelle, grep, build-essential, etc.) |
| `docs/quick_start.md` | A step‑by‑step guide for beginners to start kernel analysis |

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

---

## 📖 How to Contribute

If you find a new pattern or have a better script, feel free to:

- Open an **Issue** with your suggestion
- Submit a **Pull Request** with your changes

---

## ⚠️ Disclaimer

> These tools are for **educational and research purposes** only.  
> Always test on your own devices and never use these on systems you don't own.

---

## 📬 Contact

**Daniel Baradaran**  
🔗 [GitHub](https://github.com/danieldevir) · 📧 daniel.ir.dev@gmail.com
