# 🔌 Puerto 3270 vs Puerto 992 - Explicación Detallada

## 📖 Resumen Ejecutivo

**Puerto 3270** → Puerto estándar para terminal TN3270 sin cifrado  
**Puerto 992** → Puerto estándar para terminal TN3270 **con cifrado SSL/TLS**

---

## 🔍 Puerto 3270 (Sin Cifrado)

### **Descripción**
- Puerto TCP estándar **no registrado** por IANA, pero **universalmente usado** para TN3270
- Protocolo: **Telnet 3270** (TN3270 / TN3270E)
- Comunicación: **Sin cifrado** (texto plano)
- Uso: **Entornos de desarrollo, laboratorio, redes privadas**

### **Ventajas**
- ✅ Configuración simple y directa
- ✅ Compatible con **todos** los emuladores 3270
- ✅ No requiere certificados SSL/TLS
- ✅ Menor overhead (más rápido en redes locales)
- ✅ Fácil de debuggear con tcpdump/wireshark

### **Desventajas**
- ❌ Tráfico **sin cifrar** (vulnerable a sniffing)
- ❌ Credenciales viajan en texto plano
- ❌ No apto para redes públicas/internet

### **Configuración en Hercules**
```ini
CNSLPORT  3270
```

### **Conexión desde Cliente**
```bash
c3270 127.0.0.1:3270
x3270 192.168.1.100:3270
```

---

## 🔒 Puerto 992 (Con Cifrado SSL/TLS)

### **Descripción**
- Puerto TCP **registrado por IANA** para **Telnet sobre TLS/SSL**
- Protocolo: **TLS/SSL** + **TN3270E**
- Comunicación: **Cifrada** con certificados SSL/TLS
- Uso: **Producción, acceso remoto seguro, internet**

### **Ventajas**
- ✅ Tráfico **completamente cifrado**
- ✅ Protección contra sniffing y MITM
- ✅ Credenciales protegidas
- ✅ Apto para internet y redes públicas
- ✅ Cumplimiento de normativas de seguridad

### **Desventajas**
- ❌ Requiere **configurar certificados SSL** en Hercules
- ❌ Cliente debe soportar **TLS** (no todos lo hacen)
- ❌ Configuración más compleja
- ❌ Overhead de cifrado (ligeramente más lento)

### **Configuración en Hercules**
```ini
CNSLPORT  992
# Requiere configuración adicional de SSL:
# - Certificado SSL
# - Clave privada
# - Configuración de libssl en Hercules
```

### **Conexión desde Cliente**
```bash
# c3270 con soporte SSL:
c3270 -ssl 127.0.0.1:992

# x3270 con SSL:
x3270 -ssl 192.168.1.100:992
```

---

## 🆚 Comparación Directa

| Característica | Puerto 3270 | Puerto 992 |
|----------------|-------------|------------|
| **Protocolo** | TN3270 / TN3270E | TLS + TN3270E |
| **Cifrado** | ❌ No | ✅ Sí (SSL/TLS) |
| **Configuración** | ⭐⭐⭐⭐⭐ Muy simple | ⭐⭐ Compleja |
| **Compatibilidad** | 🟢 Universal | 🟡 Solo clientes con SSL |
| **Rendimiento** | 🟢 Rápido | 🟡 Ligeramente más lento |
| **Seguridad** | 🔴 Baja (texto plano) | 🟢 Alta (cifrado) |
| **Uso Recomendado** | Desarrollo/LAN | Producción/Internet |
| **Certificados** | ❌ No necesita | ✅ Requiere |
| **Debugging** | ✅ Fácil | ⚠️ Difícil (tráfico cifrado) |

---

## 🎯 ¿Por Qué la Config Original Usaba Puerto 992?

### **Contexto Windows Original**

El archivo `MF_31.cnf` original (Windows) tenía:
```ini
CNSLPORT 992
```

**Posibles razones:**

1. **Configuración empresarial**: Entorno corporativo con políticas de seguridad que exigen cifrado
2. **Acceso remoto**: Sistema accesible desde internet o WAN
3. **Copia de producción**: Configuración clonada de sistema productivo con SSL
4. **Error de configuración**: Posible confusión con puerto estándar

---

## 🔧 Configuración SSL en Hercules (Puerto 992)

### **Paso 1: Generar Certificado SSL**
```bash
# Crear directorio para certificados
mkdir -p /home/d5410/IBM_HOST/IBM-ZOS_V3R1/certs
cd /home/d5410/IBM_HOST/IBM-ZOS_V3R1/certs

# Generar clave privada
openssl genrsa -out hercules.key 2048

# Generar certificado auto-firmado (válido 365 días)
openssl req -new -x509 -key hercules.key -out hercules.crt -days 365 \
  -subj "/C=AR/ST=BuenosAires/L=CABA/O=HomeLab/CN=hercules.local"

# Combinar en archivo PEM
cat hercules.key hercules.crt > hercules.pem
chmod 600 hercules.pem
```

### **Paso 2: Configurar Hercules**
Editar `MF_31_LINUX.cnf`:
```ini
CNSLPORT  992

# Habilitar SSL
HTTP PORT 8081 AUTH nobody noauth
HTTP ROOT /usr/share/hercules/http

# Configurar SSL para consola
SYSG ../../certs/hercules.pem
```

### **Paso 3: Verificar Hercules con SSL**
```bash
hercules -v | grep -i ssl
# Debe mostrar: SSL support: yes
```

### **Paso 4: Conectar con Cliente SSL**
```bash
c3270 -ssl 127.0.0.1:992
```

---

## 💡 Recomendación para Fedora 43

### **Para tu entorno actual:**

**Usa Puerto 3270** porque:
- ✅ Es un entorno de **desarrollo/aprendizaje local**
- ✅ Acceso solo desde **localhost (127.0.0.1)**
- ✅ No hay exposición a internet
- ✅ Configuración más simple
- ✅ No requiere gestión de certificados

**Cambiar a Puerto 992 si:**
- 🌐 Necesitas acceso desde **otras máquinas** en tu red
- 🔐 Planeas exponer a **internet** (con port forwarding)
- 📋 Estás simulando entorno **productivo** con requisitos de seguridad
- 🏢 Prácticas de **compliance** o auditoría

---

## 🔐 Alternativas de Seguridad sin SSL

Si necesitas seguridad sin la complejidad de SSL:

### **1. SSH Tunnel**
```bash
# En máquina remota:
ssh -L 3270:localhost:3270 user@servidor-hercules

# Luego conectar localmente:
c3270 127.0.0.1:3270
```

### **2. VPN**
- Configurar WireGuard o OpenVPN
- Acceder a Hercules a través de VPN (tráfico cifrado)

### **3. Firewall restrictivo**
```bash
# Solo permitir conexiones desde IPs específicas
sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.1.0/24" port port="3270" protocol="tcp" accept'
sudo firewall-cmd --reload
```

---

## 📊 Puertos TN3270 Comunes

| Puerto | Uso | Protocolo | Estándar |
|--------|-----|-----------|----------|
| **23** | Telnet estándar | Telnet | ✅ IANA |
| **992** | Telnet SSL/TLS | TLS + Telnet | ✅ IANA |
| **3270** | TN3270 sin cifrar | TN3270 | ⚠️ De facto |
| **3271** | TN3270 secundario | TN3270 | ⚠️ De facto |
| **8023** | TN3270 alternativo | TN3270 | ❌ No estándar |

---

## 🧪 Prueba de Puerto Activo

### **Verificar qué puerto escucha Hercules**
```bash
# Ver puertos escuchando
netstat -tuln | grep hercules
ss -tuln | grep :3270
ss -tuln | grep :992

# Ver con lsof
lsof -i :3270
lsof -i :992
```

### **Test de conexión**
```bash
# Test sin emulador
telnet 127.0.0.1 3270
nc -zv 127.0.0.1 3270

# Test con SSL
openssl s_client -connect 127.0.0.1:992
```

---

## 📚 Referencias

- **IANA Port Registry**: https://www.iana.org/assignments/service-names-port-numbers/
- **RFC 854 - Telnet Protocol**: https://tools.ietf.org/html/rfc854
- **RFC 1576 - TN3270**: https://tools.ietf.org/html/rfc1576
- **RFC 2355 - TN3270E**: https://tools.ietf.org/html/rfc2355
- **Hercules SSL Guide**: https://github.com/SDL-Hercules-390/hyperion/blob/master/README.NETWORKING

---

**Conclusión para tu setup**: Puerto **3270** es perfecto para desarrollo local en Fedora 43. 🎯

---

**Creado**: 2026-02-12  
**Sistema**: Dell Latitude 5410 - Fedora 43 WS
