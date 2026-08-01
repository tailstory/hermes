FROM python:3.14-slim@sha256:cea0e6040540fb2b965b6e7fb5ffa00871e632eef63719f0ea54bca189ce14a6

COPY --from=ghcr.io/astral-sh/uv:0.9.26@sha256:9a23023be68b2ed09750ae636228e903a54a05ea56ed03a934d00fe9fbeded4b /uv /bin/

COPY uv.lock pyproject.toml ./
RUN uv sync --frozen --no-default-groups --no-install-project

COPY src/ src/
COPY README.md README.md
COPY LICENSE LICENSE
RUN uv sync --frozen --no-default-groups --no-editable

RUN adduser --disabled-password hermes
USER hermes

CMD [ "uv", "run", "--no-sync", "-m", "hermes" ]
