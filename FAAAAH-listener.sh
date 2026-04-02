# Evitar carga doble
[ -n "$FAAAAH_INIT" ] && return
export FAAAAH_INIT=1

# ==========================================
# 1. INIT: Detectar entorno y preparar comando
# ==========================================
export FAAAAH_CMD=""

if grep -qi microsoft /proc/version 2>/dev/null; then
    # --- MODO WSL ---
    FAAAAH_WAV="/mnt/c/Users/Public/.faaaah-listener/FAAAAH.wav"
    WIN_PATH="C:\Users\Public\.faaaah-listener\FAAAAH.wav"
    
    if [ -f "$FAAAAH_WAV" ]; then
        # Cacheamos el comando exacto de PowerShell para no tener que escapar comillas luego
        FAAAAH_CMD="powershell.exe -c \"(New-Object Media.SoundPlayer '$WIN_PATH').PlaySync()\""
    fi
else
    # --- MODO MAC / LINUX NATIVO ---
    FAAAAH_WAV="$HOME/.faaaah-listener/FAAAAH.wav"
    
    if [ -f "$FAAAAH_WAV" ]; then
        if [ -x "$(command -v afplay 2>/dev/null)" ]; then
            FAAAAH_CMD="$(command -v afplay) \"$FAAAAH_WAV\""
        elif [ -x "$(command -v paplay 2>/dev/null)" ]; then
            FAAAAH_CMD="$(command -v paplay) \"$FAAAAH_WAV\""
        elif [ -x "$(command -v aplay 2>/dev/null)" ]; then
            FAAAAH_CMD="$(command -v aplay) -q \"$FAAAAH_WAV\""
        fi
    fi
fi

# ==========================================
# 2. RUNTIME: El hook O(1)
# ==========================================
cmd_fail_listener() {
    local exit_code=$? 
    # Evaluamos el comando pre-procesado usando 'eval' de forma segura y en segundo plano
    [ $exit_code -ne 0 ] && [ -n "$FAAAAH_CMD" ] && eval "$FAAAAH_CMD" &>/dev/null &
}

# ==========================================
# 3. SETUP: Integración con la shell
# ==========================================
if [ -n "$BASH_VERSION" ]; then
    PROMPT_COMMAND="cmd_fail_listener; $PROMPT_COMMAND"
elif [ -n "$ZSH_VERSION" ]; then
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd cmd_fail_listener
fi