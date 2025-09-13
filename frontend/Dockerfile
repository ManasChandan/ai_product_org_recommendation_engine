FROM python:3.11-slim

WORKDIR /app

COPY pyproject.toml poetry.lock* /app/
RUN pip install poetry && poetry install --no--root --no-dev

COPY app/ /app/app/

EXPOSE 8501
CMD ["poetry", "run", "streamlit", "run", "app/main.py", "--server.port=8501", "--server.address=0.0.0.0"]
