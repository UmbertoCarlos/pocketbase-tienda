FROM alpine:latest

ARG PB_VERSION=0.22.0

RUN apk add --no-cache \
    unzip \
    ca-certificates

# Descargar PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/
RUN chmod +x /pb/pocketbase

# Exponer puerto
EXPOSE 8090

# Ejecutar PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8090"]
```

4. Clic en **"Commit changes"**

### **4. Conectar Render con GitHub**

1. Volvé a Render: https://dashboard.render.com/
2. Clic en tu servicio web
3. Clic en **"Settings"**
4. En **"Build & Deploy"**, cambiá:
   - Build Command: (dejalo vacío)
   - Start Command: (dejalo vacío)
5. En **"Source"**, conectá tu repositorio de GitHub `pocketbase-tienda`
6. Clic en **"Manual Deploy"** → **"Deploy latest commit"**

Esperá 3-5 minutos mientras se construye.

---

## 📦 **Paso 2: Acceder al panel de PocketBase**

1. Abrí: `https://tu-proyecto.onrender.com/_/`
2. Primera vez te pide crear admin:
   - Email: `tu@email.com`
   - Password: `TuPassword123` (una que recuerdes)
3. Clic en **"Create"**

✅ **Ya tenés PocketBase funcionando!**

---

## 🗂️ **Paso 3: Crear colección "products"**

1. En PocketBase, clic en **"Collections"** (sidebar izquierdo)
2. Clic en **"+ New collection"**
3. Configurá:
```
Name: products
Type: Base
```

4. Clic en **"+ New field"** y agregá estos campos UNO POR UNO:

**Campo 1:**
```
Type: Text
Name: name
Required: ✅
Max length: 200
```

**Campo 2:**
```
Type: Text
Name: image
Required: ✅
Max length: 1000
```

**Campo 3:**
```
Type: Number
Name: price
Required: ✅
Min: 0
```

**Campo 4:**
```
Type: Number
Name: stock
Required: ✅
Min: 0
```

**Campo 5:**
```
Type: Text
Name: category
Max length: 100
```

**Campo 6:**
```
Type: Editor
Name: info
```

**Campo 7:**
```
Type: JSON
Name: colors
```

5. Clic en **"Create"**

---

## 🔓 **Paso 4: Configurar permisos públicos**

1. En la colección "products", clic en el ícono de **candado** (API Rules)
2. Configurá cada regla:
```
List/Search rule: (dejar VACÍO)
View rule: (dejar VACÍO)
Create rule: @request.auth.id != ""
Update rule: @request.auth.id != ""
Delete rule: @request.auth.id != ""
