
setup_cat_alias() {
  local batcmd="$1"

  # Save original cat
  alias rcat="$(printf '%q' "$(command -v cat)")"
  alias cat="$(printf '%q' "$(command -v "$batcmd")")"

  # Configure man pager
  export MANPAGER="sh -c 'col -bx | $batcmd -l man -p'"
  export MANROFFOPT="-c"
}

# Prefer bat over batcat, e.g. bat installed in ~/bin
if command -v bat >/dev/null 2>&1; then
  setup_cat_alias "bat"

elif command -v batcat >/dev/null 2>&1; then
  # For Ubuntu and Debian-based `bat` packages
  # the `bat` program is named `batcat` on these systems
  setup_cat_alias "batcat"

fi

unset -f setup_cat_alias
