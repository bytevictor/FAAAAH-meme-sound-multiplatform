# byteFAAAH 🪟 Windows PowerShell

This folder contains the native Windows implementation for **PowerShell** and **Windows Terminal**.

## How it works ⚙️
It overrides the native `prompt` function. Before the prompt is drawn, it evaluates the boolean state of the last command (`$?`). If it equals `False` (command failed), it spawns a hidden background PowerShell instance that invokes `Media.SoundPlayer` to play the .wav file asynchronously. Zero blocking, zero overhead.

## Installation 💿
1. Open PowerShell and navigate to this `windows-powershell` folder:
   ```powershell
   cd windows-powershell
   ```
2. Run the installer:
   ```powershell
   .\install.ps1
   ```

> [!IMPORTANT]
> If PowerShell blocks script execution, you may need to run PowerShell as Administrator and execute `Set-ExecutionPolicy RemoteSigned`.

3. Reload your terminal or run `. $PROFILE`.

## Uninstallation 🏳️
Run the uninstaller script from this folder:
```powershell
.\uninstall.ps1
```
Then restart your terminal session.
