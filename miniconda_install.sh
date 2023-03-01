#!/usr/bin/env bash

echo "Looking for Miniconda installable file in $HOME/Downloads"

for file in $HOME/Downloads/Miniconda*.sh; do
    MINICONDA_SH="${file}"
    break
done

if [[ ! -f $MINICONDA_SH ]]; then
    echo "Cannot find Miniconda installation script"
    exit 1
fi

echo "Miniconda script: $MINICONDA_SH"

echo "Installing Miniconda"

if [ ! -d "$HOME/.miniconda3" ]; then
  echo "Install the lastest Miniconda distribution"
  bash $MINICONDA_SH -b -p $HOME/.miniconda3
  export PATH="$HOME/.miniconda3/bin:$PATH"
  conda init bash
  echo "Remember to restart the shell to load the evars"
  exit 0
fi

echo "Miniconda already installed; installing additional packages"

if [ ! -f "$HOME/.condarc" ]; then
cat << END > $HOME/.condarc
channels:
  - defaults
  - conda-forge
END
fi

conda update -y conda
conda update --all -y

conda install -y pip notebook jupyterlab widgetsnbextension ipywidgets
conda install -y nb_conda_kernels jupyter_contrib_nbextensions autopep8 

### Uncomment the next two lines if you do not already have node.js (node and npm) installed and on the path

# pip install nodejs-bin
# pip install nodejs-bin[cmd]

jupyter contrib nbextension install

jupyter nbextension enable scratchpad/main
jupyter nbextension enable code_prettify/autopep8
jupyter nbextension enable splitcell/splitcell
jupyter nbextension enable scratchpad/main
jupyter nbextension enable move_selected_cells/main
jupyter nbextension enable addbefore/main
jupyter nbextension enable hinterland/hinterland
jupyter nbextension enable runtools/main
jupyter nbextension enable comment-uncomment/main
jupyter nbextension enable table_beautifier/main
jupyter nbextension enable code_font_size/code_font_size

# rm -rf $HOME/miniconda3/share/jupyter/nbextensions/highlight_selected_word

conda install -y rise

# cd gmaps
# . ./dev-install
# cd ..
# jupyter nbextension enable gmaps --py

jupyter nbextension list

# jupyter lab build

echo "Done."
