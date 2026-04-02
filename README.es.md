# FAAAAH-Listener 📢🐧

> Añade el sonido del meme "FAAAAH" a tu terminal cada vez que un comando falla. Task failed successfully.

_[Read in English](README.md)_

<video src="https://raw.githubusercontent.com/bytevictor/byteFAAAAH/master/demo.mp4" controls="controls" width="100%"></video>

## ¿Cómo funciona? ⚙️

Nos enganchamos al ciclo de vida de tu shell:

- **Bash**: Abusando de la variable de entorno `PROMPT_COMMAND`.
- **Zsh**: Usando la función `precmd` mediante `add-zsh-hook`.

Justo antes de mostrarte un nuevo prompt, el script comprueba si el último comando falló (`$? != 0`). Si falló, lanza un subproceso aislado en segundo plano que reproduce el sonido. Cero bloqueos, cero overhead. Solo puro feedback auditivo.

## Soporte Multiplataforma 🌍

Añadimos soporte directo para:

- 🐧 **Linux Nativo**: Automáticamente detecta y usa los reproductores de tu sistema (`paplay` para PulseAudio, `aplay` para ALSA).
- 🍎 **macOS**: Utiliza el comando integrado `afplay`.
- 🪟 **WSL (Windows Subsystem for Linux)**:
  Reproducir audio dentro de WSL suele requerir molestas configuraciones externas. Nos las saltamos todas.

  **¿Cómo?** El script detecta WSL, copia el archivo `FAAAAH.wav` a `C:\Users\Public\.faaaah-listener\`, y usa la interoperabilidad de WSL para llamar a **PowerShell** (`powershell.exe`) para que reproduzca el sonido de forma nativa en Windows (`Media.SoundPlayer`). Simplemente funciona™.

> [!TIP]
>
> - 🟦 **Windows Nativo (PowerShell)**: Tenemos una implementación separada usando PowerShell puro. ¡Echa un vistazo a la carpeta [windows-powershell](./windows-powershell) para más detalles!

## Instalación 💿

1. Clona o descarga este repo en tu PC.
2. Ejecuta el script de instalación:
   ```bash
   ./install.sh
   ```
3. Recarga tu terminal y escribe algo mal a propósito para probarlo:
   ```bash
   source ~/.zshrc # (o ~/.bashrc)
   ```

## Desinstalación 🏳️

Para eliminar el listener:

```bash
./uninstall.sh
```

Luego recarga tu shell para matar el proceso en segundo plano.
