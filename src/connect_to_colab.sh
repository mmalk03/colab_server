#!/usr/bin/env bash

# Parse command line arguments
while getopts ":p:s" opt; do
  case $opt in
  p)
    ngrok_port="$OPTARG"
    ;;
  s)
    setup_server="1"
    ;;
  \?)
    echo "Invalid argument -$OPTARG" >&2
    ;;
  esac
done

if [ "$setup_server" == "1" ]; then
  # Add ngrok server fingerprint to known hosts
  ssh-keyscan -p "$ngrok_port" -H 0.tcp.ngrok.io >>~/.ssh/known_hosts

  # Copy private ssh key to server (used to access git repo)
  scp -P "$ngrok_port" -i ~/.ssh/id_rsa_colab ~/.ssh/id_rsa_colab root@0.tcp.ngrok.io:/root/.ssh/id_rsa_colab

  # Copy ssh git host config to server
  scp -P "$ngrok_port" -i ~/.ssh/id_rsa_colab resources/ssh_git_host_config root@0.tcp.ngrok.io:/root/.ssh/config

  # Configure env variables required for CUDA
  cat resources/colab_env_exports | ssh root@0.tcp.ngrok.io -p "$ngrok_port" -i ~/.ssh/id_rsa_colab "cat >>/root/.bash_profile"
  cat resources/colab_env_exports | ssh root@0.tcp.ngrok.io -p "$ngrok_port" -i ~/.ssh/id_rsa_colab "cat >>/root/.bashrc"

  # Remotely prepare environment on server
  ssh root@0.tcp.ngrok.io -p "$ngrok_port" -i ~/.ssh/id_rsa_colab 'bash -s' <src/setup_colab_server.sh

fi

# Obtain shell
ssh root@0.tcp.ngrok.io -p "$ngrok_port" -i ~/.ssh/id_rsa_colab
