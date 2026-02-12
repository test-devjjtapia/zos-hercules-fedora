# 📦 Información de Descarga - z/OS V3R1

## 🌐 Fuente Original

**Fuente**: Internet Archive  
**URL**: https://archive.org/details/zos31_version1  
**Subido por**: mobiusavenger  
**Fecha de publicación**: 2024-06-01  
**Fecha de subida**: 2024-06-03  
**Tamaño**: 74.7 GB  

---

## 📋 Descripción Oficial

> "This package contains the z/OS V3R1 development and test stock image distribution works with SDL Hercules Hyperion 4.8 develop branch"

**Tipo de imagen**: Development and Test Stock Image  
**Compatible con**: SDL Hercules Hyperion 4.8 (develop branch)  

---

## 🔑 Credenciales Oficiales del Sistema

### **Usuario Principal (según Archive.org)**
```
Usuario:      ibmuser
Contraseña:   welcome0welcome0
```

> **📝 NOTA IMPORTANTE**: La documentación original del README.md indicaba:
> - Usuario: IBMUSER
> - Password: SYS1
>
> **Las credenciales correctas según la fuente oficial son**:
> - Usuario: **ibmuser** (minúsculas)
> - Password: **welcome0welcome0**
>
> Si ya cambiaste la contraseña, anota tu nueva contraseña aquí:
> - Nueva contraseña: ___________________________

---

## ⚠️ Requisitos Importantes

### **Facilities de CPU Requeridas**

**ADVERTENCIA de la fuente oficial**:
```
* WARNING execute on command line before IPL/LOADPARM 
* on hercules ---> 'FAC ENA 054' 'FAC ENA 129' 'FAC ENA 130' 
*                  'FAC ENA 134' and 'FAC ENA 135'
```

Estas facilities YA están configuradas en el archivo `IPL31.rc` que se ejecuta automáticamente:

```bash
# Contenido de IPL31.rc
fac ena 129     # 129_ZVECTOR
fac ena 054     # 054_EE_CMPSC
fac ena 130     # 130_INSTR_EXEC_PROT
fac ena 134     # 134_ZVECTOR_PACK_DEC
fac ena 135     # 135_ZVECTOR_ENH_1
```

✅ **No necesitas hacer nada**, el script `mvs31.sh` ejecuta automáticamente `IPL31.rc`.

---

## 🔧 Versión de Hercules Recomendada

**Según Archive.org**: SDL Hercules Hyperion **4.8 develop branch**

**Tu versión actual**:
```bash
$ hercules --version
Hercules version 4.9.1.11612-SDL-gee86c4de-modified
```

✅ **Tu versión (4.9.1) es POSTERIOR a la 4.8**, por lo tanto es compatible y tiene mejoras adicionales.

---

## 📚 Temas/Tags del Sistema

Según Archive.org, este sistema incluye:
- **mainframe** - Entorno de mainframe completo
- **zos** - Sistema operativo z/OS
- **adcd** - Application Developer's Controlled Distribution
- **dvd** - Distribución en formato DVD
- **zpdt** - Compatible con IBM zPDT
- **z1090** - Arquitectura z1090
- **hercules** - Compatible con Hercules
- **IBM** - Producto IBM
- **software** - Software de desarrollo

---

## 🔐 Usuarios Disponibles en el Sistema

### **Usuarios Conocidos**

| Usuario | Password Original | Privilegios | Uso |
|---------|-------------------|-------------|-----|
| **ibmuser** | **welcome0welcome0** | Admin completo | Usuario principal ✅ |
| IBMUSER | SYS1 | Admin completo | Alias/alternativo |
| ADCDMST | ADCDMST | Admin completo | Master ADCD |
| ADCDA-ADCDZ | TEST1 | Usuario normal | Testing |
| OPEN1-OPEN3 | SYS2 | UID(0) root | Unix/OMVS |

> **📝 Nota**: Es posible que `ibmuser` y `IBMUSER` sean el mismo usuario (z/OS no distingue mayúsculas/minúsculas en userids).

---

## ✅ Verificación de Credenciales

### **Si ya lograste entrar al sistema**:

1. **¿Con qué usuario entraste?** ___________________________
2. **¿Qué password usaste?** ___________________________
3. **¿Cambiaste la contraseña?** Sí / No
4. **Nueva contraseña (si cambiaste):** ___________________________

### **Para verificar tu userid actual en TSO**:

```
=6         (Ir a Comando TSO)
LISTUSER   (Ver información de tu usuario)
```

O desde ISPF:
```
TSO LISTUSER
```

---

## 🔄 Cambiar Contraseña

### **Desde TSO**:
```
PASSWORD       (Comando para cambiar password)
```

Te pedirá:
1. Password actual
2. Nueva password (2 veces)

### **Desde ISPF**:
```
=6                      (Ir a TSO Command)
PASSWORD                (Cambiar password)
```

### **Reglas de Contraseña en z/OS**:
- Mínimo 8 caracteres
- Debe incluir al menos:
  - 1 letra (A-Z)
  - 1 número (0-9)
- No puede ser igual al userid
- No puede contener el userid
- No puede ser una de las últimas 10 contraseñas

---

## 📝 Actualización de Documentación

Esta información se agregó después de verificar la fuente oficial en Archive.org. Las credenciales correctas son:

**Usuario**: `ibmuser`  
**Password**: `welcome0welcome0`

Si encuentras que las credenciales de la documentación original (IBMUSER/SYS1) también funcionan, probablemente son alias o el sistema tiene múltiples usuarios administrativos configurados.

---

## 🔗 Enlaces Útiles

- **Archive.org**: https://archive.org/details/zos31_version1
- **Hercules SDL Hyperion**: https://github.com/SDL-Hercules-390/hyperion
- **z/OS Documentation**: https://www.ibm.com/docs/en/zos

---

## 📊 Comparación con Documentación Anterior

| Aspecto | Documentado Antes | Archive.org | Estado |
|---------|-------------------|-------------|--------|
| **Usuario** | IBMUSER | ibmuser | ⚠️ Verificar ambos |
| **Password** | SYS1 | welcome0welcome0 | ✅ Corregido |
| **Hercules** | SDL 4.x | SDL 4.8+ develop | ✅ Compatible |
| **Facilities** | Documentadas | Mismas 5 facilities | ✅ OK |
| **Tamaño** | ~75GB | 74.7GB | ✅ Coincide |

---

## 🎯 Recomendaciones

1. ✅ **Usar credenciales de Archive.org**: `ibmuser` / `welcome0welcome0`
2. ✅ **Cambiar password inmediatamente** después del primer login (ya lo hiciste ✓)
3. ✅ **Anotar nueva contraseña** en lugar seguro
4. ✅ **Facilities ya configuradas** en IPL31.rc (no hacer nada)
5. ✅ **Tu Hercules 4.9.1 es compatible** (posterior a 4.8)

---

## ✏️ Notas Personales

**Fecha de primer login exitoso**: 2026-02-12  
**Usuario usado**: ___________________________  
**Password cambiada**: Sí ✓  
**Nueva password anotada**: ___________________________  

---

**Creado**: 2026-02-12  
**Fuente**: https://archive.org/details/zos31_version1  
**Sistema**: Dell Latitude 5410 - Fedora 43 WS
