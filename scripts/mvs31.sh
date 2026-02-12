#!/bin/bash
#**********************************************************************************************
#*****     Script de arranque para z/OS 3.1 en Fedora 43 Workstation                     *****
#*****     Autor: Adaptado para Dell Latitude 5410                                        *****
#*****     Fecha: 2026-02-12                                                              *****
#**********************************************************************************************

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================================================${NC}"
echo -e "${GREEN}   Iniciando z/OS 3.1 en Hercules SDL 4.x Hyperion${NC}"
echo -e "${GREEN}   Sistema: Fedora 43 Workstation - Dell Latitude 5410${NC}"
echo -e "${GREEN}   CPU: Intel Core i5-10310U @ 1.70GHz (4C/8T)${NC}"
echo -e "${BLUE}======================================================================${NC}"

# Cambiar al directorio del script
cd "$(dirname "$0")"

# Verificar que existen los archivos necesarios
if [ ! -f "MF_31_LINUX.cnf" ]; then
    echo -e "${RED}ERROR: No se encuentra MF_31_LINUX.cnf${NC}"
    exit 1
fi

if [ ! -f "IPL31.rc" ]; then
    echo -e "${RED}ERROR: No se encuentra IPL31.rc${NC}"
    exit 1
fi

# Verificar que existen los directorios
if [ ! -d "shadow" ]; then
    echo -e "${BLUE}Creando directorio shadow...${NC}"
    mkdir -p shadow
fi

if [ ! -d "logs" ]; then
    echo -e "${BLUE}Creando directorio logs...${NC}"
    mkdir -p logs
fi

echo -e "${GREEN}Verificación completada. Iniciando Hercules...${NC}"
echo ""

# Abrir terminal para c3270 en segundo plano (opcional)
if command -v terminator &> /dev/null; then
    echo -e "${BLUE}Abriendo terminal 3270 en terminator...${NC}"
    terminator -e "c3270 127.0.0.1:3270" &
    sleep 2
elif command -v gnome-terminal &> /dev/null; then
    echo -e "${BLUE}Abriendo terminal 3270 en gnome-terminal...${NC}"
    gnome-terminal -- bash -c "c3270 127.0.0.1:3270; exec bash" &
    sleep 2
else
    echo -e "${BLUE}Para conectar al terminal 3270, ejecuta: c3270 127.0.0.1:3270${NC}"
fi

# Ejecutar Hercules con el archivo de configuración adaptado
hercules -f MF_31_LINUX.cnf
