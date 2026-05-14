# 🏗️ PostArch - Post-Installation Arch Linux Setup Suite

<div align="center">

![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![KDE](https://img.shields.io/badge/KDE-1D99F3?style=for-the-badge&logo=kde&logoColor=white)

**🚀 Essential scripts and utilities to optimize your Arch Linux system post-installation**

[📂 Repository](#-repository-structure) • [🛠️ Scripts](#-available-scripts) • [📁 Folders](#-folder-structure) • [🚀 Getting Started](#-getting-started)

</div>

---

## 📖 Overview

**PostArch** is a comprehensive collection of shell scripts designed to streamline and enhance your Arch Linux setup after initial installation. Whether you're configuring a fresh Arch system on KDE Plasma or managing web applications, PostArch provides automated solutions to save you time and effort.

**Key Features:**
- ✅ Web app launcher creation for Chromium-based browsers
- ✅ Automated system utilities and management tools
- ✅ Font installation and customization
- ✅ Setup guides and documentation
- ✅ Color-coded terminal output for better UX
- ✅ Optimized for KDE Plasma desktop environment

---

## 📂 Repository Structure

```
postarch/
│
├── 📄 README.md                    # This file - Complete documentation
├── 🔧 web-app.sh                   # Web app launcher creation script
├── 🗑️  remove-web-app.sh            # Web app removal utility
│
├── 📁 arch-setup/                  # Arch Linux initial setup resources
│
├── 📁 fonts/                       # Font files and font management
│
├── 📁 setup-guide/                 # Comprehensive setup documentation
│
└── 📁 sysutils/                    # System utilities and helpers

```

---

## 🛠️ Available Scripts

### 🌐 `web-app.sh` - Web App Launcher Generator

Create desktop shortcuts for web applications with proper KDE integration.

**Features:**
- 🎯 Interactive web app configuration
- 🖼️ Automatic icon downloading and management
- 🌍 Support for multiple Chromium-based browsers:
  - **Thorium Browser**
  - **Brave Browser**
  - **Chromium**
- 🎨 Proper WMClass configuration for KDE Task Manager
- 💾 Desktop entry creation in `~/.local/share/applications/`

**Usage:**
```bash
bash web-app.sh
```

**Interactive Prompts:**
1. Enter the Web App Name (e.g., YouTube, Gmail, GitHub)
2. Enter the Web App URL
3. Enter the Icon URL or local path
4. Select your browser (Thorium, Brave, or Chromium)

**Output:**
- `.desktop` file created in `~/.local/share/applications/`
- Icon stored in `~/.local/share/icons/`
- Application appears in your KDE application menu

---

### 🗑️ `remove-web-app.sh` - Web App Removal Tool

Safely remove previously created web app launchers.

**Features:**
- 📋 Lists all installed web apps created by the launcher tool
- 🎯 Interactive selection menu
- 🧹 Removes both `.desktop` files and associated icons
- ✅ Safe filename handling (supports spaces in names)

**Usage:**
```bash
bash remove-web-app.sh
```

**Interactive Menu:**
1. Displays all available web apps
2. Select an app number to remove
3. Confirms removal of the `.desktop` file and icon

---

## 📁 Folder Structure

### 📦 `arch-setup/`
Houses resources for initial Arch Linux setup and configuration.

**Contents may include:**
- Post-installation checklists
- System configuration templates
- Package lists for quick installation
- Bootloader configuration guides

---

### 🎨 `fonts/`
Font files and font management utilities.

**Contents may include:**
- TrueType fonts (.ttf)
- OpenType fonts (.otf)
- Font installation scripts
- Font configuration files for various applications

**Installation Location:** `~/.local/share/fonts/`

---

### 📖 `setup-guide/`
Comprehensive step-by-step guides for complete system setup.

**Contents may include:**
- Desktop environment configuration (KDE Plasma)
- Display server setup (X11/Wayland)
- Audio configuration (PulseAudio/PipeWire)
- Network setup and WiFi configuration
- System security hardening
- Development environment setup

---

### 🔧 `sysutils/`
System utilities and helper scripts for daily system management.

**Contents may include:**
- System monitoring utilities
- Backup and restore scripts
- Package management helpers
- Performance optimization tools
- System maintenance scripts

---

## 🚀 Getting Started

### Prerequisites
- ✅ Fresh Arch Linux installation
- ✅ KDE Plasma desktop environment (recommended)
- ✅ Bash shell
- ✅ Common utilities: `wget`, `grep`, `awk`
- ✅ Chromium-based browser (Thorium, Brave, or Chromium)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ashd90/postarch.git
   cd postarch
   ```

2. **Make scripts executable:**
   ```bash
   chmod +x *.sh
   ```

3. **Run the desired script:**
   ```bash
   bash web-app.sh
   # or
   bash remove-web-app.sh
   ```

### Quick Start Example

Create a web app for YouTube:
```bash
bash web-app.sh
# Enter: YouTube
# Enter: https://www.youtube.com
# Enter: https://www.youtube.com/s/desktop/abcd1234/img/favicon.ico
# Select: 2 (Brave)
```

---

## 📋 File Details

| File | Type | Description |
|------|------|-------------|
| `web-app.sh` | Script | Interactive web app launcher generator |
| `remove-web-app.sh` | Script | Safe removal of web app launchers |
| `README.md` | Documentation | This comprehensive guide |

---

## 🎨 Features Highlight

### 🌈 Color-Coded Output
All scripts include colorized terminal output:
- 🟢 **GREEN** - Success messages and headers
- 🟡 **YELLOW** - Warnings and user prompts
- 🔴 **RED** - Errors and cancellations

### ⚡ KDE Integration
- Proper `StartupWMClass` configuration for correct window grouping
- Desktop icon caching through `update-desktop-database`
- Seamless integration with KDE application menu and task manager

### 🔒 Safe Operation
- Validates user input
- Handles filenames with spaces correctly
- Creates necessary directories automatically
- Preserves existing files during operations

---

## 🐛 Troubleshooting

### Web app launcher not appearing in application menu
- Run: `update-desktop-database ~/.local/share/applications/`
- Ensure the `.desktop` file has executable permissions

### Icon not showing in task manager
- Verify the `StartupWMClass` value matches your browser's window class
- Check that the icon file exists at the specified path

### Permission denied errors
- Make scripts executable: `chmod +x *.sh`
- Ensure you have write permissions in `~/.local/share/`

---

## 📝 License

This repository is provided as-is for personal use and community benefit.

---

## 👤 Author

**ashd90** - Created for Arch Linux enthusiasts and KDE users

---

## 🤝 Contributing

Feel free to fork, modify, and improve these scripts for your own use!

---

<div align="center">

**⭐ If you find this helpful, consider starring the repository!**

[View on GitHub](https://github.com/ashd90/postarch) • [Report Issues](https://github.com/ashd90/postarch/issues)

</div>
