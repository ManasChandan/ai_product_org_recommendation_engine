FROM python:3.11-slim

WORKDIR /app

# Copy pyproject.toml and poetry.lock from root context
COPY pyproject.toml poetry.lock* /app/

# Copy shared common directory from root context
COPY common ./common

# Install Poetry and dependencies (no dev)
RUN pip install poetry && poetry install --no-root --without dev

# Copy the app source code
COPY frontend/app/ /app/app/

EXPOSE 8501

CMD ["poetry", "run", "streamlit", "run", "app/main.py", "--server.port=8501", "--server.address=0.0.0.0"]
