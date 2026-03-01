# docker-dev-template

A project template for building a simple Python web service with FastAPI, containerised with Docker and managed with `uv`. 




## Stack

| Tool | Purpose |
|---|---|
| FastAPI + Jinja2 | API framework + server-side UI |
| uv | Dependency management |
| Docker + Compose | Multi-stage build, local dev |
| Pydantic Settings | Environment-aware config |
| Black + isort + ruff | Formatting and linting |
| mypy | Static type checking |
| pytest | Testing |



## Develop

Use VSCode docker extension or 

```bash
cp .env.example .env
uv sync
docker compose up --build
```
