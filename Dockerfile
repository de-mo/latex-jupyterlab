FROM jupyter/minimal-notebook:latest

EXPOSE 8888

# Install Jupyterlab_latex
RUN pip install jupyterlab_latex
RUN jupyter labextension install @jupyterlab/latex

USER root

# Tools
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    gosu

# remove old version livetex
RUN apt-get auto-remove -y texlive* biber
RUN rm -rf /usr/local/texlive/2020 \
    rm -rf ~/.texlive2020 \
    rm -rf /usr/local/texlive/2019 \
    rm -rf ~/.texlive2019


# install new version livetex
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      texlive-xetex \
      texlive-latex-extra \
      texlive-fonts-recommended \
      texlive-plain-generic \
      biber

# Additional packages (e.g. Language french)
RUN apt-get install -y --no-install-recommends \
      texlive-lang-french

# Empty apt-get list
RUN rm -rf /var/lib/apt/lists/*

# Volumes
VOLUME /host/texmf
VOLUME /host/work

# Install entrypoint
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["start-notebook.sh"]
