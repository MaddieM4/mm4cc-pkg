if [ -e $HOME/.config/mm4cc/secrets ]; then
  pushd $HOME/.config/mm4cc/secrets > /dev/null
  for name in *; do
    export "$name"="$(cat "$name")"
  done
  popd > /dev/null
fi
