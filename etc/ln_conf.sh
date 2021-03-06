#!/bin/bash

cd $(dirname $0)
config_dir=$PWD

app=${app:-"all"}

if [[ $app == "all" ]]; then
    if [ -f $HOME/.zshrc.local ]; then
        sed -i "/CONFIG_DIR/d" $HOME/.zshrc.local
    fi
    echo "CONFIG_DIR=$config_dir" | tee -a $HOME/.zshrc.local
    ln -sfv $PWD/zshrc ~/.zshrc
    ln -sfv $PWD/bashrc ~/.bashrc
    ln -sfv $PWD/bashenv ~/.bashenv
    ln -sfv $PWD/dircolors ~/.dircolors
    ln -sfv $PWD/inputrc ~/.inputrc
    ln -sfv $PWD/tigrc ~/.tigrc
    ln -sfv $PWD/ctags ~/.ctags
    ln -sfv $PWD/tmux.conf ~/.tmux.conf
    ln -sfv $PWD/npmrc ~/.npmrc

    # nvim
    mkdir -p ~/.config/nvim
    echo "set nvim init.vim"
    #rm -f ~/.config/nvim/init.vim
    #echo "source ~/.vim/vimrc" > ~/.config/nvim/init.vim
    ln -svf $PWD/../vimrc ~/.config/nvim/init.vim
fi

# windows
#mkdir %userprofile%\AppData\Local\nvim
#echo source d:\tool\vim\vimrc > %userprofile%\AppData\Local\nvim\init.vim
#echo source d:\tool\vim\vimrc > %userprofile%\_vimrc   #use this doesn't load defaults.vim

# npm
if [[ $app == "npm" ]]; then
    type npm >/dev/null 2>&1 && {
        mkdir -p ~/.npm
        cd ~/.npm
        npm install cnpm
    }
fi

# pypi mirror
if [[ $app == "pip" ]]; then
    PYPI=https://opentuna.cn/pypi/web/simple
    pip3 install -i $PYPI pip -U
    pip3 config set global.index-url $PYPI
fi


