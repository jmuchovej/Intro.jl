ARG VERSION=1.6.0

FROM --platform=${TARGETPLATFORM} julia:${VERSION} as julia

# Copy Julia and Setup for Probmods.jl Container ------------------------------
FROM --platform=${TARGETPLATFORM} lsiodev/ubuntu:focal as probmods
ARG TARGETPLATFORM
ARG VERSION=1.6.0

COPY root/ /
COPY --from=julia /usr/local/julia/ /usr/local/julia/
COPY src/ /workspace

# ENV JULIA_PATH /opt/julia-${VERSION}
ENV JUlIA_VERSION ${VERSION}

ENV JULIA_PATH /usr/local/julia

# ensure Julia is aware of proper path
ENV JULIA_DEPOT_PATH /root/.julia

ENV PATH ${JULIA_PATH}/bin:${JULIA_DEPOT_PATH}/conda/3/bin:${PATH}

RUN apt-get update && apt-get install -y \
        curl \
        fonts-firacode \
        unzip
# Unzip is needed for Blink.jl, otherwise building fails miserably

# WORKDIR /opt
# RUN tar xzf /opt/julia-${VERSION}-linux-$(basename ${TARGETPLATFORM}).tar.gz && \
    # rm /opt/*.tar.gz

WORKDIR /workspace

# Install dependencies from `Project.toml`
RUN julia -O3 -e "using Pkg; Pkg.activate(); Pkg.resolve(); Pkg.instantiate(); Pkg.precompile()"

# Install NodeJS for JupyterLab extensions
RUN conda install --yes -c conda-forge -c defaults \
        jupyter \
        jupyterlab \
        "nodejs>=12" \
        jupyterlab-lsp

RUN jupyter labextension install \
        jupyterlab-plotly \
        jupyterlab-tailwind-theme

# Install/setup JupyterLab via IJulia
# RUN yes | julia --project=@. -e "using IJulia; jupyterlab(; dir=pwd())"

RUN curl -fsSL https://starship.rs/install.sh | bash -s -- --yes

EXPOSE 46876

# ENTRYPOINT ["/app/entrypoint.sh"]
