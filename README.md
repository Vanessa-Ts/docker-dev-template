# docker-dev-template

A simple python template for building a containerized web service with FastAPI, docker compose and `uv` package manager. 


## Stack

| Tool | Purpose |
|---|---|
| FastAPI + Jinja2 | API framework + server-side UI |
| uv | Dependency management |
| Docker + Compose | Multi-stage build, local dev |
| CI Pipeline | Test stage |
| Pydantic Settings | Environment-aware config |
| Black + isort + ruff | Formatting and linting |
| mypy | Static type checking |
| pytest | Testing |



## Develop

To start dev container use VSCode docker extension or docker compose command.
Copy the 'env.template' and add the missing variables, then run 'uv sync'.
```bash
docker compose up --build
cp .env.template .env
uv sync
```

Start web service via launch.json or run 'main.py'.