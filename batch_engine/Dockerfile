# Use Python 3.11 slim base
FROM python:3.11-slim

# Set working directory
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-21-jdk-headless \
    build-essential \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME for Spark
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

WORKDIR /app

# Copy pyproject.toml and poetry.lock from root context
COPY pyproject.toml poetry.lock* /app/

# Copy shared common directory from root context
COPY common ./common

# Install Poetry and dependencies (no dev)
RUN pip install poetry && poetry install --no-root --without dev

# Copy batch engine source code
COPY batch_engine/jobs/ /app/jobs/

# Default command: run the batch job
CMD ["poetry", "run", "python", "-m", "jobs/utils.py"]
