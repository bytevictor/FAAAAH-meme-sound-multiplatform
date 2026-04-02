# FAAAAH-Listener 🪟 Windows PowerShell

Esta carpeta contiene la implementación nativa para **PowerShell** y **Windows Terminal**.

## ¿Cómo funciona? ⚙️

Sobrescribe la función nativa `prompt`. Antes de que se dibuje la nueva entrada, evalúa el estado del último comando ejecutado (`$?`). Si es `False` (el comando falló), lanza una instancia oculta de PowerShell en segundo plano que invoca a `Media.SoundPlayer` para reproducir el archivo .wav de forma asíncrona. Cero bloqueos, cero demoras en tu terminal.

## Instalación 💿

1. Abre PowerShell y navega hasta esta carpeta `windows-powershell`:
   ```powershell
   cd windows-powershell
   ```
2. Ejecuta el instalador:
   ```powershell
   .\install.ps1
   ```
   > [!IMPORTANT]
   > **Nota:** Si PowerShell te bloquea la ejecución de scripts, deberás abrirlo como Administrador y ejecutar `Set-ExecutionPolicy RemoteSigned` para permitir correr tus propios scripts.
3. Reinicia tu terminal o ejecuta `. $PROFILE`.

## Desinstalación 🏳️

Ejecuta el desinstalador desde esta misma carpeta:

```powershell
.\uninstall.ps1
```

Después reinicia tu sesión de terminal.
