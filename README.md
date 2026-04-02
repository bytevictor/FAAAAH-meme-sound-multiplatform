# byteFAAAH 📢🐧

> Add FAAAAAH meme sound to your shell on every non-0 command output. Task failed successfully.

_[Leer en Español](README.es.md)_

https://github.com/user-attachments/assets/e4fc78da-d3ff-4031-be68-8e9b20ad142d

## How it works ⚙️

We hook into your shell's lifecycle:

- **Bash**: Abusing the `PROMPT_COMMAND` environment variable.
- **Zsh**: Using `precmd` via `add-zsh-hook`.

Right before dropping a new prompt, the script checks if the last command failed (`$? != 0`). If it did, it spawns an isolated background subshell to play the sound. Zero overhead, zero UI blocking. Just auditory feedback.

> [!TIP]
>
> - 🟦 **Native Windows (PowerShell)**: We have a dedicated, pure PowerShell implementation. See the [windows-powershell](./windows-powershell) folder for details!

## OS Support 🌍

We added native support for:

- 🐧 **Native Linux**: Automatically finds your system's default audio players (`paplay` for PulseAudio, `aplay` for ALSA).
- 🍎 **macOS**: Uses the built-in `afplay` command.
- 🪟 **WSL (Windows Subsystem for Linux)**:
  Playing audio inside WSL requires annoying external setups. We bypassed them entirely.

  **How?** The script detects WSL, copies the `FAAAAH.wav` file to `C:\Users\Public\.faaaah-listener\`, and uses WSL's interoperability to call **PowerShell** (`powershell.exe`) and play the sound using native Windows `Media.SoundPlayer`. It just works™.

## Installation 💿

1. Clone or download this repo somewhere safe.
2. Run the install script:
   ```bash
   ./install.sh
   ```
3. Reload your shell and make a typo on purpose:
   ```bash
   source ~/.zshrc # (or ~/.bashrc)
   ```

## Uninstallation 🏳️

To remove the listener:

```bash
./uninstall.sh
```

Then reload your shell to kill the background process.
