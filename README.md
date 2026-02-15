# docker-dev-template

A minimal, production-oriented project template for building Python backend services with FastAPI, containerised with Docker and managed with `uv`. 


#TODO: Update Readme

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
```bash
cp .env.example .env
uv sync
docker compose up --build
```

## Prod
`docker compose --profile prod up --build`