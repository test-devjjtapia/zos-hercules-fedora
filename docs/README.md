# 📘 Documentación Completa - IBM z/OS 3.1 en Hercules SDL Hyperion

## 🖥️ Información del Sistema Host

### **Hardware**
- **Modelo**: Dell Latitude 5410
- **Procesador**: Intel Core i5-10310U @ 1.70GHz
  - **Núcleos**: 4 físicos / 8 threads (hyperthreading)
  - **Arquitectura**: x86-64
- **Memoria RAM**: 24 GB DDR4
- **Almacenamiento**: SSD (información de los volúmenes z/OS)

### **Sistema Operativo Host**
- **Distribución**: Fedora Linux 43 (Workstation Edition)
- **Kernel**: Linux 6.18.9-200.fc43.x86_64
- **Arquitectura**: x86-64
- **Hostname**: Noa5410

### **Software de Emulación**
- **Emulador**: Hercules SDL 4.x Hyperion
- **Versión**: 4.9.1.11612-SDL-gee86c4de-modified
- **Fecha de compilación**: Feb 6 2026
- **Ubicación**: `/usr/local/bin/hercules`
- **Terminal 3270**: c3270 (ubicado en `/usr/bin/c3270`)

---

## 📁 Estructura del Entorno z/OS 3.1

### **Ubicación del Proyecto**
```
/home/d5410/IBM_HOST/IBM-ZOS_V3R1/
```

### **Estructura de Directorios**
```
IBM-ZOS_V3R1/
├── MF_31_LINUX.cnf          # Configuración adaptada para Linux/Fedora
├── MF_31.cnf                # Configuración original (Windows) - NO USAR
├── IPL31.rc                 # Script de comandos para IPL
├── mvs31.sh                 # Script de arranque para Fedora
├── logs/                    # Directorio para logs de Hercules
│   └── logzOS               # Log principal del emulador
├── shadow/                  # Shadow files (cambios temporales en discos)
│   ├── CICS61_*
│   ├── D31VS1_*
│   └── ... (uno por cada volumen CCKD)
└── *.CCKD                   # Volúmenes de disco (75GB totales)
    ├── CICS61.CCKD          # CICS Transaction Server 6.1
    ├── DB2V13.CCKD          # IBM DB2 v13
    ├── IMSV15.CCKD          # IMS v15
    ├── MQCD93.CCKD          # MQ 9.3
    ├── Z31VS1.CCKD          # Sistema principal z/OS 3.1
    ├── D31VS1.CCKD          # Volumen de datos
    ├── DEVVS1.CCKD          # Volumen de desarrollo
    ├── OPEVS1.CCKD          # Volumen operativo
    ├── PRDVS1.CCKD          # Volumen de producción
    ├── T31VS1.CCKD          # Volumen de test
    ├── USRVS1.CCKD          # Volumen de usuarios
    └── ZFSVS1.CCKD          # Sistema de archivos zFS
```

---

## 🔧 Configuración del Sistema z/OS 3.1

### **Parámetros del Sistema Emulado**

#### **Identificación del Hardware Virtual**
```
MANUFACTURER   IBM
PLANT          02
CPUSERIAL      02B7F8
CPUMODEL       8562           # IBM z15 (s390x)
MODEL          T02 S03        # Model T02, Capacity S03
LPARNAME       VS01           # Nombre de la partición lógica
```

#### **Arquitectura y Recursos**
```
ARCHLVL        z/ARCH         # Arquitectura z/Architecture (64-bit)
NUMCPU         6              # 6 procesadores virtuales
MAXCPU         8              # Máximo de 8 CPUs
MAINSIZE       12G            # 12 GB de memoria principal
ENGINES        CP             # Procesadores de propósito general
```

#### **Optimizaciones y Comportamiento**
```
OSTAILOR       z/OS           # Optimizaciones para z/OS
PGMPRDOS       LICENSED       # Sistema con licencia
SYSEPOCH       1900           # Época del reloj TOD
TZOFFSET       -0300          # GMT-3 (Argentina/Brasil)
TIMERINT       400            # Intervalo del timer (microsegundos)
CONKPALV       (3,1,10)       # Keep-alive de consola
```

### **Características del CPU Habilitadas (Facilities)**

#### **Habilitadas por Defecto en Configuración**
```
FACILITY ENABLE 006_ASN_LX_REUSE          # Reutilización de ASN/LX
FACILITY ENABLE 044_PFPO                  # Perform Floating-Point Operation
FACILITY ENABLE 080_DFP_PACK_CONV         # Conversión Decimal Floating Point
FACILITY ENABLE 037_FP_EXTENSION          # Extensión de punto flotante
FACILITY ENABLE 050_CONSTR_TRANSACT       # Transacciones constreñidas
FACILITY ENABLE 051_LOCAL_TLB_CLEARING    # Limpieza local de TLB
FACILITY ENABLE 073_TRANSACT_EXEC         # Ejecución transaccional
FACILITY ENABLE 074_STORE_HYPER_INFO      # Información de hipervisor
FACILITY ENABLE 145_INS_REF_BITS_MULT     # Bits de referencia múltiple
```

#### **Habilitadas Manualmente en IPL31.rc** (Requeridas antes del IPL)
```
FACILITY 054_EE_CMPSC                     # Compresión EE (Enhanced CMPSC)
FACILITY 129_ZVECTOR                      # Vector z (SIMD)
FACILITY 130_INSTR_EXEC_PROT              # Protección de ejecución
FACILITY 134_ZVECTOR_PACK_DEC             # Vector z Packed Decimal
FACILITY 135_ZVECTOR_ENH_1                # Vector z Enhancement 1
```

> **⚠️ IMPORTANTE**: Las facilities 054, 129, 130, 134 y 135 DEBEN habilitarse manualmente desde la consola de Hercules antes de hacer IPL. El script `IPL31.rc` las habilita automáticamente.

---

## 💾 Mapa de Volúmenes DASD (Discos)

### **Esquema de Direccionamiento**

| Dirección | Tipo | Archivo CCKD | Tamaño | Contenido | Shadow Files |
|-----------|------|--------------|--------|-----------|--------------|
| **DE25** | 3390 | CICS61.CCKD | 2.2 GB | CICS TS 6.1 | shadow/CICS61_* |
| **DE26** | 3390 | D31VS1.CCKD | 8.8 GB | Datos z/OS 3.1 | shadow/D31VS1_* |
| **DE27** | 3390 | Z31VS1.CCKD | 9.5 GB | **Sistema Residencia** | shadow/Z31VS1_* |
| **DE28** | 3390 | OPEVS1.CCKD | 1.1 GB | Operaciones | shadow/OPEVS1_* |
| **DE29** | 3390 | STGVS1.CCKD | 323 MB | Storage Management | shadow/STGVS1_* |
| **DE2A** | 3390 | DEVVS1.CCKD | 10 GB | Desarrollo | shadow/DEVVS1_* |
| **DE2B** | 3390 | IMSV15.CCKD | 1.1 GB | IMS v15 | shadow/IMSV15_* |
| **DE2C** | 3390 | JCKVS1.CCKD | 2.1 MB | JCL/Jobs | shadow/JCKVS1_* |
| **DE2D** | 3390 | JSPVS1.CCKD | 59 MB | JSP/Servlets | shadow/JSPVS1_* |
| **DE2E** | 3390 | MQCD93.CCKD | 3.1 GB | MQ 9.3 | shadow/MQCD93_* |
| **DE2F** | 3390 | PRDVS1.CCKD | 15 GB | Producción | shadow/PRDVS1_* |
| **DE30** | 3390 | DB2V13.CCKD | 274 MB | DB2 v13 | shadow/DB2V13_* |
| **DE31** | 3390 | T31VS1.CCKD | 13 GB | Test/QA | shadow/T31VS1_* |
| **DE32** | 3390 | ZFSVS1.CCKD | 9.2 GB | zFS (Unix System Services) | shadow/ZFSVS1_* |
| **DE33** | 3390 | USRVS1.CCKD | 2.4 GB | Usuarios | shadow/USRVS1_* |

**Total**: 15 volúmenes / ~75 GB de almacenamiento

### **¿Qué son los Shadow Files?**

Los **shadow files** son archivos temporales que Hercules crea para almacenar **solo los cambios** realizados en los volúmenes CCKD, dejando los archivos originales intactos. 

**Ventajas:**
- ✅ Los archivos `.CCKD` originales nunca se modifican
- ✅ Puedes revertir cambios simplemente borrando los shadow files
- ✅ Ideal para testing y desarrollo
- ✅ Múltiples instancias pueden compartir los mismos archivos base

**Formato**: `sf=shadow/NOMBRE_*` crea archivos como `shadow/NOMBRE_001`, `shadow/NOMBRE_002`, etc.

---

## 🌐 Configuración de Red

### **Adaptador QETH (OSA Express)**
```
1500.3 QETH iface 18-C0-4D-F3-E8-7C ipaddr 192.168.100.150/24 \
       netmask 255.255.255.0 hwaddr 02-00-00-11-10-00 mtu 1500 chpid F0
```

#### **Parámetros:**
- **Dispositivo**: 1500.3 (base 1500, 3 sub-canales)
- **Tipo**: QETH (Queued Direct I/O)
- **MAC Address física**: `18-C0-4D-F3-E8-7C` (adaptador host Fedora)
- **IP z/OS**: `192.168.100.150/24`
- **Máscara de red**: `255.255.255.0`
- **MAC virtual z/OS**: `02-00-00-11-10-00`
- **MTU**: 1500 bytes
- **CHPID**: F0 (Channel Path ID)

> **📝 Nota**: Para que funcione la red, debes configurar un bridge o tap device en Fedora que permita la comunicación entre z/OS y la red host.

---

## 🖥️ Terminales 3270

### **Configuración de Consolas**

#### **Puerto de Escucha**
```
CNSLPORT  3270
```
- Hercules escucha en `127.0.0.1:3270` para conexiones TN3270

#### **Terminales Definidos**
```
0060    3270    # Consola Master (MCS)
0061    3270    # Terminal TSO/ISPF
```

### **Cómo Conectar**

#### **Usando c3270 (Terminal en CLI)**
```bash
c3270 127.0.0.1:3270
```

#### **Usando x3270 (GUI)**
```bash
x3270 127.0.0.1:3270
```

#### **Desde Windows (con TN3270 Plus, PCOMM, etc.)**
```
Host: IP_DE_TU_FEDORA:3270
Tipo: TN3270E
```

---

## 🚀 Procedimiento de Arranque

### **Método 1: Script Automático (Recomendado)**

```bash
cd /home/d5410/IBM_HOST/IBM-ZOS_V3R1
./mvs31.sh
```

El script:
1. ✅ Verifica archivos de configuración
2. ✅ Crea directorios `shadow/` y `logs/` si no existen
3. ✅ Abre automáticamente un terminal c3270 (si tienes terminator/gnome-terminal)
4. ✅ Inicia Hercules con `MF_31_LINUX.cnf`

### **Método 2: Manual**

```bash
cd /home/d5410/IBM_HOST/IBM-ZOS_V3R1

# Crear directorios necesarios (solo primera vez)
mkdir -p shadow logs

# Iniciar Hercules
hercules -f MF_31_LINUX.cnf
```

En otra terminal:
```bash
c3270 127.0.0.1:3270
```

---

## 📝 Secuencia de IPL (Initial Program Load)

### **Paso 1: Iniciar Hercules**
```bash
./mvs31.sh
```

Verás en consola:
```
HHC01413I Hercules version 4.9.1.11612-SDL-gee86c4de-modified
HHC01414I (C) Copyright 1999-2025 by Roger Bowler, Jan Jaeger, and others
HHC00150I Crypto module loaded
...
HHC00150I Facility(006_ASN_LX_REUSE) Enabled
...
```

### **Paso 2: Conectar al Terminal 3270**
```bash
c3270 127.0.0.1:3270
```

### **Paso 3: Hacer IPL desde Hercules Console**

En la consola de Hercules (donde ejecutaste `./mvs31.sh`), teclea:

```
ipl DE27
```

- **DE27** es el volumen Z31VS1.CCKD (sistema de residencia)
- El parámetro `LOADPARM DE28K2M.` le indica a z/OS qué miembro usar del PARMLIB

### **Paso 4: Monitorear el IPL**

En el terminal 3270 verás:
```
IEA101A SPECIFY SYSTEM PARAMETERS
```

Presiona **ENTER** (usa la configuración por defecto).

Luego:
```
IEE094A SPECIFY OPERAND(S) FOR BPXPRM
```

Presiona **ENTER** nuevamente.

### **Paso 5: Consola Operativa**

Cuando veas:
```
$HASP099 ALL AVAILABLE FUNCTIONS COMPLETE
IEE037I SYSTEM ACTIVE
```

**¡El sistema está listo!**

---

## 🔑 Usuarios y Contraseñas del Sistema

### **Usuarios Administrativos**
| Usuario | Contraseña Original | Privilegios | Uso |
|---------|------------|-------------|-----|
| **ibmuser** | **welcome0welcome0** | Administrador completo | **Usuario principal** ✅ |
| IBMUSER | SYS1 | Administrador completo | Alternativo/Alias |
| ADCDMST | ADCDMST | Administrador completo | Master ADCD |

### **Usuarios de Desarrollo/Test**
| Usuario | Contraseña | Privilegios | OMVS |
|---------|------------|-------------|------|
| ADCDA-ADCDZ | TEST1 | Limitados | ❌ No |
| OPEN1-OPEN3 | SYS2 | UID(0) root | ✅ Sí |

> **📝 Notas Importantes**: 
> - **Credenciales oficiales** (según Archive.org): `ibmuser` / `welcome0welcome0`
> - Se recomienda **cambiar la contraseña** después del primer login
> - z/OS no distingue mayúsculas/minúsculas en userids
> - Ver `INFORMACION_DESCARGA.md` para más detalles sobre credenciales

---

## 🛠️ Comandos Útiles de Hercules

### **En la Consola de Hercules**

#### **IPL y Control de Sistema**
```
ipl DE27              # Hacer IPL desde volumen DE27
stop                  # Detener z/OS (SHUTDOWN)
quit                  # Salir de Hercules
```

#### **Gestión de CPU**
```
cpu                   # Mostrar CPUs disponibles
start 0               # Iniciar CPU 0
stop 2                # Detener CPU 2
```

#### **Facilities**
```
fac query enabled     # Ver facilities habilitadas
fac query all         # Ver todas las facilities
fac ena 129           # Habilitar facility 129
fac dis 129           # Deshabilitar facility 129
```

#### **Dispositivos**
```
devlist               # Listar todos los dispositivos
attach 1234 3390 nuevo.cckd  # Montar nuevo disco
detach 1234           # Desmontar dispositivo
```

#### **Logging y Debugging**
```
log                   # Cambiar opciones de log
msglevel +devdbg      # Habilitar debug de dispositivos
msglevel -devdbg      # Deshabilitar debug
```

---

## 🔍 Troubleshooting

### **Problema: Hercules no inicia**

#### **Error: "Cannot open configuration file"**
```bash
# Verifica que estás en el directorio correcto
cd /home/d5410/IBM_HOST/IBM-ZOS_V3R1
ls -la MF_31_LINUX.cnf
```

#### **Error: "Cannot open device file XXXXX.CCKD"**
```bash
# Verifica que los archivos CCKD existen
ls -lh *.CCKD

# Verifica permisos
chmod 644 *.CCKD
```

---

### **Problema: No puedo conectarme al puerto 3270**

```bash
# Verifica que Hercules está escuchando
netstat -tuln | grep 3270

# Debe mostrar:
# tcp  0  0 127.0.0.1:3270  0.0.0.0:*  LISTEN

# Si el puerto está ocupado:
lsof -i :3270
# Mata el proceso conflictivo
kill -9 <PID>
```

---

### **Problema: IPL falla o se cuelga**

#### **Verificar Facilities**
En consola Hercules:
```
fac query enabled
```

Debe mostrar al menos:
```
054_EE_CMPSC
129_ZVECTOR
130_INSTR_EXEC_PROT
134_ZVECTOR_PACK_DEC
135_ZVECTOR_ENH_1
```

Si faltan, habilitar manualmente:
```
fac ena 054
fac ena 129
fac ena 130
fac ena 134
fac ena 135
```

---

### **Problema: z/OS arranca pero muy lento**

#### **Optimizaciones recomendadas:**

1. **Aumentar prioridad de Hercules** (ejecutar como root):
```bash
sudo renice -20 $(pidof hercules)
```

2. **Deshabilitar shadow files** (solo para testing):
Editar `MF_31_LINUX.cnf`, quitar todas las líneas `sf=shadow/*`

3. **Reducir CPUs virtuales** si tu CPU real no tiene suficientes cores:
```
NUMCPU    4    # En lugar de 6
```

4. **Reducir memoria** si tienes poca RAM disponible:
```
MAINSIZE  8G    # En lugar de 12G
```

---

### **Problema: Shadow files crecen mucho**

```bash
# Ver tamaño de shadow files
du -sh shadow/

# Limpiar (¡PERDERÁS CAMBIOS NO GUARDADOS EN z/OS!)
rm -rf shadow/*

# Consolidar cambios en archivos base (avanzado)
# NO recomendado a menos que sepas lo que haces
```

---

## 🔄 Diferencias entre Puerto 3270 vs 992

### **Puerto 3270 (Estándar)**
- ✅ **Puerto estándar** para TN3270 y TN3270E
- ✅ Compatible con **todos los clientes 3270** sin configuración especial
- ✅ Documentación amplia y ejemplos
- ✅ **Recomendado para uso general**

### **Puerto 992 (Original en Windows)**
- ⚠️ **No estándar** para TN3270
- ⚠️ Usado típicamente para **TN3270 sobre TLS/SSL** (puerto 992 es Telnet SSL)
- ⚠️ Requiere configuración especial en clientes
- ❌ No recomendado a menos que uses cifrado SSL

**Conclusión**: Mantener **puerto 3270** es la mejor opción para Fedora.

---

## 📊 Monitoreo de Recursos

### **Recursos del Host (Fedora)**

#### **Uso de CPU**
```bash
top -p $(pidof hercules)
htop -p $(pidof hercules)
```

#### **Uso de Memoria**
```bash
ps aux | grep hercules
free -h
```

#### **Disco I/O**
```bash
iotop -p $(pidof hercules)
```

### **Recursos del Guest (z/OS)**

Desde TSO/ISPF o consola MCS:
```
D A,ALL              # Display todos los address spaces
D M=CPU              # Display uso de CPU
D M=STOR             # Display uso de memoria
D U,DASD,ONLINE      # Display DASDs online
RMF                  # Resource Measurement Facility (si instalado)
```

---

## 📚 Archivos de Configuración Clave

### **MF_31_LINUX.cnf**
Configuración principal adaptada para Fedora 43. Contiene:
- Parámetros de CPU y memoria
- Definición de dispositivos DASD
- Configuración de red QETH
- Terminales 3270
- Referencia al script IPL31.rc

### **IPL31.rc**
Script de comandos ejecutado al iniciar Hercules. Habilita facilities críticas:
```
fac ena 129     # Z-Vector
fac ena 054     # Compresión
fac ena 130     # Protección de ejecución
fac ena 134     # Z-Vector Packed Decimal
fac ena 135     # Z-Vector Enhancement 1
```

### **mvs31.sh**
Script bash que:
- Verifica prerequisitos
- Crea directorios necesarios
- Abre terminal 3270 automáticamente
- Ejecuta Hercules

---

## 🆚 Comparativa z/OS 1.10 vs z/OS 3.1

| Característica | z/OS 1.10 (Original) | z/OS 3.1 (Este Entorno) |
|----------------|----------------------|-------------------------|
| **Versión z/OS** | 1.9 ADCD | 3.1 VSI |
| **CPU Model** | IBM 3090 (ESA/390) | IBM z15 (z/Arch) |
| **Arquitectura** | ESA/390 (32-bit) | z/Architecture (64-bit) |
| **RAM** | 4 GB | 12 GB |
| **CPUs** | 2 | 6 |
| **Volúmenes** | 26 DASD | 15 DASD |
| **Almacenamiento** | ~17 GB | ~75 GB |
| **Productos** | DB2 v8/9, CICS, IMS, WAS | DB2 v13, CICS 6.1, IMS 15, MQ 9.3 |
| **Red** | No configurada | QETH 192.168.100.150 |
| **Shadow Files** | ✅ Sí | ✅ Sí |
| **Puerto 3270** | 3270 | 3270 (adaptado) |

---

## 🔐 Seguridad y Backups

### **Backup de Configuración**
```bash
# Backup de archivos de configuración
tar -czf /tmp/zos31-config-$(date +%Y%m%d).tar.gz \
    MF_31_LINUX.cnf IPL31.rc mvs31.sh
```

### **Backup de Volúmenes CCKD**
```bash
# Backup completo (¡75 GB!)
tar -czf /backup/zos31-volumes-$(date +%Y%m%d).tar.gz *.CCKD

# Backup incremental (solo shadow files)
tar -czf /backup/zos31-shadows-$(date +%Y%m%d).tar.gz shadow/
```

### **Restaurar Estado Limpio**
```bash
# Borrar shadow files para volver al estado original
rm -rf shadow/*
```

---

## 📖 Referencias y Recursos

### **Documentación Oficial**
- [Hercules SDL Hyperion](https://github.com/SDL-Hercules-390/hyperion)
- [z/OS Documentation Library](https://www.ibm.com/docs/en/zos)
- [z/OS Basic Skills](https://www.ibm.com/support/z-content-solutions/journey-to-z/)

### **Comunidades**
- [Hercules-390 Google Group](https://groups.google.com/g/hercules-390)
- [IBM Community - z/OS](https://community.ibm.com/community/user/ibmz-and-linuxone/communities/community-home?CommunityKey=e9f57665-48ea-4a34-8846-6d90b59f63a2)

### **Tutoriales**
- [TK4- MVS 3.8 Tutorial](http://wotho.ethz.ch/tk4-/) (básico, pero aplica conceptos)
- [z/OS ADCD Order](https://www-304.ibm.com/servers/resourcelink/svc0203a.nsf/pages/zosADCDorder)

---

## 📝 Notas Finales

### **Rendimiento Esperado**
Con Intel i5-10310U (4C/8T @ 1.7GHz) y 24GB RAM:
- IPL completo: **5-10 minutos**
- Respuesta interactiva TSO: **Aceptable** (ligero lag en picos de I/O)
- Compilaciones COBOL: **Moderadamente lentas** (usar JES2 con prioridad)

### **Recomendaciones de Uso**
- ✅ Ideal para desarrollo y aprendizaje
- ✅ Pruebas de aplicaciones mainframe
- ⚠️ NO para entornos de producción
- ⚠️ NO para cargas de trabajo intensivas (compilaciones masivas, batch pesado)

### **Limitaciones Conocidas**
- Emulación de I/O más lenta que hardware real
- Sin soporte de cifrado por hardware (CPACF)
- Network performance limitado vs OSA real

---

## 🎯 Próximos Pasos

1. ✅ Arrancar z/OS 3.1 con `./mvs31.sh`
2. ✅ Conectar con c3270 y hacer login con IBMUSER/SYS1
3. ✅ Explorar ISPF (opción TSO al login)
4. ✅ Verificar subsistemas: `D A,ALL` desde consola
5. ✅ Configurar red QETH si necesitas conectividad
6. ✅ Crear tus propios usuarios y datasets

---

## 👨‍💻 Información de Mantenimiento

**Entorno Creado**: 2026-02-12  
**Sistema Host**: Dell Latitude 5410 - Fedora 43 WS  
**Adaptado por**: Script automatizado  
**Última Actualización**: 2026-02-12  

---

## 🆘 Soporte

Para problemas específicos de Hercules:
```bash
hercules --help
man hercules
```

Para problemas de z/OS, consulta los logs:
```bash
tail -f logs/logzOS
```

---

**¡Disfruta tu entorno z/OS 3.1 en Hercules! 🎉**
