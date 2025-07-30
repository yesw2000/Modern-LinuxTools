# 🚀 Modern Linux Tools 🚀

This project packages a suite of cutting-edge command-line tools into portable Docker and Singularity containers, providing a modern, powerful, and consistent environment for developers on AlmaLinux 9 and CentOS 7.

## ✨ Project Overview

This is a Modern Linux Tools containerization project that packages cutting-edge command-line tools into Docker containers for AlmaLinux 9 and CentOS 7. The project creates portable environments with modern alternatives to traditional Unix tools like `ripgrep` (rg), `bat`, `fd`, `fzf`, and many others.

The `setupMe.sh` script can also be used to serve Singularity Sandbox deployments (if deployed on CVMFS) as a virtual environment on host machines, making the tools accessible directly on the host system without containerization.

## 🏗️  Architecture

### 🧩 Core Components

- **🐳 Dockerfiles**: Build containers with pre-installed modern tools
  - `alma9-linuxtools.Dockerfile` - Primary AlmaLinux 9 based container
  - `centos7-linuxtools.Dockerfile` - CentOS 7 based container
- **⚙️  Setup Scripts**: Environment initialization and tool management
  - `setupMe.sh` - Main setup script for initializing the micromamba environment and tools
  - `entrypoint.sh` - Docker container entrypoint that sources setup scripts
  - `_activate_current_env.sh` - Micromamba environment activation helper
- **📚 Tool Documentation**: 
  - `list-of-tools.md` - Comprehensive list of all included modern tools
  

### 📦 Package Management Strategy

The project uses **micromamba** as the primary package manager instead of traditional package managers. All tools are installed through conda-forge channels using micromamba, which provides:
- ⚡ Fast, lightweight package management
- 🌐 Cross-platform compatibility
- 🛡️  Easy environment isolation

### 🧰 Tool Categories

Tools are organized into functional categories:
- **🔍 Search/Explorer**: ripgrep (rg), ugrep, fzf, skim, fd-find, broot
- **📁 File Management**: yazi, lsd-rust, bat, glow-md, duf, dust, rip2
- **💻 Process/System**: procs, btop, mcfly
- **🐙 Git Tools**: gh, git-delta, git-lfs, lazygit
- **🧑‍💻 Development**: rust, cargo, uv (Python), tealdeer (tldr)
- **🤖 AI Tools**: gemini-cli, claude-code, copilot-api, goose
- **🐳 Container Tools**: crane, dive
- **🔧 Utilities**: hyperfine, direnv, zellij

## ⌨️  Common Commands

### 🧱 Building Containers
```bash
# Build AlmaLinux 9 container
docker build -f alma9-linuxtools.Dockerfile -t modern-linuxtools:alma9 .

# Build CentOS 7 container  
docker build -f centos7-linuxtools.Dockerfile -t modern-linuxtools:centos7 .
```

### ▶️ Running Containers
```bash
# Run interactive container with tools activated
docker run -it modern-linuxtools:alma9

# Run with volume mount for persistent work
docker run -it -v $(pwd):/workspace modern-linuxtools:alma9
```

### 🌳 Environment Management
```bash
# Source the setup script (automatically done in containers)
source setupMe.sh

# For Singularity/CVMFS deployments on host machines:
# Source setupMe.sh from the deployed path to activate tools in host environment
source /cvmfs/unpacked.cern.ch/registry.hub.docker.com/yesw2000/modern-linuxtools:alma9_x86-latest/setupMe.sh

# The Alma9 container is also compatible with CentOS7 hosts due to its reliance on glibc version 2.17.

# List all available tools with descriptions
list_tools

# Create new micromamba environment
mamba_new myenv

# Use git diff with delta highlighting
git_delta [git-diff-args]
```

### 💡 Tool Usage Examples
```bash
# Search files with ripgrep
rg "pattern" --type py

# Interactive file finder
fzf

# Modern ls replacement
lsd -la

# View files with syntax highlighting  
bat filename.py

# Process viewer
procs

# System monitor
btop

# Get quick help for any tool
tldr <command>
```

### 🖥️  On-host Virtual Environment

When using the on-host virtual environment by sourcing `setupMe.sh`, you will see the following message:

```bash
🚀 Modern Linux tools (micromamba, tldr, rg, and more) are now available!

- Run `list_tools` to view the complete list of new tools.
- For command usage, run `<command> --help` (e.g., `rg --help`).
- For quick examples (except for gemini, copilot-api, and goose),
  use `tldr <command>` (e.g., `tldr rg`).
A wrapper function `git_delta` is defined. Run `git_delta -h` for help
```

## 📝 Development Notes

- The setup script (`setupMe.sh`) handles architecture detection and micromamba initialization
- The script can be used both in Docker containers and as a virtual environment activator for Singularity/CVMFS deployments on host systems
- Tools are installed via micromamba to ensure consistent versions across environments
- The `git_delta` function wraps `git diff` with delta for enhanced output
- Cache directories are configured for optimal performance (tealdeer cache in CONDA_PREFIX)
- The entrypoint script enables bash with the setup script as rcfile for immediate tool availability

## ✍️  File Modifications

When modifying setup scripts, ensure:
- Architecture compatibility checks remain in place
- Micromamba environment activation works correctly
- Tool aliases and functions are preserved
- Cache directory configurations are maintained
