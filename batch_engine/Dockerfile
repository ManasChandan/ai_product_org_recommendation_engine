FROM python:3.11-slim

WORKDIR /app

# Copy pyproject.toml and poetry.lock from root context
COPY pyproject.toml poetry.lock* /app/

# Copy the shared common directory from root context
COPY common ./common

# Install Poetry and dependencies without dev packages
RUN pip install poetry && poetry install --no-root --without dev

# Copy the specific service code (adjust the path for the service folder)
COPY batch_engine/jobs/ /app/jobs/

CMD ["poetry", "run", "python", "jobs/etl.py"]
