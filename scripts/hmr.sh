#!/usr/bin/env bash

reload_plugins() {
  echo "Reloading Kong Plugins"
  vagrant ssh -c "~/scripts/compile_plugins.sh"
  vagrant ssh -c "cd /tf/dev; terraform apply -auto-approve"
}

export -f reload_plugins

fswatch -0 -xr --event=Updated ../../../kong-plugin/permission-middleware | xargs -0 -n1 bash -c reload_plugins
