#!/usr/bin/env bash
set -e

# Espera a Postgres
python - <<'PY'
import os, time, psycopg2
host=os.getenv("POSTGRES_HOST","db")
port=os.getenv("POSTGRES_PORT","5432")
user=os.getenv("POSTGRES_USER","cotizador")
pwd=os.getenv("POSTGRES_PASSWORD","secret")
db=os.getenv("POSTGRES_DB","cotizador")
for i in range(30):
    try:
        psycopg2.connect(host=host, port=port, user=user, password=pwd, dbname=db).close()
        break
    except Exception:
        time.sleep(1)
PY


# Migraciones/carga estática
python /app/app/manage.py migrate --noinput || true
python /app/app/manage.py collectstatic --noinput || true

# Modo dev o prod según DJANGO_DEBUG
if [ "${DJANGO_DEBUG}" = "1" ]; then
  python /app/app/manage.py runserver 0.0.0.0:8000
else
  gunicorn app.app.wsgi:application --bind 0.0.0.0:8000 --workers 3
fi
