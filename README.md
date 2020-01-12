# Colab server
This repository describes how to configure ssh connection with Google Colab server.
This allows to use Colab's infrastructure without the need to use Jupyter notebooks.
Bash scripts show examples how to automatically clone a private git repo using ssh keys, configure CUDA and prepare a Python environment.

## Requirements
* Create an account on [ngrok](https://ngrok.com/), which gives public URLs to expose local web servers.
* Generate a new ssh key pair (in this example `id_rsa_colab` is used as the key name) and upload only your *public* ssh key to some publicly accessible place (e.g. by creating a public file on Google Drive), so that bash scripts can connect by ssh to server automatically by using your private key.

## Files
* `src/colab_server.ipynb` - short notebook which launches ngrok on Colab's server
* `src/connect_to_colab.sh` - connects from local machine to Colab's server using ssh, sets up git configuration, exports environment variables which are required for CUDA and launches script to prepare the environment 
* `src/setup_colab_server.sh` - clones an examplary repository and configures Python environment on the server
