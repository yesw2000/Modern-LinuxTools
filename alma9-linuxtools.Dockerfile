FROM centos:centos7 AS centos7
# FROM registry.cern.ch/docker.io/cern/alma9-base AS cern_alma9
FROM docker.io/cern/alma9-base AS cern_alma9
# FROM mambaorg/micromamba:latest as micromamba

FROM almalinux:9

# bzip2 is needed in micromamba installation
#
RUN yum -y install which file git bzip2 wget \
    && dnf -y update \
    && yum -y clean all \
    && cd /tmp && rm -f tmp* yum.log

# Automatic defined variable(s)
ARG TARGETARCH

# path prefix for micromamba to install pkgs into
#
ARG prefix=/opt/conda
ARG Micromamba_ver=2.1.0
ARG Mamba_exefile=bin/micromamba
ENV MAMBA_EXE=/$Mamba_exefile MAMBA_ROOT_PREFIX=$prefix CONDA_PREFIX=$prefix
ENV TEALDEER_CACHE_DIR=$prefix/.cache/tealdeer

ENV PATH=${prefix}/bin:${PATH}

# Updates all installed packages on the system
RUN dnf update -y

# Install micromamba
#
COPY _activate_current_env.sh /usr/local/bin/
RUN mamba_arch="linux-64" && if [ "$TARGETARCH" = "arm64" ]; then \
       mamba_arch="linux-aarch64"; \
    fi \
    && curl -L https://micromamba.snakepit.net/api/micromamba/$mamba_arch/$Micromamba_ver | \
    tar -xj -C / $Mamba_exefile \
    && mkdir -p $prefix/bin && chmod a+rx $prefix \
    && ln $MAMBA_EXE $prefix/bin/ \
    && micromamba config append --system channels conda-forge \
    && echo "source /usr/local/bin/_activate_current_env.sh" >> ~/.bashrc

# install rust, tealdeer, and uv
#
RUN micromamba install -y rust tealdeer uv \
    && $prefix/bin/tldr --update \
    && micromamba clean -y -a -f

# install search and explorer tools:
#   ripgrep, ugrep, skim, fzf
RUN micromamba install -y ripgrep ugrep skim fzf \
    && micromamba clean -y -a -f

# install image tools:
#   crane, dive
RUN micromamba install -y crane dive \
    && micromamba clean -y -a -f 

# install process and history tools:
#   procs, btop, zenith, bottom, mcfly
RUN micromamba install -y procs btop mcfly \
    && micromamba clean -y -a -f 

# file/storage tools:
#   fd-find, broot, yazi, lsd-rust, bat, glow
#   duf, dust
#   rip2
RUN micromamba install -y fd-find broot yazi lsd-rust \
    bat glow-md duf dust rip2 \
    && micromamba clean -y -a -f 

# git tools:
#   GitHub CLI (gh), git-delta, git-lfs, lazygit
RUN micromamba install -y gh git-delta git-lfs lazygit \
    && micromamba clean -y -a -f 

#- Gemini CLI, Claude Code CLI, Grok cli
#- npm install -g @vibe-kit/grok-cli
# Gemini CLI, Claude Code CLI
RUN cd /tmp && BASE_URL="https://nodejs.org/dist/latest/" \
    && filename=$(wget -q -O - "$BASE_URL" | grep -oP 'node-v\d+\.\d+\.\d+-linux-x64\.tar\.xz' | head -n 1) \
    && wget ${BASE_URL}${filename} \
    && gtar -xf ${filename} --exclude='*.md' --exclude=LICENSE --strip-components=1 -C $prefix \
    && rm -f ${filename} \
    && npm install -g @google/gemini-cli \
    && npm install -g @anthropic-ai/claude-code \
    && npm cache clean --force

# Copilot-API
COPY copilot-api $prefix/lib/node_modules/copilot-api
RUN cd $prefix/bin && ln -s ../lib/node_modules/copilot-api/node_modules/copilot-api/dist/main.js copilot-api

# Goose
RUN micromamba install -y libxcb && micromamba clean -y -a -f \
    && curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh \
    | GOOSE_BIN_DIR=$prefix/bin CONFIGURE=false bash \
    && rm -rf /tmp/*

# other tools:
#  hyperfine, direnv, zellij
RUN micromamba install -y hyperfine direnv zellij \
    && micromamba clean -y -a -f 


# copy libssl.so.10 to make jupter-labhub from centos7-based host work
# COPY --from=centos7  /lib64/libfreebl3.so /lib64/libcrypt.so.1 /lib64/libcrypto.so.10 \
#      /lib64/libssl.so.10 /lib64/libtinfo.so.5 /lib64/libncursesw.so.5 /lib64/libffi.so.6 /lib64


# set PATH and LD_LIBRARY_PATH for the container
#
ENV LD_LIBRARY_PATH=/usr/lib64:$prefix/lib \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

# copy setup script and readme file
#
COPY setupMe.sh list-of-tools.md /
# COPY setupMe.sh printme.sh /
# RUN cp /printme.sh /etc/profile.d/

# Singularity
# RUN mkdir -p /.singularity.d/env \
#    && cp /printme.sh /.singularity.d/env/99-printme.sh

COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
