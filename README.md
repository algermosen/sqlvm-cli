# sqlvm

A lightweight CLI tool for managing a QEMU-based SQL Server VM on macOS — no Docker Desktop required.

---

## 🧐 Why

Docker Desktop isn't always ideal for lightweight setups. `sqlvm` gives you full control to:
- Run SQL Server in a QEMU-based VM
- Avoid Docker Desktop's overhead
- Script and automate everything from the terminal
 
**`sqlvm`** solves that by giving you a fully terminal-based VM runner using QEMU that mimics the ease of `docker compose up/down`.

Ideal for:
- Developers on macOS ARM (M1/M2/M3) needing SQL Server locally
- CLI-first users
- Repeatable VM-based dev setups

---

## ⚙️ Pre-installations

To use `sqlvm`, you need:

- **QEMU** – Required to emulate the virtual machine:
  ```bash
  brew install qemu
  ```

- **Netcat** – Used to check if SQL Server is listening (for `sqlvm ready`):
  ```bash
  brew install netcat
  ```

- **GitHub CLI** – (Optional) for pushing GitHub releases via `--gh`:
  ```bash
  brew install gh
  ```

- **TMUX** – (Optional) if you want to run the VM interactively in a terminal multiplexer:
  ```bash
  brew install tmux
  ```

Also ensure:
- You’re using `zsh` or `bash`

---

## 🛠️ Install

**1. Clone the repository:**

   ```bash
   git clone https://github.com/algermosen/sqlvm-cli.git ~/bin/sqlvm-cli
   cd ~/bin/sqlvm-cli
   ```

**2. Make sure install script is executable**

   ```bash
   chmod +x install.sh
   ```

**3. Run the installer:**

   ```bash
   ./install.sh # or bash install.sh
   ```

**4. Reload your shell (if needed)**

   ``` bash
   source ~/.zshrc # or source ~/.bashrc
   ```

**5. Verify installation**

   ```bash
   sqlvm --version
   ```

   You should see:
   ```
   0.0.1
   ```

---

## 🚀 Use

Run `sqlvm <command>` to execute available actions:

### 🔧 VM Management
- `sqlvm init` – Create a base VM using a Ubuntu ISO
- `sqlvm up` – Boot the VM (use `--headless` to run without window)
- `sqlvm down` – Gracefully power off the VM
- `sqlvm restart` – Restart the VM cleanly
- `sqlvm rebuild` – Destroy and recreate the VM with fresh config

### 💡 Diagnostics
- `sqlvm status` – Check if the VM process is running
- `sqlvm logs` – View the latest QEMU logs
- `sqlvm ready` – Check if SQL Server is listening on port 1433
- `sqlvm ip` – Get the current IP of the VM (use `--port <PORT>` to test connectivity)

### 🔐 Access & Utilities
- `sqlvm ssh` – SSH into the running VM
- `sqlvm backup --database <name>` – Create a `.bak` file of a specific DB
- `sqlvm uninstall` – Remove the CLI, symlinks, and optionally the project folder

### 📦 Development & Releases
- `sqlvm --version` – Show current CLI version
- `bash release.sh --gh --message "Release note"` – Create Git tag + GitHub release
