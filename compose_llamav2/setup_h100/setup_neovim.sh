curl -L https://github.com/neovim/neovim/releases/download/v0.9.1/nvim-linux64.tar.gz | sudo tar -xzvf - --strip-components=1 -C /usr/local
python3 -m pip install --upgrade pynvim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p ~/.config/nvim/
cp -fr neovim/* ~/.config/nvim/
chmod -R o+wrx ~/.config
chown -R root:root  ~/.config
#nvim +VundleInstall


