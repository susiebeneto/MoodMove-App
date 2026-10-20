# Publicar MoodMove en línea

Plan: **GitHub** (el código) + **Aiven** (base de datos MySQL gratis) + **Render** (el servidor Node gratis).
Los nombres de botones pueden cambiar un poco, pero los pasos son esos.

## 1. Sube el proyecto a GitHub (repositorio nuevo)
1. En github.com: New repository, nombre `moodmove-app`, **sin** README. Públicalo o déjalo privado.
2. Copia tus fotos a `public/images/` (con los mismos nombres que usa about.html).
3. En la Terminal, dentro de la carpeta del proyecto:
   ```
   cd ~/Desktop/moodmove
   git init
   git add .
   git status
   ```
   Revisa que **no** aparezcan `node_modules` ni `db-config.js` (la contraseña no debe subirse). Luego:
   ```
   git commit -m "MoodMove app"
   git branch -M main
   git remote add origin https://github.com/TU_USUARIO/moodmove-app.git
   git push -u origin main
   ```

## 2. Crea la base de datos en Aiven
1. Entra a aiven.io y crea una cuenta (no pide tarjeta).
2. Create service, elige **MySQL**, plan **Free**, y créalo. Espera a que diga Running.
3. En la página del servicio copia: **Host, Port, User** (normalmente `avnadmin`), **Password** y **Database name** (normalmente `defaultdb`).

## 3. Crea las tablas en Aiven (desde tu Mac)
```
cd ~/Desktop/moodmove
/usr/local/mysql/bin/mysql -h HOST -P PORT -u avnadmin -p --ssl-mode=REQUIRED defaultdb < sql/hosted_setup.sql
```
Cambia HOST y PORT por los de Aiven. Te pide la contraseña de Aiven. Si no sale ningún mensaje, funcionó. Para comprobar:
```
/usr/local/mysql/bin/mysql -h HOST -P PORT -u avnadmin -p --ssl-mode=REQUIRED defaultdb -e "SHOW TABLES;"
```
Deben salir las 5 tablas (más una tabla `sessions` cuando el servidor arranque por primera vez).

## 4. Publica el servidor en Render
1. Entra a render.com con tu cuenta de GitHub.
2. New, **Web Service**, elige el repositorio `moodmove-app`.
3. Configura:
   - Build Command: `npm install`
   - Start Command: `npm start`
   - Instance Type: **Free**
4. En **Environment Variables** agrega:
   | Nombre | Valor |
   |---|---|
   | DB_HOST | el host de Aiven |
   | DB_PORT | el puerto de Aiven |
   | DB_USER | avnadmin |
   | DB_PASSWORD | la contraseña de Aiven |
   | DB_NAME | defaultdb |
   | DB_SSL | true |
   | SESSION_SECRET | cualquier texto largo y aleatorio |
5. Create Web Service. Cuando termine, Render te da un enlace tipo `https://moodmove-xxxx.onrender.com`. Ese es tu sitio público.

## Cosas que debes saber
- El plan gratis de Render **se duerme tras 15 minutos sin visitas** y tarda cerca de 1 minuto en despertar. Abre el sitio un par de minutos antes de presentarlo.
- Aiven puede apagar la base si pasa mucho tiempo sin uso (te avisa por correo). Se vuelve a encender desde su consola.
- No pegues contraseñas en capturas ni mensajes. Si se te escapa una, cámbiala en Aiven y en Render.
- Si el sitio dice "Something went wrong", mira **Logs** en Render: ahí aparece el error exacto.
