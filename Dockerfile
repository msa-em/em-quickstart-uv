# slim uv base image
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

# safe to use system, since container already isolated
ENV UV_SYSTEM_PYTHON=1
COPY ./requirements.in .
RUN uv pip install -r requirements.in

CMD ["uv", "run", "jupyter", "lab"]
