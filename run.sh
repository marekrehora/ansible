#!/usr/bin/env bash

### Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### Install ansible
brew install ansible

### Pull ansible
ansible-pull -U https://${GITHUB_TOKEN}:x-oauth-basic@github.com/marekrehora/ansible.git

