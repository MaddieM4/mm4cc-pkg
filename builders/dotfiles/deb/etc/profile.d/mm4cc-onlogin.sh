# Set up PATH with extra entries
paths=("$HOME/bin" "$HOME/.cargo/bin")
for path in ${paths[@]}; do
  if [ -e "$path" ]; then
    export PATH="$PATH:$path"
  fi
done

if (which ssh-agent > /dev/null); then
  eval $(ssh-agent)
fi
