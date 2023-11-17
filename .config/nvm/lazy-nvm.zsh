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
  prefix="v"
  current_ver="${"$(node -v)"#"$prefix"}" # node version without prefix

  if [ -f "$nvmrc" ]; then
    target_ver="${"$(cat "$nvmrc" | xargs)"#"$prefix"}" # whitespace-trimmed nvmrc version without prefix

    if [[ ! -z "$target_ver" && "$target_ver" != "$current_ver" ]]; then
      echo "Found .nvmrc with v$target_ver specified. Trying to switch to this node version..."
      nvm use "$target_ver"
    fi
  else
    default_ver="${"$(echo $DEFAULT_NODE_VER)"#"$prefix"}" # default node version without prefix

    if [ "$current_ver" != "$default_ver" ]; then
      echo "No .nvmrc found in the directory. Switching back to default node version..."
      nvm use default
    fi
  fi
}
chpwd_functions=(switch_node_version)
switch_node_version
