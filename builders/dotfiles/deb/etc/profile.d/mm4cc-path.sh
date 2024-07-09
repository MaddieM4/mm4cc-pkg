paths=("$HOME/bin" "$HOME/.cargo/bin")

for path in ${paths[@]}; do
  if [ -e "$path" ]; then
    export PATH="$PATH:$path"
  fi
done
