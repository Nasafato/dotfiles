ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

files: sh bins vim
	if [ ! -f ~/.tmux.conf ]; then ln -s "$(ROOT_DIR)/tmux.conf" ~/.tmux.conf ; fi
	if [ ! -f ~/.gitconfig ]; then ln -s "$(ROOT_DIR)/gitconfig" ~/.gitconfig ; fi

#######
# Mac #
#######
	
mac-clis:
	if [ `uname -m` == 'arm64' ]; then \
		arch -arm64 brew install gh tmux neovim fd ripgrep jq fzf exa bat; \
		arch -arm64 brew install reattach-to-user-namespace; \
		arch -arm64 brew install volta; \
	else \
		brew install gh tmux neovim fd ripgrep jq fzf exa bat; \
		brew install reattach-to-user-namespace; \
		brew install volta; \
	fi

mac-alacritty:
	brew cask install alacritty

# Copy files to ~/bin directory
vim: 
	if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then \
		curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim ; \
	fi
	nvim --headless +PlugInstall +UpdateRemotePlugins +qa

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
	# brew install cask --ngrok
	
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

