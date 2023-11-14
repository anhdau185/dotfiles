export NVM_DIR="$HOME/.nvm"

# This loads nvm on-demand
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm without automatically executing `nvm use` after loading
  nvm $@
}

# This resolves the default node version
DEFAULT_NODE_VER="$( (cat "$NVM_DIR/alias/default" || cat ~/.nvmrc) 2> /dev/null )"
while [ -s "$NVM_DIR/alias/$DEFAULT_NODE_VER" ] && [ ! -z "$DEFAULT_NODE_VER" ]; do
  DEFAULT_NODE_VER="$(cat "$NVM_DIR/alias/$DEFAULT_NODE_VER")"
done

# This resolves the path to the default node version
DEFAULT_NODE_VER_PATH="$(find $NVM_DIR/versions/node -maxdepth 1 -name "v${DEFAULT_NODE_VER#v}*" | sort -rV | head -n 1)"

# This adds the default node version path to PATH
if [ ! -z "$DEFAULT_NODE_VER_PATH" ]; then
  export PATH="$DEFAULT_NODE_VER_PATH/bin:$PATH"
fi

# This switches node version automatically if there is .nvmrc in the directory
switch_node_version() {
  nvmrc="./.nvmrc"

  if [ -f "$nvmrc" ]; then
    target_version="$(cat "$nvmrc")"
    current_version="$(node -v)"

    if [ "$target_version" != "$current_version" ]; then
      nvm use $target_version
    fi
  fi
}
chpwd_functions=(switch_node_version)
