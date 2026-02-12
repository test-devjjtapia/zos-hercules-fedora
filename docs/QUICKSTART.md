# 🚀 Guía Rápida de Inicio - z/OS 3.1

## ⚡ Inicio Rápido (5 minutos)

### 1️⃣ Arrancar el Sistema
```bash
cd /home/d5410/IBM_HOST/IBM-ZOS_V3R1
./mvs31.sh
```

### 2️⃣ Conectar al Terminal (otra terminal)
```bash
c3270 127.0.0.1:3270
```

### 3️⃣ Hacer IPL (en consola Hercules)
```
ipl DE27
```

### 4️⃣ Responder Prompts del IPL
- Cuando veas `IEA101A SPECIFY SYSTEM PARAMETERS` → **ENTER**
- Cuando veas `IEE094A SPECIFY OPERAND(S) FOR BPXPRM` → **ENTER**

### 5️⃣ Login en TSO (terminal c3270)
```
Usuario: ibmuser
Password: welcome0welcome0
```

> **⚠️ IMPORTANTE**: Cambia la contraseña inmediatamente después del primer login

---

## 📋 Comandos Esenciales

### Consola de Hercules
```bash
ipl DE27              # Arrancar z/OS
stop                  # Apagar z/OS (shutdown ordenado)
quit                  # Salir de Hercules
devlist               # Listar dispositivos
fac query enabled     # Ver CPU facilities habilitadas
```

### Consola z/OS (MCS)
```
D A,ALL               # Display todos los address spaces
D U,DASD,ONLINE       # Ver discos online
D NET,ID=*            # Ver network devices
D M=CPU               # Ver uso de CPU
$DA                   # Display JES2 activo
```

### TSO/ISPF
```
LOGON IBMUSER         # Login
L                     # Ejecutar LOGON
ISPF                  # Iniciar ISPF
=3.4                  # Browse datasets
=6                   # Comandos TSO
=X                    # Exit ISPF
LOGOFF                # Salir de TSO
```

---

## 🔧 Solución Rápida de Problemas

### ❌ "Cannot open configuration file"
```bash
cd /home/d5410/IBM_HOST/IBM-ZOS_V3R1
ls -la MF_31_LINUX.cnf
```

### ❌ "Cannot connect to 127.0.0.1:3270"
```bash
netstat -tuln | grep 3270
# Debe aparecer: tcp 0 0 127.0.0.1:3270 ... LISTEN
```

### ❌ "IPL se cuelga"
En consola Hercules:
```
fac ena 054
fac ena 129
fac ena 130
fac ena 134
fac ena 135
ipl DE27
```

### ❌ "Sistema muy lento"
```bash
# Reducir CPUs en MF_31_LINUX.cnf
NUMCPU    4          # En lugar de 6

# O reducir RAM
MAINSIZE  8G         # En lugar de 12G
```

---

## 📁 Archivos Importantes

| Archivo | Descripción |
|---------|-------------|
| `MF_31_LINUX.cnf` | Configuración principal (USAR ESTE) |
| `MF_31.cnf` | Original Windows (NO USAR) |
| `IPL31.rc` | Script de facilities para IPL |
| `mvs31.sh` | Script de arranque automático |
| `README.md` | Documentación completa (LEER) |
| `logs/logzOS` | Log de Hercules |
| `shadow/*` | Cambios temporales en discos |

---

## 💾 Volúmenes Clave

| Dirección | Contenido | IPL? |
|-----------|-----------|------|
| **DE27** | Z31VS1 - Sistema principal | ✅ IPL AQUÍ |
| DE26 | D31VS1 - Datos | ❌ |
| DE25 | CICS61 - CICS 6.1 | ❌ |
| DE30 | DB2V13 - DB2 v13 | ❌ |
| DE2E | MQCD93 - MQ 9.3 | ❌ |
| DE2B | IMSV15 - IMS v15 | ❌ |

---

## 🔑 Usuarios por Defecto

| Usuario | Password | Privilegios | Fuente |
|---------|----------|-------------|--------|
| **ibmuser** | **welcome0welcome0** | Admin completo | ✅ Archive.org |
| IBMUSER | SYS1 | Admin completo | Alternativo |
| ADCDMST | ADCDMST | Admin completo | ADCD |
| ADCDA-ADCDZ | TEST1 | Usuario normal | Testing |

> **⚠️ IMPORTANTE**: Cambia la contraseña después del primer login con comando `PASSWORD`

---

## 🛑 Apagado Seguro

### Método 1: Desde Hercules (Recomendado)
```
stop
```
Espera a que z/OS termine (2-5 minutos), luego:
```
quit
```

### Método 2: Desde z/OS MCS
```
$PJES2,ABEND
Z EOD
```

---

## 📊 Información del Sistema Host

- **Laptop**: Dell Latitude 5410
- **CPU**: Intel Core i5-10310U @ 1.70GHz (4C/8T)
- **RAM**: 24 GB
- **OS**: Fedora 43 Workstation
- **Kernel**: 6.18.9-200.fc43.x86_64
- **Hercules**: SDL 4.9.1.11612

---

## 📚 Más Información

Para documentación completa, ver: **README.md**

---

**Creado**: 2026-02-12  
**Ubicación**: `/home/d5410/IBM_HOST/IBM-ZOS_V3R1/`
