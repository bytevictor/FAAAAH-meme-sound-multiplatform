#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${RED}Desinstalando FAAAAH-Listener...${NC}"

# 1. Borrar carpetas de instalación
LINUX_DIR="$HOME/.faaaah-listener"
WIN_DIR="/mnt/c/Users/Public/.faaaah-listener"

if [ -d "$LINUX_DIR" ]; then
    rm -rf "$LINUX_DIR"
    echo "✔ Carpeta de Linux eliminada ($LINUX_DIR)."
fi

if [ -d "$WIN_DIR" ]; then
    rm -rf "$WIN_DIR"
    echo "✔ Carpeta de Windows eliminada ($WIN_DIR)."
fi

# 2. Limpiar los archivos de configuración de la terminal
for rc_file in "$HOME/.zshrc" "$HOME/.bashrc"; do
    if [ -f "$rc_file" ]; then
        # Comprobamos si hay rastro del proyecto en el archivo
        if grep -qi "faaaah-listener" "$rc_file"; then
            # Usamos grep -v para quitar las líneas exactas que añadimos y sobrescribimos
            grep -v "# FAAAAH-Listener" "$rc_file" | grep -v "\.faaaah-listener/FAAAAH-listener.sh" > "${rc_file}.tmp"
            mv "${rc_file}.tmp" "$rc_file"
            echo "✔ Rastro limpiado en $rc_file"
        fi
    fi
done

echo -e "${GREEN}¡Desinstalación completa!${NC}"
echo "El sistema está limpio. Para matar el proceso que sigue en esta sesión, reinicia la terminal o ejecuta:"
echo "source ~/.zshrc (o bashrc)"