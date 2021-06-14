ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

files: sh bins vim
	if [ ! -f ~/.tmux.conf ]; then ln -s "$(ROOT_DIR)/tmux.conf" ~/.tmux.conf ; fi
	if [ ! -f ~/.gitconfig ]; then ln -s "$(ROOT_DIR)/gitconfig" ~/.gitconfig ; fi

#######
# Mac #
#######
	
mac-clis:
	arch -arm64 brew install gh tmux neovim fd ripgrep jq fzf
	arch -arm64 brew install reattach-to-user-namespace
	arch -arm64 brew install volta

mac-alacritty:
	brew cask install alacritty
	
sh:
	gh config set git_protocol ssh

zsh:
	mkdir -p ~/.zsh
	cp ./zshrc-new ~/.zsh/zshrc
	if [ ! -f ~/.zshrc ]; then ln -s ~/.zsh/zshrc ~/.zshrc ; fi

# Copy files to ~/bin directory
bins:
	mkdir -p ~/bin
	echo "cd $(ROOT_DIR) && make vim-initrc > /dev/null" >> ~/bin/refresh-vim.sh
	chmod +x ~/bin/refresh-vim.sh
	
vim: vim-initrc
	cp colors.vim ~/.vim/colors/alan.vim
	if [ ! -f ~/.vim/autoload/plug.vim ]; then \
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ; \
	fi
	if [ ! -d ~/.config/nvim ]; then ln -s ~/.vim ~/.config/nvim ; fi
	nvim --headless +PlugInstall +UpdateRemotePlugins +qa

vim-initrc:
	mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors ~/.config
	# If it's a Mac, then edit init.vim such that all instances of unknown-linux-musl are replaced
	# with apple-darwin. The -i '' argument tells sed to not save a backup of the edited file
	# when editing in place.
	if [ `uname` = "Darwin" ]; then sed -i '' s/unknown-linux-musl/apple-darwin/ init.vim ; fi
	if [ ! -f ~/.vim/init.vim ]; then ln -s ~/.vim/init.vim ~/.vimrc ; fi
	cp init.vim ~/.vim/init.vim
	echo "BASE_INIT_VIM=$(ROOT_DIR)/init.vim" >> ~/.zprofile

mac-apps:
	brew install --cask pdf-expert

########
# Work #
########

work:
	mkdir -p ~/work
	if (gh auth login 2>&1 >/dev/null) | grep -q 'logged into any Github hosts'; \
	  then echo "Not logged in"; gh auth login --web; \
	  else echo "Logged in"; \
	fi
	if [ ! -d ~/work/web ]; then gh repo clone AgoraSystems/web ~/work/web ; fi
	if [ ! -d ~/work/prisma-server ]; then gh repo clone AgoraSystems/prisma-server ~/work/prisma-server ; fi
	brew install cask --ngrok
	
work-prisma:
	# curl  https://get.volta.sh | bash
	# VOLTA_HOME="$$HOME/.volta" PATH="$$VOLTA_HOME/bin:$PATH" volta install node@12
	# npm install -g prisma@1.34.0
	# brew install --cask docker
	# cd ~/work/prisma-server && docker compose up -d
	cd ~/work/web/server/database && prisma deploy --env-file ../../local.env

work-pg:
	arch -arm64 brew install pgcli

work-vpn:
	arch -arm64 brew install openvpn

