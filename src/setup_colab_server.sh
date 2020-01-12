#!/usr/bin/env bash

echo "***** Cloning repository *****"

ssh-keyscan github.com >>/root/.ssh/known_hosts
git config --global user.email "john@doe.com"  # replace with your email
git config --global user.name "john.doe"  # replace with your git username
git clone git@github.com:john.doe/some_repo.git /root/some_repo  # replace with private repo url

echo "***** Configuring python3.7 and pip *****"

apt -qq install python3.7 python3-pip
apt install virtualenv

echo "***** Installing project requirements *****"

virtualenv --python=python3.7 /root/some_repo/.venv  # replace with your repo path
source /root/some_repo/.venv/bin/activate  # replace with your repo path
pip install -q -r /root/some_repo/requirements.txt

echo "***** Installing additional utilities *****"

apt install htop

apt install cmake libncurses5-dev libncursesw5-dev
git clone https://github.com/Syllo/nvtop.git
mkdir -p nvtop/build && cd nvtop/build
cmake ..
make
make install
cd ..

echo "***** Done *****"
