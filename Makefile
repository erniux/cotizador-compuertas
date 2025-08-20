.PHONY: up down rebuild be shell fe logs migrate superuser

up:
\tdocker compose up -d db redis backend frontend-dev

down:
\tdocker compose down

rebuild:
\tdocker compose build --no-cache backend frontend

be:
\tdocker compose exec backend bash

shell:
\tdocker compose exec backend python manage.py shell

migrate:
\tdocker compose exec backend python manage.py migrate

superuser:
\tdocker compose exec backend python manage.py createsuperuser

logs:
\tdocker compose logs -f --tail=200
