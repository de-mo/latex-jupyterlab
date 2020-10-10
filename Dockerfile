FROM jupyter/minimal-notebook:latest

EXPOSE 8888

# Install Jupyterlab_latex
RUN pip install jupyterlab_latex
RUN jupyter labextension install @jupyterlab/latex

USER root

# Tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gosu

# remove old version livetex
RUN apt-get auto-remove -y texlive-xetex \
      texlive-fonts-recommended \
      texlive-plain-generic

# install new version livetex
RUN apt-get install -y --no-install-recommends \
      gosu \
      texlive-xetex \
      texlive-latex-extra

# Install entrypoint
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]$
CMD ["start-notebook.sh"]
