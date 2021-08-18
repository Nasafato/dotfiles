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
	curl -fLo ~/.git-completion.bash \
	  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash ;

zsh:
	mkdir -p ~/.zsh
	cp ./zshrc-new ~/.zsh/zshrc
	if [ ! -f ~/.zshrc ]; then ln -s ~/.zsh/zshrc ~/.zshrc ; fi
	curl -fLo ~/.zsh/_git \
	  https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh


# Copy files to ~/bin directory
bins:
	mkdir -p ~/bin
	echo "cd $(ROOT_DIR) && make vim-initrc > /dev/null" >> ~/bin/refresh-vim.sh
	chmod +x ~/bin/refresh-vim.sh
	
vim: 
	mkdir -p ~/.config/nvim/lua
	if [ -f ~/.config/nvim/init.vim ]; then \
		rm ~/.config/nvim/init.vim ; \
	fi	
	if [ ! -d ~/.config/nvim ]; then mkdir ~/.config/nvim ; fi
	ln -s "$(ROOT_DIR)/nvim/init.vim" ~/.config/nvim/init.vim
	if [ ! -f ~/.local/share/nvim/autoload/plug.vim ]; then \
		curl -fLo ~/.local/share/nvim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ; \
	fi
	nvim --headless +PlugInstall +UpdateRemotePlugins +qa

vim-initrc:
	# If it's a Mac, then edit init.vim such that all instances of unknown-linux-musl are replaced
	# with apple-darwin. The -i '' argument tells sed to not save a backup of the edited file
	# when editing in place.
	# if [ `uname` = "Darwin" ]; then sed -i '' s/unknown-linux-musl/apple-darwin/ init.vim ; fi

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

rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

