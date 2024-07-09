if [ -e $HOME/.config/mm4cc/secrets ]; then
  pushd $HOME/.config/mm4cc/secrets
  for name in *; do
    echo "$name"
    export "$name"="$(cat "$name")"
  done
  popd
fi
