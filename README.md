# MoodMove: registro y login

## Cómo correrlo (Mac)
1. Descomprime el zip y entra a la carpeta:
   cd ~/Desktop/moodmove
2. Instala los paquetes (la primera vez, y otra vez si actualizaste desde un zip anterior):
   npm install
3. Abre `db-config.js` y revisa que `password` sea la de tu MySQL.
4. Detén cualquier script viejo que use el puerto 3000 (Ctrl+C en esa ventana).
5. Arranca el servidor:
   node server.js
   Debe salir: "Listening on port 3000..." y "Database connection established".
6. Abre en el navegador: http://localhost:3000/register.html

No hace falta volver a crear las tablas: usa las que ya tienes en la base `moodmove`.
`sql/moodmove_setup.sql` es solo un respaldo (¡borra la base y todos los usuarios!).

## Archivos
- server.js: servidor Express (rutas /register, /login, /logout, /dashboard)
- db-config.js: contraseña de MySQL (no se sube a GitHub, está en .gitignore)
- public/: páginas (register.html, login.html, about.html), css y js
  Copia aquí tu index.html, tus imágenes (images/) y lo demás del sitio.

## Publicarlo en línea
Mira `DEPLOY.md` (GitHub + Aiven + Render).
`config.js` lee la configuración de `db-config.js` en tu computadora y de variables de entorno en el hosting.
