
# cotizador-compuertas

## Cómo levantar la aplicación en local

1. **Clona el repositorio:**
   ```bash
   git clone git@github.com:erniux/cotizador-compuertas.git
   cd cotizador-compuertas
   ```

2. **Copia y edita el archivo de entorno:**
   ```bash
   cp backend/.env.example backend/.env
   # Edita backend/.env con tus variables locales si es necesario
   ```

3. **Levanta los servicios principales:**
   ```bash
   docker compose up -d db redis
   ```

4. **Crea el proyecto Django (solo la primera vez):**
   ```bash
   docker compose run --rm backend django-admin startproject app /app/app
   ```

5. **Aplica migraciones y crea el superusuario:**
   ```bash
   docker compose up -d backend
   docker compose exec backend python app/manage.py migrate
   docker compose exec backend python app/manage.py createsuperuser
   ```

6. **Levanta el frontend en modo desarrollo:**
   ```bash
   docker compose up -d frontend-dev
   ```

7. **Accede a la aplicación:**
   - Backend: http://localhost:8000
   - Frontend: http://localhost:5173
