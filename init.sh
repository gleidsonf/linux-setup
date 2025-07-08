#!/bin/bash

set -e

# Function to detect OS and package manager
detect_package_manager() {
  if command -v apt &> /dev/null; then
    PM="apt"
    UPDATE_CMD="sudo apt update"
    INSTALL_CMD="sudo apt install -y"
  else
    echo "Unsupported package manager. Exiting."
    exit 1
  fi
}

# Install Git if not present
install_git() {
  if ! command -v git &> /dev/null; then
    echo "Installing Git..."
    $UPDATE_CMD
    $INSTALL_CMD git
  else
    echo "Git is already installed."
  fi
}

# Install Ansible if not present
install_ansible() {
  if ! command -v ansible &> /dev/null; then
    echo "Installing Ansible..."
    $UPDATE_CMD
    $INSTALL_CMD ansible
  else
    echo "Ansible is already installed."
  fi
}

# Check ansible-pull (part of ansible)
check_ansible_pull() {
  if ! command -v ansible-pull &> /dev/null; then
    echo "ansible-pull not found. Attempting to reinstall Ansible..."
    $INSTALL_CMD ansible
  else
    echo "ansible-pull is available."
  fi
}

# Main execution
main() {
  detect_package_manager
  install_git
  install_ansible
  check_ansible_pull
  echo "All tools are installed."
}

main
