#!/bin/bash
#**********************************************************************************************
#*****     Script de Verificación del Entorno z/OS 3.1                                   *****
#*****     Verifica prerequisitos y estado del sistema                                    *****
#**********************************************************************************************

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

ERRORS=0
WARNINGS=0

echo -e "${BLUE}======================================================================${NC}"
echo -e "${BLUE}   Verificación del Entorno z/OS 3.1 - Hercules SDL${NC}"
echo -e "${BLUE}   Sistema: Fedora 43 - Dell Latitude 5410${NC}"
echo -e "${BLUE}======================================================================${NC}"
echo ""

# Función para OK
print_ok() {
    echo -e "${GREEN}✓${NC} $1"
}

# Función para ERROR
print_error() {
    echo -e "${RED}✗${NC} $1"
    ((ERRORS++))
}

# Función para WARNING
print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

# Verificar directorio
echo -e "${BLUE}[1] Verificando Directorio de Trabajo...${NC}"
if [ "$(basename $(pwd))" = "IBM-ZOS_V3R1" ]; then
    print_ok "Directorio correcto: $(pwd)"
else
    print_error "No estás en el directorio IBM-ZOS_V3R1"
    echo "    Ejecuta: cd /home/d5410/IBM_HOST/IBM-ZOS_V3R1"
fi
echo ""

# Verificar Hercules
echo -e "${BLUE}[2] Verificando Software...${NC}"
if command -v hercules &> /dev/null; then
    HERC_VER=$(hercules -v 2>&1 | head -1 | awk '{print $4}')
    print_ok "Hercules instalado: versión $HERC_VER"
else
    print_error "Hercules NO instalado"
    echo "    Instala con: sudo dnf install hercules"
fi

if command -v c3270 &> /dev/null; then
    print_ok "c3270 instalado"
else
    print_warning "c3270 NO instalado (opcional)"
    echo "    Instala con: sudo dnf install c3270"
fi

if command -v terminator &> /dev/null; then
    print_ok "terminator instalado"
elif command -v gnome-terminal &> /dev/null; then
    print_ok "gnome-terminal instalado"
else
    print_warning "No hay emulador de terminal instalado"
fi
echo ""

# Verificar archivos de configuración
echo -e "${BLUE}[3] Verificando Archivos de Configuración...${NC}"
if [ -f "MF_31_LINUX.cnf" ]; then
    SIZE=$(stat -c%s "MF_31_LINUX.cnf")
    if [ $SIZE -gt 1000 ]; then
        print_ok "MF_31_LINUX.cnf existe ($SIZE bytes)"
    else
        print_error "MF_31_LINUX.cnf muy pequeño"
    fi
else
    print_error "MF_31_LINUX.cnf NO existe"
fi

if [ -f "IPL31.rc" ]; then
    print_ok "IPL31.rc existe"
else
    print_error "IPL31.rc NO existe"
fi

if [ -x "mvs31.sh" ]; then
    print_ok "mvs31.sh existe y es ejecutable"
else
    print_warning "mvs31.sh no ejecutable"
    echo "    Ejecuta: chmod +x mvs31.sh"
fi
echo ""

# Verificar volúmenes CCKD
echo -e "${BLUE}[4] Verificando Volúmenes DASD...${NC}"
REQUIRED_VOLS=(
    "Z31VS1.CCKD"
    "D31VS1.CCKD"
    "DEVVS1.CCKD"
    "PRDVS1.CCKD"
    "CICS61.CCKD"
    "DB2V13.CCKD"
    "IMSV15.CCKD"
    "MQCD93.CCKD"
)

MISSING_VOLS=0
for VOL in "${REQUIRED_VOLS[@]}"; do
    if [ -f "$VOL" ]; then
        SIZE=$(du -h "$VOL" | cut -f1)
        print_ok "$VOL existe ($SIZE)"
    else
        print_error "$VOL NO existe"
        ((MISSING_VOLS++))
    fi
done

TOTAL_CCKD=$(ls -1 *.CCKD 2>/dev/null | wc -l)
TOTAL_SIZE=$(du -sh . 2>/dev/null | cut -f1)
echo ""
echo -e "    Total de volúmenes CCKD: ${GREEN}$TOTAL_CCKD${NC}"
echo -e "    Tamaño total del directorio: ${GREEN}$TOTAL_SIZE${NC}"
echo ""

# Verificar directorios
echo -e "${BLUE}[5] Verificando Directorios de Trabajo...${NC}"
if [ -d "shadow" ]; then
    SHADOW_COUNT=$(ls -1 shadow/ 2>/dev/null | wc -l)
    SHADOW_SIZE=$(du -sh shadow/ 2>/dev/null | cut -f1)
    print_ok "Directorio shadow/ existe ($SHADOW_COUNT archivos, $SHADOW_SIZE)"
else
    print_warning "Directorio shadow/ NO existe"
    echo "    Se creará automáticamente al ejecutar mvs31.sh"
fi

if [ -d "logs" ]; then
    if [ -f "logs/logzOS" ]; then
        LOG_SIZE=$(du -h logs/logzOS 2>/dev/null | cut -f1)
        print_ok "Directorio logs/ existe (log actual: $LOG_SIZE)"
    else
        print_ok "Directorio logs/ existe (sin logs previos)"
    fi
else
    print_warning "Directorio logs/ NO existe"
    echo "    Se creará automáticamente al ejecutar mvs31.sh"
fi
echo ""

# Verificar recursos del sistema
echo -e "${BLUE}[6] Verificando Recursos del Sistema Host...${NC}"
TOTAL_MEM=$(free -g | grep Mem | awk '{print $2}')
FREE_MEM=$(free -g | grep Mem | awk '{print $7}')
if [ $FREE_MEM -ge 12 ]; then
    print_ok "Memoria disponible: ${FREE_MEM}GB de ${TOTAL_MEM}GB (suficiente)"
elif [ $FREE_MEM -ge 8 ]; then
    print_warning "Memoria disponible: ${FREE_MEM}GB de ${TOTAL_MEM}GB (justa)"
    echo "    Considera cerrar aplicaciones para mejor rendimiento"
else
    print_error "Memoria disponible: ${FREE_MEM}GB de ${TOTAL_MEM}GB (insuficiente)"
    echo "    z/OS 3.1 requiere 12GB. Reduce MAINSIZE en MF_31_LINUX.cnf"
fi

CPU_CORES=$(nproc)
if [ $CPU_CORES -ge 6 ]; then
    print_ok "CPUs disponibles: $CPU_CORES cores (suficiente)"
elif [ $CPU_CORES -ge 4 ]; then
    print_warning "CPUs disponibles: $CPU_CORES cores (justa)"
    echo "    Considera reducir NUMCPU en MF_31_LINUX.cnf"
else
    print_error "CPUs disponibles: $CPU_CORES cores (insuficiente)"
fi

DISK_FREE=$(df -h . | tail -1 | awk '{print $4}')
print_ok "Espacio libre en disco: $DISK_FREE"
echo ""

# Verificar puerto 3270
echo -e "${BLUE}[7] Verificando Puerto 3270...${NC}"
if netstat -tuln 2>/dev/null | grep -q ":3270"; then
    PID=$(lsof -ti :3270 2>/dev/null)
    print_warning "Puerto 3270 YA ESTÁ EN USO (PID: $PID)"
    echo "    Si es Hercules, está bien. Si no, mata el proceso:"
    echo "    sudo kill -9 $PID"
else
    print_ok "Puerto 3270 libre"
fi
echo ""

# Verificar documentación
echo -e "${BLUE}[8] Verificando Documentación...${NC}"
DOCS=("README.md" "QUICKSTART.md" "INDICE_DOCUMENTACION.md" "DIFERENCIAS_PUERTO_3270_vs_992.md")
for DOC in "${DOCS[@]}"; do
    if [ -f "$DOC" ]; then
        LINES=$(wc -l "$DOC" | awk '{print $1}')
        print_ok "$DOC ($LINES líneas)"
    else
        print_warning "$DOC NO existe"
    fi
done
echo ""

# Resumen final
echo -e "${BLUE}======================================================================${NC}"
echo -e "${BLUE}   RESUMEN DE VERIFICACIÓN${NC}"
echo -e "${BLUE}======================================================================${NC}"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ TODO CORRECTO${NC} - El sistema está listo para ejecutar"
    echo ""
    echo -e "Para iniciar z/OS 3.1, ejecuta:"
    echo -e "    ${GREEN}./mvs31.sh${NC}"
    echo ""
    EXIT_CODE=0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠ $WARNINGS ADVERTENCIAS${NC} - El sistema puede funcionar pero revisa las advertencias"
    echo ""
    EXIT_CODE=0
else
    echo -e "${RED}✗ $ERRORS ERRORES${NC} - Corrige los errores antes de continuar"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}⚠ $WARNINGS ADVERTENCIAS${NC} - También hay advertencias"
    fi
    echo ""
    EXIT_CODE=1
fi

echo -e "${BLUE}======================================================================${NC}"

exit $EXIT_CODE
