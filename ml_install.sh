#!/usr/bin/bash

# add the conda function to the script so that conda can be run in the script
if   [ -d "$HOME/.miniconda3" ]; then
    source $HOME/.miniconda3/etc/profile.d/conda.sh
elif [ -d "$HOME/anaconda3"  ]; then
    source $HOME/.anaconda3/etc/profile.d/conda.sh
fi

# Many of the instructions here taken from https://www.tensorflow.org/install/pip#windows-native
# TensorFlow 2.10 is last version to use GPU support on Windows native.  When we move
# to 2.11+ we will have to move to WSL2.

conda create -y -n ML python=3.10 pip ipykernel ipywidgets autopep8 pandas matplotlib hvplot
conda activate ML

conda install -y -c conda-forge python-graphviz pydotplus keras-tuner
conda install -y -c plotly plotly==5.13.1 plotly-geo-1.0.0
conda install -y -c conda-forge python-kaleido

conda update --all -y

conda install -y -c conda-forge cudatoolkit=11.2 cudnn=8.1

pip install -c conda-forge -r req_ml.txt

conda install -y -c intel --no-update-deps mkl numpy scipy

echo ==============================================
echo Verify that TensorFlow was installed correctly
echo ==============================================

echo A tensor is returned... 
python -c "import tensorflow as tf; print(tf.reduce_sum(tf.random.normal([1000, 1000])))"
echo ----------------------------------------------

echo A list of GPU devices is returned...
python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
echo ----------------------------------------------

echo done.
