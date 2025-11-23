#!/bin/bash
# ==================================================
# cleanup_system.sh
# Cleans up temporary files and caches to free space
# Works on most Linux systems (Arch, Ubuntu, Fedora)
# ==================================================

# --- Configuration ---
LOG_FILE="$HOME/cleanup_$(date +%Y%m%d_%H%M%S).log"

# --- Root Check ---
if [ "$EUID" -ne 0 ]; then
  echo "⚠️  Please run as root (sudo ./cleanup_system.sh)"
  exit 1
fi

echo "🧹 Starting system cleanup..."
echo "Log file: $LOG_FILE"
echo "===============================================" | tee -a "$LOG_FILE"

# --- Function to show current disk usage ---
show_disk_usage() {
  echo
  echo "📊 Current Disk Usage:"
  df -h | tee -a "$LOG_FILE"
  echo
}

# --- Function for cleaning operations ---
cleanup() {
  echo "🗑️  Cleaning temporary directories..." | tee -a "$LOG_FILE"
  rm -rf /tmp/* /var/tmp/* 2>>"$LOG_FILE"

  echo "🧾 Cleaning package caches..." | tee -a "$LOG_FILE"
  if command -v apt >/dev/null 2>&1; then
    apt-get clean -y >>"$LOG_FILE" 2>&1
    apt-get autoremove -y >>"$LOG_FILE" 2>&1
  elif command -v dnf >/dev/null 2>&1; then
    dnf clean all >>"$LOG_FILE" 2>&1
  elif command -v pacman >/dev/null 2>&1; then
    pacman -Scc --noconfirm >>"$LOG_FILE" 2>&1
  fi

  echo "🧹 Clearing user caches..." | tee -a "$LOG_FILE"
  rm -rf ~/.cache/* 2>>"$LOG_FILE"

  echo "🧼 Clearing systemd journal logs older than 7 days..." | tee -a "$LOG_FILE"
  journalctl --vacuum-time=7d >>"$LOG_FILE" 2>&1

  echo "🪣 Emptying trash (if available)..." | tee -a "$LOG_FILE"
  rm -rf ~/.local/share/Trash/* 2>>"$LOG_FILE"

  echo "✅ Cleanup complete!" | tee -a "$LOG_FILE"
}

# --- Execution ---
show_disk_usage
read -p "Proceed with cleanup? (y/n): " CONFIRM
if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
  cleanup
  show_disk_usage
  echo "📝 Detailed log saved to: $LOG_FILE"
else
  echo "❌ Cleanup cancelled."
fi

