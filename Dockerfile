# ============================================================
# Build
# ============================================================
FROM python:3.11-slim AS builder

# Copy uv from official image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Compile bytecode at build time for faster container startup
# copy mode required — hardlinks don't work across Docker layers
ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy

WORKDIR /app

# Copy dependency manifest first
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-install-project --no-dev --no-cache

COPY src/ ./src/
RUN uv sync --frozen --no-dev --no-cache


# ============================================================
# Dev
# ============================================================
FROM python:3.11-slim AS development

# Create non-root user and setup app directory
RUN useradd -m -u 1000 appuser && \
    mkdir -p /app && \
    chown -R appuser:appuser /app

WORKDIR /app

# Copy venv from builder
COPY --from=builder /app/.venv /app/.venv
COPY --chown=appuser:appuser src/ ./src/

USER appuser

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONPATH="/app/src"

# TODO: Basic liveness check for Docker and local docker-compose development
# In Kubernetes this is superseded by livenessProbe/readinessProbe in the Helm chart
# targeting /health/live and /health/ready respectively

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]


# ============================================================
# Prod
# ============================================================
FROM python:3.11-slim AS production

RUN useradd -m -u 1000 appuser && \
    mkdir -p /app && \
    chown -R appuser:appuser /app

WORKDIR /app

COPY --from=builder /app/.venv /app/.venv
COPY --chown=appuser:appuser src/ ./src/

USER appuser

ENV PATH="/app/.venv/bin:$PATH" \
    PYTHONPATH="/app/src"

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]