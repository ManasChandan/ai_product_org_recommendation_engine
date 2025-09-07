# 🛒 Product Organisation Recommendation Engine

A system for **retail space optimisation and product organisation** using:
- **Frontend:** Streamlit
- **Backend:** FastAPI
- **Batch Engine:** PySpark + OR-Tools
- **Databases:** Postgres + Neo4j
- **Shared Utilities:** Configs, schemas, and DB helpers

---

## 🚀 Project Structure
```
product-org-reco-engine/
│── frontend/          # Streamlit UI
│── backend/           # FastAPI service
│── batch_engine/      # Batch jobs (ETL, FP-Growth, OR-Tools, Spark)
│── common/            # Shared code (schemas, db connectors, config)
│── db/                # Postgres + Neo4j config
│── docker-compose.yml # Multi-service orchestration
│── pyproject.toml     # Root environment for local dev
│── README.md
```

- Each service has its own **`pyproject.toml`** + **Dockerfile**.  
- The root **`pyproject.toml`** is for unified **local development**.  

---

## ⚙️ Local Development Setup

### 1️⃣ Install Poetry
```bash
pip install poetry
```

### 2️⃣ Setup Environment
At the **project root**:
```bash
poetry install
```

This installs dependencies from the **root `pyproject.toml`** (includes frontend, backend, batch, common, and dev tools).

### 3️⃣ Run Services Locally
- **Frontend (Streamlit)**  
  ```bash
  poetry run streamlit run frontend/app/main.py
  ```

- **Backend (FastAPI)**  
  ```bash
  poetry run uvicorn backend.app.main:app --reload
  ```

- **Batch Engine (example ETL job)**  
  ```bash
  poetry run python batch_engine/jobs/etl.py
  ```

---

## 🐳 Docker Setup

We use **Docker Compose** to run everything in containers.

### 1️⃣ Build & Start
```bash
docker compose up --build
```

This starts:
- `frontend` → Streamlit on [http://localhost:8501](http://localhost:8501)  
- `backend` → FastAPI API on [http://localhost:8000/docs](http://localhost:8000/docs)  
- `batch_engine` → Runs ETL + optimization jobs  
- `postgres` → SQL database on port `5432`  
- `neo4j` → Graph DB UI on [http://localhost:7474](http://localhost:7474)  

### 2️⃣ Stop Containers
```bash
docker compose down
```

### 3️⃣ Persist Data
- Postgres → `postgres_data` volume  
- Neo4j → `neo4j_data` volume  

---

## 📜 Useful Commands

### Poetry
```bash
poetry install              # Install deps (local dev)
poetry run pytest           # Run tests
poetry run black .          # Format code
poetry run isort .          # Sort imports
```

### Docker
```bash
docker compose up --build   # Start all services
docker compose down         # Stop services
docker compose logs -f      # Stream logs
```

---

## 🛠️ Development Notes
- **Shared code** lives in `common/` and is referenced in each service.  
- **Databases**:
  - Postgres for structured data (sales, products, shelves)  
  - Neo4j for co-occurrence graph + product relationships  
- **Batch jobs** (PySpark + OR-Tools) are designed for offline/batch execution.  
- **Backend** serves recommendations via API to the frontend.  

---

## ✅ Next Steps
- Implement FastAPI endpoints (`backend/app/routers/`)  
- Build Streamlit dashboard (`frontend/app/main.py`)  
- Write batch jobs (`batch_engine/jobs/`)  
- Configure DB migrations (Alembic for Postgres)  
