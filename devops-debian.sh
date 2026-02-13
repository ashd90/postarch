#!/bin/bash
set -e

echo "💜 Starting DevOps Toolchain Setup for Linux Mint..."

# 1. Update and install prerequisites
sudo apt update && sudo apt install -y curl gpg gnupg2 software-properties-common apt-transport-https lsb-release

# 2. Setup Terraform (Official HashiCorp Repo)
echo "🛠️ Installing Terraform..."
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# 3. Setup Kubectl (Official Kubernetes Repo)
echo "☸️ Installing Kubectl..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# 4. Setup Ansible (Official PPA)
echo "📜 Installing Ansible..."
sudo add-apt-repository --yes --update ppa:ansible/ansible

# 5. Final Install
sudo apt update
sudo apt install -y terraform kubectl ansible

# 6. Enable Kubectl Autocompletion (The Arch Way)
echo "source <(kubectl completion bash)" >>~/.bashrc

echo "✅ All tools installed! Please restart your terminal."
