# 🛒 Product Organisation Recommendation Engine

A system for **retail space optimisation and product organisation** using:

* **Frontend:** Streamlit
* **Backend:** FastAPI
* **Batch Engine:** PySpark + OR-Tools
* **Databases:** Postgres + Neo4j
* **Shared Utilities:** Configs, schemas, and DB helpers

---

## 🚀 Project Structure

```
product-org-reco-engine/
│── frontend/          # Streamlit UI + frontend pyproject.toml & poetry.lock
│── backend/           # FastAPI service + pyproject.toml & poetry.lock
│── batch_engine/      # Batch jobs + pyproject.toml & poetry.lock
│── common/            # Shared code (schemas, db connectors, config)
│── db/                # Postgres + Neo4j config
│── docker-compose.yml # Multi-service orchestration
│── pyproject.toml     # Root environment for local dev + poetry.lock
│── README.md
```

* Each service now has its own **`pyproject.toml` + `poetry.lock`** for production/UAT reproducibility.
* The root **`pyproject.toml` + `poetry.lock`** is used for unified **local development**.

---

## ⚙️ Local Development Setup

### 1️⃣ Install Poetry

```bash
pip install poetry
```

### 2️⃣ Setup Environment

At the **project root**, use the lock file to ensure deterministic installs:

```bash
poetry install --no-root
```

This installs dependencies from the **root `poetry.lock`**, which includes all services and dev tools.

### 3️⃣ Run Services Locally

* **Frontend (Streamlit)**

```bash
poetry run streamlit run frontend/app/main.py
```

* **Backend (FastAPI)**

```bash
poetry run uvicorn backend.app.main:app --reload
```

* **Batch Engine (example ETL job)**

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

* `frontend` → Streamlit on [http://localhost:8501](http://localhost:8501)
* `backend` → FastAPI API on [http://localhost:8000/docs](http://localhost:8000/docs)
* `batch_engine` → Runs ETL + optimization jobs
* `postgres` → SQL database on port `5432`
* `neo4j` → Graph DB UI on [http://localhost:7474](http://localhost:7474)

### 2️⃣ Stop Containers

```bash
docker compose down
```

### 3️⃣ Persist Data

* Postgres → `postgres_data` volume
* Neo4j → `neo4j_data` volume

---

## 📜 Useful Commands

### Poetry

```bash
# Install deps using lock file (deterministic)
poetry install --no-root

# Run tests
poetry run pytest

# Format code
poetry run black .

# Sort imports
poetry run isort .
```

### Docker

```bash
docker compose up --build   # Start all services
docker compose down         # Stop services
docker compose logs -f      # Stream logs
```

---

## 🛠️ Dependency & Lock File Workflow

1. **Local Development (root environment)**

   * Add/update a dev dependency in **root pyproject.toml**:

   ```bash
   poetry add <package>
   ```

   * Update lock file:

   ```bash
   poetry lock
   ```

   * Install using the lock:

   ```bash
   poetry install --no-root
   ```

2. **Service-specific dependencies (production/UAT)**

   * Add/update a dependency in the service pyproject.toml:

   ```bash
   cd backend
   poetry add <package>
   poetry lock
   ```

   * Install exactly as locked (deterministic):

   ```bash
   poetry install --no-root
   ```

3. **UAT / Testing**

   * Use the **service lock** for testing to ensure prod parity:

   ```bash
   cd backend
   poetry install --no-dev --no-root
   poetry run pytest
   ```

4. **Best Practices**

   * Root lock = local dev reproducibility.
   * Service locks = production/UAT reproducibility.
   * **Do not manually edit lock files**; always regenerate from the pyproject.toml.
   * Commit all lock files after updates to ensure deterministic builds.

---

## 🛠️ Development Notes

* **Shared code** lives in `common/` and is referenced in each service.
* **Databases**:

  * Postgres for structured data (sales, products, shelves)
  * Neo4j for co-occurrence graph + product relationships
* **Batch jobs** (PySpark + OR-Tools) are designed for offline/batch execution.
* **Backend** serves recommendations via API to the frontend.
* **Lock files**:

  * **Root lock** → local dev reproducibility
  * **Service locks** → production/UAT reproducibility

---

## ✅ Next Steps

* Implement FastAPI endpoints (`backend/app/routers/`)
* Build Streamlit dashboard (`frontend/app/main.py`)
* Write batch jobs (`batch_engine/jobs/`)
* Configure DB migrations (Alembic for Postgres)
* Maintain `.lock` files in all services for deterministic builds in dev and prod
