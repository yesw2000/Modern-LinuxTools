# 🧰 Modern Linux Tools: The Ultimate Toolkit 🧰

Here is a detailed explanation of the tools included in the container, along with their official URLs:

### 📦 Package Management

*   **micromamba**: A lightweight, fast, and standalone conda-compatible package and environment manager. It's used as the primary package manager in this project to ensure consistent and isolated environments.
    *   **URL**: [https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html](https://mamba.readthedocs.io/en/latest/user_guide/micromamba.html)
*   **uv**: An extremely fast Python package and environment manager, written in Rust. It's an all-in-one tool intended to replace `pip`, `pip-tools`, `virtualenv`, and other similar tools.
    *   **URL**: [https://github.com/astral-sh/uv](https://github.com/astral-sh/uv)

### 🔍 Search & Explorer

*   **ripgrep (rg)**: A line-oriented search tool that recursively searches your current directory for a regex pattern. It's known for its speed and by default respects your `.gitignore`.
    *   **URL**: [https://github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
*   **ugrep**: A powerful and user-friendly file pattern searcher that is often faster than `grep`. It features a text-based user interface for interactive searching and can search within compressed files and archives.
    *   **URL**: [https://github.com/Genivia/ugrep](https://github.com/Genivia/ugrep)
*   **fzf**: A general-purpose command-line fuzzy finder that allows you to interactively search and select files, command history, processes, and more.
    *   **URL**: [https://github.com/junegunn/fzf](https://github.com/junegunn/fzf)
*   **skim (sk)**: A fuzzy finder written in Rust, similar to `fzf`. It's designed to be a general-purpose filter that can be used with other commands.
    *   **URL**: [https://github.com/lotabout/skim](https://github.com/lotabout/skim)
*   **fd**: A simple, fast, and user-friendly alternative to `find`. It has sensible defaults, colorized output, and a more intuitive syntax.
    *   **URL**: [https://github.com/sharkdp/fd](https://github.com/sharkdp/fd)
*   **broot**: An interactive tree-based file manager that helps you navigate directory structures and find files, with a focus on providing a clear overview of your filesystem.
    *   **URL**: [https://dystroy.org/broot/](https://dystroy.org/broot/)

### 📁 File Management

*   **yazi**: A fast, terminal-based file manager with Vim-like keybindings. It's written in Rust and features file previews for various formats.
    *   **URL**: [https://github.com/sxyazi/yazi](https://github.com/sxyazi/yazi)
*   **lsd**: A modern replacement for the `ls` command with more colors, icons, and a tree view.
    *   **URL**: [https://github.com/lsd-rs/lsd](https://github.com/lsd-rs/lsd)
*   **bat**: A `cat` clone with syntax highlighting and Git integration. It's great for viewing files directly in the terminal.
    *   **URL**: [https://github.com/sharkdp/bat](https://github.com/sharkdp/bat)
*   **glow**: A terminal-based Markdown reader that makes reading documentation and other Markdown files a pleasant experience.
    *   **URL**: [https://github.com/charmbracelet/glow](https://github.com/charmbracelet/glow)
*   **duf**: A disk usage/free space utility that provides a user-friendly, colorized output, making it a great alternative to `df`.
    *   **URL**: [https://github.com/muesli/duf](https://github.com/muesli/duf)
*   **dust**: A more intuitive version of the `du` command, written in Rust. It gives you an instant overview of which directories are using the most disk space.
    *   **URL**: [https://github.com/bootandy/dust](https://github.com/bootandy/dust)
*   **rip2**: A safe and ergonomic alternative to the `rm` command. Instead of permanently deleting files, it moves them to a "graveyard" directory for easy recovery.
    *   **URL**: [https://github.com/nivekuil/rip2](https://github.com/nivekuil/rip2)

### 💻 Process & System

*   **procs**: A modern replacement for `ps` with a more user-friendly, colorized output. It can also show information like TCP/UDP ports and Docker container names.
    *   **URL**: [https://github.com/dalance/procs](https://github.com/dalance/procs)
*   **btop**: A resource monitor that shows usage and stats for the processor, memory, disks, network, and processes in a visually appealing and interactive way.
    *   **URL**: [https://github.com/aristocratos/btop](https://github.com/aristocratos/btop)
*   **mcfly**: An intelligent shell history tool that replaces your standard `Ctrl+R` search with a context-aware search that prioritizes commands you've used in the current directory.
    *   **URL**: [https://github.com/cantino/mcfly](https://github.com/cantino/mcfly)

### 🐙 Git Tools

*   **gh**: The official GitHub command-line tool. It brings pull requests, issues, and other GitHub concepts to the terminal.
    *   **URL**: [https://cli.github.com/](https://cli.github.com/)
*   **git-delta**: A syntax-highlighting pager for `git diff`, `git log`, and other git commands, making it easier to review code changes.
    *   **URL**: [https://github.com/dandavison/delta](https://github.com/dandavison/delta)
*   **git-lfs**: A Git extension for versioning large files. It replaces large files such as audio samples, videos, datasets, and graphics with tiny text pointers in your repository.
    *   **URL**: [https://git-lfs.github.com/](https://git-lfs.github.com/)
*   **lazygit**: A simple terminal UI for git commands. It allows you to easily manage your repository without having to memorize all the git commands.
    *   **URL**: [https://github.com/jesseduffield/lazygit](https://github.com/jesseduffield/lazygit)

### 🧑‍💻 Development

*   **rust** & **cargo**: The Rust programming language and its official build tool and package manager.
    *   **URL**: [https://www.rust-lang.org/](https://www.rust-lang.org/)
*   **tealdeer (tldr)**: A very fast implementation of `tldr`, which provides simplified and community-driven man pages with practical examples.
    *   **URL**: [https://github.com/dbrgn/tealdeer](https://github.com/dbrgn/tealdeer)

### 🤖 AI Tools

*   **gemini-cli**: A command-line interface for Google's Gemini AI models, allowing you to interact with the AI for coding, debugging, and other tasks.
    *   **URL**: [https://github.com/google/gemini-cli](https://github.com/google/gemini-cli)
*   **claude-code**: An AI coding assistant from Anthropic that runs in your terminal, helping you with a variety of development tasks.
    *   **URL**: [https://www.anthropic.com/claude-in-the-terminal](https://www.anthropic.com/claude-in-the-terminal)
*   **copilot-api**: A tool that exposes GitHub Copilot as an API, allowing it to be used with a wider range of applications.
    *   **URL**: [https://github.com/copilot-cli/copilot-api](https://github.com/copilot-cli/copilot-api)
*   **goose**: A local, extensible, open-source AI agent that can automate engineering tasks.
    *   **URL**: [https://github.com/block/goose](https://github.com/block/goose)

### 🐳 Container Tools

*   **crane**: A tool for interacting with remote container images and registries without needing a local Docker daemon.
    *   **URL**: [https://github.com/google/go-containerregistry/tree/main/cmd/crane](https://github.com/google/go-containerregistry/tree/main/cmd/crane)
*   **dive**: A tool for exploring a Docker image, layer by layer, to discover ways to shrink its size.
    *   **URL**: [https://github.com/wagoodman/dive](https://github.com/wagoodman/dive)

### 🔧 Utilities

*   **hyperfine**: A command-line benchmarking tool that provides statistical analysis of command execution times.
    *   **URL**: [https://github.com/sharkdp/hyperfine](https://github.com/sharkdp/hyperfine)
*   **direnv**: An environment switcher for the shell. It loads and unloads environment variables depending on the current directory.
    *   **URL**: [https://direnv.net/](https://direnv.net/)
*   **zellij**: A terminal workspace and multiplexer that allows you to run multiple terminal applications in a single window, with a user-friendly interface.
    *   **URL**: [https://zellij.dev/](https://zellij.dev/)
