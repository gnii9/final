#!/bin/bash
set -e

echo "======================================"
echo "VSign AI - Django Entrypoint"
echo "======================================"

# Wait for MySQL to be ready
echo "Waiting for MySQL to be ready..."
while ! nc -z $DB_HOST $DB_PORT; do
  sleep 1
done
echo "MySQL is ready!"

# Run migrations
echo "Running database migrations..."
python manage.py makemigrations --noinput
python manage.py migrate --noinput

# Create superuser if not exists (optional)
echo "Creating superuser if not exists..."
python manage.py shell << END
from django.contrib.auth import get_user_model
User = get_user_model()
if not User.objects.filter(username='admin').exists():
    User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
    print('Superuser created: username=admin, password=admin123')
else:
    print('Superuser already exists')
END

# Collect static files (if needed)
# python manage.py collectstatic --noinput

echo "======================================"
echo "Starting Django server..."
echo "======================================"

# Start Django development server
exec python manage.py runserver 0.0.0.0:8000
