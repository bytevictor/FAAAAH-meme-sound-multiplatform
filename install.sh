#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

INSTALL_DIR="$HOME/.faaaah-listener"

echo -e "${BLUE}Instalando FAAAAH-Listener...${NC}"

# Crear directorio de Linux para el script
mkdir -p "$INSTALL_DIR"
cp FAAAAH-listener.sh "$INSTALL_DIR/"

# ==========================================
# GESTIÓN DEL AUDIO (WSL vs Nativo)
# ==========================================
if grep -qi microsoft /proc/version 2>/dev/null; then
    echo "¡Detectado WSL! Guardando audio en territorio de Windows..."
    # Directorio oculto en la carpeta Pública de Windows
    AUDIO_DIR="/mnt/c/Users/Public/.faaaah-listener"
    mkdir -p "$AUDIO_DIR"
else
    # Linux nativo / macOS
    AUDIO_DIR="$INSTALL_DIR"
fi

if [ -f "FAAAAH.wav" ]; then
    cp FAAAAH.wav "$AUDIO_DIR/"
else
    echo "⚠️ No se encontró el archivo FAAAAH.wav."
    echo "Asegúrate de convertirlo a .wav y dejarlo en esta carpeta."
fi

# ==========================================
# INYECCIÓN EN LA SHELL
# ==========================================
SHELL_RC=""
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_RC="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    SHELL_RC="$HOME/.bashrc"
fi

if [ -n "$SHELL_RC" ]; then
    SOURCE_LINE="source $INSTALL_DIR/FAAAAH-listener.sh"
    
    if grep -qF "$SOURCE_LINE" "$SHELL_RC"; then
        echo "Ya estaba configurado en $SHELL_RC. Task failed successfully."
    else
        echo -e "\n# FAAAAH-Listener\n$SOURCE_LINE" >> "$SHELL_RC"
    fi
    
    echo -e "${GREEN}¡Instalación completada!${NC}"
    echo "Para aplicar los cambios, ejecuta: source $SHELL_RC"
else
    echo "Añade esta línea a tu configuración manualmente:"
    echo "source $INSTALL_DIR/FAAAAH-listener.sh"
fi