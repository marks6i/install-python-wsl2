#!/usr/bin/bash

# add the conda function to the script so that conda can be run in the script
if   [ -d "$HOME/.miniconda3" ]; then
    source $HOME/.miniconda3/etc/profile.d/conda.sh
elif [ -d "$HOME/.anaconda3"  ]; then
    source $HOME/.anaconda3/etc/profile.d/conda.sh
fi

conda create -y -n PythonData python=3.10 pip ipykernel ipywidgets anaconda
conda activate PythonData
conda env list

# exit 0
# conda update --all -y

# install chromedriver which matches the installed version of Chrome, currently 105
# from https://chromedriver.chromium.org/downloads (should match version from About box
# in Chrome

pip install -r req_pythondata.txt
