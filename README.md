README latex-jupyterlab
===

This is dockerization of jupyterlab with latex. It uses the component [jupyterlab-latex](https://github.com/jupyterlab/jupyterlab-latex)




# Environment variables

|Available variables      |Description                                                |
|-------------------------|-----------------------------------------------------------|
|`LOCAL_UID`              | The id of the local user running the container            |
|`LOCAL_GID`              | The id of the local group running the container           |

## Volumes

Folloing volumes are available:

|Volume          |Description                                               |
|----------------|----------------------------------------------------------|
|`/home/jovyan/work` | Location where the notebooks are saved |
|`/home/jovyan/texmf`     | Directory TEXMFHOME |
|`/etc/jupyter`     | Location of config file |

## Ports

Following port is exposed

|Port       |Description                                               |
|-----------|----------------------------------------------------------|
|`8888` | TCP port to connect the server from the client           |

# Installation

First of all configure the file `docker-compose.yml` to you need, in particular the volumes.

Start the container using the command `docker-compose up -d` and stop the container using the command `docker-compose down`.

Copy the file `jupyter_notebook_config.py` in the directory `config` to the the location mounted as `/home/jovyan/work`.

Change the configuration to your need (see https://jupyter-notebook.readthedocs.io/en/stable/config.html). In particular security elements are necessary (ssl or others).

> **WARNING**: The following options cannot be changed: `c.NotebookApp.notebook_dir`, `c.NotebookApp.open_browser`, `c.NotebookApp.port` and `c.NotebookApp.ip`

# License

The repository itself is under MIT licence (see [LICENSE](./LICENCE)).
