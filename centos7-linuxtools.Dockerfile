FROM centos:centos7

# bzip2 is needed in micromamba installation
#
# Replace mirror.centos.org due to EOL of centos
#
RUN sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/CentOS-*.repo \
    && sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/CentOS-*.repo \
    && sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/CentOS-*.repo \
    && yum -y install bzip2 \
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
#   fd-find, broot, lsd-rust, bat, mdcat, glow
#   duf, dust
#   rip2
RUN micromamba install -y fd-find broot lsd-rust bat mdcat glow-md \
    duf dust rip2 \
    && micromamba clean -y -a -f 

# git tools:
#   git-delta, git-lfs, lazygit
RUN micromamba install -y git-delta git-lfs lazygit \
    && micromamba clean -y -a -f 

# other tools:
#  hyperfine, direnv, zellij
RUN micromamba install -y hyperfine direnv zellij \
    && micromamba clean -y -a -f 

# set PATH and LD_LIBRARY_PATH for the container
#
ENV PATH=${prefix}/bin:${PATH} \
    LD_LIBRARY_PATH=/usr/lib64 \
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
