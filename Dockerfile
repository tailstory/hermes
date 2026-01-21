FROM python:3.14-slim@sha256:3955a7dd66ccf92b68d0232f7f86d892eaf75255511dc7e98961bdc990dc6c9b

COPY --from=ghcr.io/astral-sh/uv:0.9.18@sha256:5713fa8217f92b80223bc83aac7db36ec80a84437dbc0d04bbc659cae030d8c9 /uv /bin/

COPY uv.lock pyproject.toml ./
RUN uv sync --frozen --no-default-groups

COPY src/ src/
RUN uv sync --frozen --no-default-groups --no-editable

RUN adduser --disabled-password hermes
USER hermes

CMD [ "uv", "run", "--no-sync", "-m", "hermes" ]
