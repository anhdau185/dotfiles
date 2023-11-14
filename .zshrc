# zmodload zsh/zprof # Uncomment this line to enable profiling

# Oh My Zsh configurations
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-vi-mode
)

# Prevent oh-my-zsh from dumping .zcompdump* file to $HOME
# And switch to a more sensible location
export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

source $ZSH/oh-my-zsh.sh
# End of Oh My Zsh configurations

# Powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh

# Automatically switch node version if there is .nvmrc in the directory
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Paths to local repos
export FE_CORE="dev/eh/frontend-core"
export MAIN_APP="dev/eh/employment-hero"
export AUTH_SERVICE="dev/eh/auth"
export EXPENSES="dev/eh/expenses"
export MOBILE="dev/eh/eh-mobile-pro"
export HERO_DESIGN="dev/eh/hero-design"

export DATABASE_HOST=localhost
export DATABASE_PORT=5432
# export DATABASE_NAME=auth_service_development
export APP_ENV=development

export PATH="/usr/local/opt/libpq/bin:$PATH"

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/tools/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

# Needed for Python 2 installation
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# Rust lang - cargo, rustc, rustup and other commands will be added to PATH
source "$HOME/.cargo/env"

# RVM, Ruby, and gems configurations
# These envs make sure rvm install rubies successful on M1 chip
export PATH="$(brew --prefix)/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L$(brew --prefix)/opt/openssl@1.1/lib"
export CPPFLAGS="-I$(brew --prefix)/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="$(brew --prefix)/opt/openssl@1.1/lib/pkgconfig"
export RUBY_CFLAGS=-DUSE_FFI_CLOSURE_ALLOC
export optflags="-Wno-error=implicit-function-declaration"

export GEM_HOME="$HOME/.rvm/gems/ruby-2.7.2"
export GEM_PATH="$HOME/.rvm/gems/ruby-2.7.2:$HOME/.rvm/gems/ruby-2.7.2@global"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$GEM_HOME/bin:$PATH"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# End of RVM, Ruby, and gems configurations

# Java
export JAVA_HOME=$(/usr/libexec/java_home)

# Eslint and prettier executables
# export MASON_HOME="$HOME/.local/share/nvim/mason"
# alias eslint_d="$MASON_HOME/bin/eslint_d"
# alias prettierd="$MASON_HOME/bin/prettierd"

# Handy aliases to attach to tmux workspace session or create a new one if non-existent
alias workspace="tmux new-session -A -s workspace"
alias ws="tmux new-session -A -s workspace"

# Command aliases for commonly visited directories
alias nvimconf="cd $HOME/.config/nvim && nvim"
alias fecore="cd $HOME/$FE_CORE && nvim"
alias mobile="cd $HOME/$MOBILE && nvim"
alias mainapp="cd $HOME/$MAIN_APP && nvim"

# Other handy aliases
alias vim=nvim
alias dotfiles="git --git-dir=$HOME/dev/dotfiles/ --work-tree=$HOME"

# zprof # Uncomment this line to enable profiling
