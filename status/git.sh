#!/usr/bin/env bash
show_git() {

  local cwd=$(tmux display-message -p -F "#{pane_current_path}")
  if ! command -v gitmux >/dev/null 2>&1; then
    return
  fi

  local lavender="#b4befe"
  local icon=$(get_tmux_option "@catppuccin_git_icon" "")
  local color=$(get_tmux_option "@catppuccin_git_color" "$lavender")
  local prefix="#[fg=$color,bg=default,nobold,nounderscore,noitalics] #[fg=$thm_gray,bg=$color,nobold,nounderscore,noitalics]$icon #[fg=$thm_fg,bg=$thm_gray]"
  local suffix="#[fg=$thm_gray,bg=default,nobold,nounderscore,noitalics]"

  echo "#(if cd #{pane_current_path} && git rev-parse --is-inside-work-tree > /dev/null 2>&1; then { echo '$prefix ';gitmux -cfg $XDG_CONFIG_HOME/tmux/gitmux.conf '#{pane_current_path}';echo '$suffix'; } | tr -d \"\n\"; fi)"
}
