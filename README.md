# sqlvm

A lightweight CLI tool for managing a QEMU-based SQL Server VM on macOS — no Docker Desktop required.

---

## ❓ Why

Docker Desktop is heavy, GUI-bound, and incompatible with SQL Server on Apple Silicon without workarounds.  
**`sqlvm`** solves that by giving you a fully terminal-based VM runner using QEMU that mimics the ease of `docker compose up/down`.

Ideal for:
- Developers on macOS ARM (M1/M2/M3) needing SQL Server locally
- CLI-first users
- Repeatable VM-based dev setups

---

## ⚙️ Pre-installations

To use `sqlvm`, you need:

- **QEMU**
```bash
  brew install qemu
```

- **TMUX (Optional: if you want to run the VM interactively)**
```bash
  brew install qemu
```

---

## 🛠️ Install

1. Clone the repository:

   ```bash
   git clone https://github.com/algermosen/sqlvm.git ~/bin/sqlvm
   cd ~/bin/sqlvm
   ```

2. Run the installer:

   ```bash
   ./install.sh
   ```

3. After that, use the `sqlvm` command from anywhere:

   ```bash
   sqlvm up
   sqlvm down
   sqlvm status
   ```

---

## 🚀 Use

*Working on...*
