show_git() {
  local cwd=$(tmux display-message -p -F "#{pane_current_path}")
  if ! command -v gitmux >/dev/null 2>&1; then
    return
  fi

  # Check if current directory is inside a Git repository
  if ! git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    return
  fi

  local index=$1
  local icon="$(get_tmux_option "@catppuccin_gitmux_icon" "")"
  local color="$(get_tmux_option "@catppuccin_gitmux_color" "$thm_green")"
  local text="$(get_tmux_option "@catppuccin_gitmux_text" "#(gitmux -cfg $XDG_CONFIG_HOME/tmux/gitmux.conf \"#{pane_current_path}\")")"
  local module=$( build_status_module "$index" "$icon" "$color" "$text" )
  echo "$module"
}
