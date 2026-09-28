#!/usr/bin/env bash
# Script de Instalación y Actualización Automática para dkript-governance (Linux/macOS)
set -e

REPO_URL="${1:-https://github.com/dkript-web/Dkript-Governance.git}"
TARGET_DIR="$HOME/.gemini/config/plugins/dkript-governance"

# Colores ANSI
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}==========================================================${NC}"
echo -e "${CYAN} 🛡️  Instalador Oficial Dkript Governance & Subagents Pack ${NC}"
echo -e "${CYAN}==========================================================${NC}"

if ! command -v git &> /dev/null; then
    echo -e "${RED}[!] Error: 'git' no está instalado o no se encuentra en el PATH.${NC}"
    exit 1
fi

if [ -d "$TARGET_DIR" ]; then
    echo -e "${YELLOW}[i] Plugin detectado en: $TARGET_DIR${NC}"
    if [ -d "$TARGET_DIR/.git" ]; then
        echo -e "${CYAN}[>] Actualizando última versión desde repositorio remoto...${NC}"
        git -C "$TARGET_DIR" fetch origin main
        git -C "$TARGET_DIR" reset --hard origin/main
    else
        echo -e "${YELLOW}[!] El directorio existe sin repositorio Git. Sincronizando con repositorio oficial...${NC}"
        TEMP_DIR=$(mktemp -d)
        git clone --depth 1 "$REPO_URL" "$TEMP_DIR"
        cp -rf "$TEMP_DIR"/* "$TARGET_DIR"/
        [ -d "$TEMP_DIR/.git" ] && cp -rf "$TEMP_DIR/.git" "$TARGET_DIR"/
        rm -rf "$TEMP_DIR"
    fi
else
    echo -e "${GREEN}[>] Instalando plugin en: $TARGET_DIR...${NC}"
    mkdir -p "$(dirname "$TARGET_DIR")"
    git clone "$REPO_URL" "$TARGET_DIR"
fi

if command -v agy &> /dev/null; then
    echo -e "${CYAN}[>] Habilitando plugin en Antigravity CLI...${NC}"
    agy plugin enable dkript-governance 2>/dev/null || true
fi

echo ""
echo -e "${GREEN}✔ Instalación y sincronización completada exitosamente.${NC}"
echo -e "${CYAN}📦 Subagentes disponibles: php-reviewer, database-reviewer, a11y-architect, build-error-resolver${NC}"
echo -e "${CYAN}📋 Reglas de gobernanza Dkript activas en tu entorno global.${NC}"
