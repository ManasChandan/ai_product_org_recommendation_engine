FROM python:3.11-slim

WORKDIR /app

# Copy pyproject.toml and poetry.lock from root context
COPY pyproject.toml poetry.lock* /app/

# Copy shared common directory from root context
COPY common ./common

# Install Poetry and dependencies (no dev)
RUN pip install poetry && poetry install --no-root --without dev

# Copy your service code relative to root context
COPY backend/app/ /app/app/

EXPOSE 8000

CMD ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
