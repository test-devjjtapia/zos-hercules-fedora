# 📚 Índice de Documentación - z/OS 3.1 en Hercules

## 🗂️ Archivos de Documentación

### **📖 Documentos Principales**

1. **[README.md](README.md)** - **DOCUMENTACIÓN COMPLETA** ⭐
   - 681 líneas de documentación exhaustiva
   - Información del hardware (Dell Latitude 5410)
   - Configuración completa del sistema
   - Mapa de volúmenes DASD
   - Procedimientos de IPL
   - Troubleshooting detallado
   - Comandos útiles de Hercules y z/OS
   - **LEER PRIMERO**

2. **[QUICKSTART.md](QUICKSTART.md)** - **GUÍA RÁPIDA** 🚀
   - 176 líneas de referencia rápida
   - Inicio en 5 minutos
   - Comandos esenciales
   - Solución rápida de problemas
   - Usuarios y contraseñas
   - Procedimiento de apagado
   - **PARA CONSULTA RÁPIDA**

3. **[RESUMEN_CAMBIOS.md](RESUMEN_CAMBIOS.md)** - **RESUMEN DE ADAPTACIONES** 📝
   - 317 líneas de cambios documentados
   - Comparativa Windows vs Linux
   - Todos los cambios realizados
   - Verificación del sistema
   - Antes/Después detallado
   - **PARA ENTENDER QUÉ SE CAMBIÓ**

4. **[DIFERENCIAS_PUERTO_3270_vs_992.md](DIFERENCIAS_PUERTO_3270_vs_992.md)** - **EXPLICACIÓN DE PUERTOS** 🔌
   - 262 líneas de análisis detallado
   - Diferencias entre puerto 3270 y 992
   - Configuración SSL/TLS
   - Seguridad y cifrado
   - Recomendaciones para tu entorno
   - **PARA ENTENDER LA CONFIG**

5. **[INFORMACION_DESCARGA.md](INFORMACION_DESCARGA.md)** - **INFORMACIÓN OFICIAL** 📦
   - Fuente oficial: Archive.org
   - Credenciales correctas del sistema
   - Requisitos y compatibilidad
   - Usuario: `ibmuser` / Password: `welcome0welcome0`
   - **PARA VERIFICAR CREDENCIALES**

### **📄 Archivos de Configuración**

6. **[MF_31_LINUX.cnf](MF_31_LINUX.cnf)** - **CONFIGURACIÓN ADAPTADA** ✅
   - Configuración principal para Fedora 43
   - Rutas Linux corregidas
   - Shadow files habilitados
   - Puerto 3270 estándar
   - Red QETH configurada
   - **ARCHIVO A USAR**

7. **[MF_31.cnf](MF_31.cnf)** - **CONFIGURACIÓN ORIGINAL** ⚠️
   - Configuración original de Windows
   - Rutas Windows (C:\, D:\)
   - Puerto 992
   - **NO USAR - SOLO REFERENCIA**

8. **[IPL31.rc](IPL31.rc)** - **SCRIPT DE IPL**
   - Habilita CPU facilities críticas
   - Ejecutado automáticamente por Hercules
   - Necesario para arranque correcto

### **🔧 Scripts de Automatización**

9. **[mvs31.sh](mvs31.sh)** - **SCRIPT DE ARRANQUE** 🚀
   - Script bash ejecutable
   - Verifica prerequisitos
   - Crea directorios automáticamente
   - Abre terminal 3270
   - Inicia Hercules
   - **EJECUTAR ESTE PARA ARRANCAR**

---

## 🎯 Flujo de Uso Recomendado

### **Primera Vez - Setup Inicial**
```
1. Leer README.md completo (10-15 minutos)
2. Revisar QUICKSTART.md para referencia rápida
3. Ejecutar: ./mvs31.sh
4. Seguir procedimiento de IPL del README.md
```

### **Uso Diario**
```
1. Ejecutar: ./mvs31.sh
2. En otra terminal: c3270 127.0.0.1:3270
3. En consola Hercules: ipl DE27
4. Trabajar en z/OS
5. Para apagar: stop (en Hercules) → quit
```

### **Troubleshooting**
```
1. Revisar QUICKSTART.md sección "Solución Rápida"
2. Si no resuelve, consultar README.md sección "Troubleshooting"
3. Revisar logs/logzOS
```

---

## 📊 Estructura Completa del Proyecto

```
/home/d5410/IBM_HOST/IBM-ZOS_V3R1/
│
├── 📚 DOCUMENTACIÓN (27 KB)
│   ├── README.md                           # 19 KB - Doc completa
│   ├── QUICKSTART.md                       # 3.5 KB - Guía rápida
│   ├── DIFERENCIAS_PUERTO_3270_vs_992.md   # 6.9 KB - Puertos
│   └── INDICE_DOCUMENTACION.md             # Este archivo
│
├── ⚙️ CONFIGURACIÓN (9.5 KB)
│   ├── MF_31_LINUX.cnf                     # 4.8 KB - Config Linux ✅
│   ├── MF_31.cnf                           # 4.8 KB - Config Windows ⚠️
│   └── IPL31.rc                            # 134 bytes - Script IPL
│
├── 🔧 SCRIPTS (2.3 KB)
│   └── mvs31.sh                            # Script de arranque
│
├── 🔐 SEGURIDAD (4.7 KB)
│   ├── common_cacert                       # 1.4 KB - CA Certificate
│   └── id_rsa                              # 3.3 KB - Private Key
│
├── 💾 VOLÚMENES DASD (75 GB)
│   ├── Z31VS1.CCKD                         # 9.4 GB - Sistema principal ⭐
│   ├── D31VS1.CCKD                         # 8.7 GB - Datos
│   ├── DEVVS1.CCKD                         # 10 GB - Desarrollo
│   ├── PRDVS1.CCKD                         # 15 GB - Producción
│   ├── T31VS1.CCKD                         # 12 GB - Test
│   ├── ZFSVS1.CCKD                         # 9.2 GB - zFS/USS
│   ├── MQCD93.CCKD                         # 3.0 GB - MQ 9.3
│   ├── USRVS1.CCKD                         # 2.4 GB - Usuarios
│   ├── CICS61.CCKD                         # 2.2 GB - CICS 6.1
│   ├── OPEVS1.CCKD                         # 1.0 GB - Operaciones
│   ├── IMSV15.CCKD                         # 1.1 GB - IMS v15
│   ├── STGVS1.CCKD                         # 322 MB - Storage
│   ├── DB2V13.CCKD                         # 274 MB - DB2 v13
│   ├── JSPVS1.CCKD                         # 58 MB - JSP
│   └── JCKVS1.CCKD                         # 2.1 MB - JCL
│
├── 📂 DIRECTORIOS DE TRABAJO
│   ├── logs/                               # Logs de Hercules
│   │   └── logzOS                          # Log principal
│   └── shadow/                             # Shadow files CCKD
│       ├── Z31VS1_*
│       ├── D31VS1_*
│       └── ... (uno por cada volumen)
│
└── 🗑️ LEGACY
    └── C:\Users\Public\ZOS111\LOGS\logzOS # Log Windows antiguo
```

---

## 📖 Resumen de Documentación por Temas

### **🖥️ Hardware y Sistema Host**
- **Documento**: README.md (sección "Información del Sistema Host")
- **Contenido**: Dell Latitude 5410, Intel i5-10310U, 24GB RAM, Fedora 43

### **⚙️ Configuración z/OS 3.1**
- **Documento**: README.md (sección "Configuración del Sistema z/OS 3.1")
- **Contenido**: CPU Z15, 6 CPUs, 12GB RAM, facilities habilitadas

### **💾 Volúmenes y Almacenamiento**
- **Documento**: README.md (sección "Mapa de Volúmenes DASD")
- **Contenido**: 15 volúmenes, 75GB total, shadow files

### **🌐 Red y Conectividad**
- **Documento**: README.md (sección "Configuración de Red")
- **Contenido**: QETH, IP 192.168.100.150, MAC addresses

### **🚀 Arranque y IPL**
- **Documento**: QUICKSTART.md + README.md (sección "Procedimiento de Arranque")
- **Contenido**: Comandos, secuencia, troubleshooting

### **🔐 Seguridad**
- **Documento**: DIFERENCIAS_PUERTO_3270_vs_992.md
- **Contenido**: Cifrado, SSL/TLS, puertos, alternativas

### **🛠️ Troubleshooting**
- **Documento**: QUICKSTART.md + README.md (sección "Troubleshooting")
- **Contenido**: Errores comunes, soluciones, comandos de diagnóstico

### **🔑 Usuarios**
- **Documento**: README.md (sección "Usuarios y Contraseñas")
- **Contenido**: IBMUSER/SYS1, ADCDMST, usuarios ADCD

---

## 🎓 Recursos de Aprendizaje

### **Para Comenzar con z/OS**
1. Arrancar el sistema (QUICKSTART.md)
2. Login con IBMUSER/SYS1
3. Iniciar ISPF (comando: `ISPF`)
4. Explorar opciones del menú

### **Comandos TSO Básicos**
- Ver en README.md, sección "Comandos Útiles de Hercules"

### **Comandos z/OS MCS**
- Ver en QUICKSTART.md, sección "Comandos Esenciales"

---

## 🔧 Mantenimiento

### **Backups**
```bash
# Backup de configuración
tar -czf ~/backups/zos31-config-$(date +%Y%m%d).tar.gz \
    *.cnf *.rc *.sh *.md

# Backup de shadow files (cambios recientes)
tar -czf ~/backups/zos31-shadows-$(date +%Y%m%d).tar.gz shadow/

# Backup completo de volúmenes (¡75GB!)
# Solo si tienes espacio y tiempo
tar -czf /backup/zos31-full-$(date +%Y%m%d).tar.gz *.CCKD
```

### **Limpiar Shadow Files**
```bash
# ⚠️ ADVERTENCIA: Perderás todos los cambios no guardados en z/OS
rm -rf shadow/*
```

### **Actualizar Documentación**
Cuando hagas cambios, actualiza:
1. README.md (si afecta configuración general)
2. QUICKSTART.md (si afecta procedimientos básicos)
3. Este archivo (INDICE_DOCUMENTACION.md) si cambias estructura

---

## 📞 Información de Contacto y Soporte

### **Logs del Sistema**
- Hercules: `logs/logzOS`
- z/OS SYSLOG: Ver desde consola MCS con `D SYSLOG`
- JES2: `$DJQ` desde consola

### **Comunidades**
- Hercules Google Group: https://groups.google.com/g/hercules-390
- IBM z/OS Community: https://community.ibm.com/community/user/ibmz-and-linuxone

---

## 📊 Estadísticas del Proyecto

| Métrica | Valor |
|---------|-------|
| **Total de Archivos** | 27 archivos |
| **Documentación** | 5 archivos (49 KB) |
| **Volúmenes DASD** | 15 archivos (75 GB) |
| **Líneas de Documentación** | 1,751 líneas |
| **Directorios** | 3 (logs, shadow, archivos) |
| **Scripts** | 3 archivos (mvs31.sh, verificar_sistema.sh, IPL31.rc) |
| **Archivos de Config** | 2 activos (MF_31_LINUX.cnf, IPL31.rc) |

---

## ✅ Checklist de Verificación

### **Antes del Primer Arranque**
- [ ] Leer README.md completo
- [ ] Verificar que existen todos los archivos .CCKD
- [ ] Verificar permisos de ejecución en mvs31.sh (`chmod +x mvs31.sh`)
- [ ] Verificar que Hercules está instalado (`hercules --version`)
- [ ] Verificar que c3270 está instalado (`which c3270`)

### **Durante el Arranque**
- [ ] Directorios `logs/` y `shadow/` creados
- [ ] Hercules inicia sin errores
- [ ] Todos los volúmenes DASD se montan correctamente
- [ ] Puerto 3270 está escuchando (`netstat -tuln | grep 3270`)
- [ ] Terminal c3270 conecta correctamente

### **Después del IPL**
- [ ] Sistema responde a comandos MCS (`D A,ALL`)
- [ ] JES2 activo (`$DA`)
- [ ] TSO disponible (login con IBMUSER)
- [ ] ISPF funciona correctamente

---

## 🏆 Historial de Cambios

### **2026-02-12 - Versión Inicial**
- ✅ Adaptación de configuración Windows → Fedora 43
- ✅ Creación de MF_31_LINUX.cnf
- ✅ Creación de script mvs31.sh
- ✅ Documentación completa en español
- ✅ Cambio de puerto 992 → 3270
- ✅ Rutas Linux corregidas
- ✅ Shadow files habilitados
- ✅ Directorios logs/ y shadow/ creados

---

## 🎯 Próximos Pasos Sugeridos

1. **Aprender ISPF**: Explorar menús, editar datasets
2. **Crear tus propios datasets**: Para prácticas
3. **Compilar programas COBOL**: Si es tu interés
4. **Configurar red**: Para acceso desde otras máquinas
5. **Explorar UNIX System Services**: zFS montado en DE32
6. **Probar subsistemas**: CICS, DB2, IMS, MQ

---

**¡Toda la documentación está completa y lista para usar! 🎉**

---

**Creado**: 2026-02-12  
**Sistema**: Dell Latitude 5410 - Fedora 43 Workstation  
**Mantenedor**: Sistema automatizado  
**Última actualización**: 2026-02-12 14:35 ART
