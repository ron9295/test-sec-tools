# --- Stage 1: Builder ---
# Use a full Python image for building dependencies
FROM python:3.11 AS builder

# Set environment variables
ENV PYTHONUNBUFFERED 1
ENV POETRY_HOME="/opt/poetry"
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV PATH="$POETRY_HOME/bin:$PATH"

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python -

# Set working directory
WORKDIR /app

# Copy dependency files and install them
# Copy pyproject.toml and poetry.lock
COPY pyproject.toml poetry.lock /app/

# Install dependencies - Use a simple requirements.txt step if poetry is too complex for initial setup
# Using 'poetry export' to generate a requirements.txt is often easier for Docker.
# Since the doc uses poetry add, we will stick to the poetry install command.
RUN poetry install --no-root --no-dev

# --- Stage 2: Final Image ---
# Use a smaller base image for the final runtime
FROM python:3.11-slim

# Set environment variables
ENV PYTHONUNBUFFERED 1
ENV VIRTUAL_ENV="/app/.venv"
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV PORT 8000

# Set working directory
WORKDIR /app

# Copy the installed dependencies and application code from the builder stage
COPY --from=builder /app/.venv /app/.venv
COPY . /app/

# Set the Django settings module
ENV DJANGO_SETTINGS_MODULE=myproject.settings
# Recommended: Run migrations and collect static files at container startup or as part of a pre-deployment step.
# For simplicity and fast startup, we will only run the server here.
# A full deployment would separate these.

# Expose the application port
EXPOSE $PORT

# Command to run the application using Gunicorn (assuming you added it with poetry)
# Use a production-ready command.
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi:application"]
