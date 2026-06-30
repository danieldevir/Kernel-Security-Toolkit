## 🪟 For Windows Users (via WSL)

This toolkit is designed for Linux, but you can easily run it on **Windows 10/11** using **WSL (Windows Subsystem for Linux)**. Follow these steps:

### 1️⃣ Install WSL
Open **PowerShell** as Administrator and run:
```powershell
wsl --install
```
Restart your system if prompted. This will install Ubuntu by default.

### 2️⃣ Launch Ubuntu
After installation, launch Ubuntu from the Start Menu or run `wsl` in PowerShell.

### 3️⃣ Update and Install Dependencies
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git build-essential grep findutils coccinelle vim nano curl wget
```

### 4️⃣ Clone the Repository
```bash
git clone https://github.com/danieldevir/Kernel-Security-Toolkit.git
cd Kernel-Security-Toolkit
```

### 5️⃣ Run the Scripts
```bash
chmod +x scripts/setup_env.sh
./scripts/setup_env.sh
```

Now you can use all the scripts exactly as described in the [Quick Start](#-quick-start) section!

> 💡 **Tip:** You can access your Windows files from WSL at `/mnt/c/`. For example, to analyze a kernel source stored on your Windows desktop:
> ```bash
> cd /mnt/c/Users/YourUsername/Desktop/linux-kernel
> ../scripts/find_dangerous_patterns.sh .
> ```
