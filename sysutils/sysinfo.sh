#!/bin/bash
# ===========================================
#  System Information & Resource Usage Script
# ===========================================

echo "==========================================="
echo "        🖥️  System Information Report       "
echo "==========================================="
echo

# Hostname and OS info
echo "🌐 Hostname: $(hostname)"
echo "💽 OS: $(lsb_release -d 2>/dev/null | cut -f2 || cat /etc/*release | head -n 1)"
echo "🧩 Kernel: $(uname -r)"
echo "⚙️  Architecture: $(uname -m)"
echo "🕒 System Uptime: $(uptime -p)"
echo "⏰ Last Boot: $(who -b | awk '{print $3, $4}')"
echo

# CPU info
echo "==========================================="
echo "🧠 CPU Information"
echo "==========================================="
lscpu | grep -E 'Model name|CPU\(s\)|Thread|Core|Socket|MHz'
echo
echo "CPU Usage:"
mpstat 1 1 | awk '/Average/ && $12 ~ /[0-9.]+/ {print 100 - $12"% used"}'
echo

# Memory info
echo "==========================================="
echo "💾 Memory Usage"
echo "==========================================="
free -h | awk 'NR==1 || NR==2 {print}'
echo

# Disk info
echo "==========================================="
echo "📦 Disk Usage"
echo "==========================================="
df -h --total | grep -E '^Filesystem|total'
echo

# Network info
echo "==========================================="
echo "🌍 Network Information"
echo "==========================================="
ip -br addr show | awk '{print $1, $3}'
echo
echo "Active Connections:"
ss -tunap | head -n 10
echo

# GPU info (if available)
if command -v lspci >/dev/null 2>&1; then
    echo "==========================================="
    echo "🎮 GPU Information"
    echo "==========================================="
    lspci | grep -E "VGA|3D"
    echo
fi

# Logged in users
echo "==========================================="
echo "👥 Logged In Users"
echo "==========================================="
who
echo

# Top processes by CPU and memory
echo "==========================================="
echo "🔥 Top 5 CPU-consuming processes"
echo "==========================================="
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
echo

echo "==========================================="
echo "🧠 Top 5 Memory-consuming processes"
echo "==========================================="
ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -n 6
echo

echo "==========================================="
echo "✅ End of System Report"
echo "==========================================="

