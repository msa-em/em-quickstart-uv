# slim uv base image
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

# install deps
COPY ./requirements.in .
RUN uv venv /opt/venv
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN uv pip install -r requirements.in

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

# run jupyterlab
CMD ["uv", "run", "jupyter", "lab"]
