[ -z ${__COMMANDS_HELP_SOURCED__+x} ] && __COMMANDS_HELP_SOURCED__=true || return 0

. $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../paths.sh

AVAILABLE_COMMANDS+=('help')

function command.help () {
  local command="${1:-help}"
  if available_command? "${command}" ; then
    "command.${command}.help"
  else
    cat <<-EOF
Unknown command: ${command}

Available commands
$(
  for c in "${AVAILABLE_COMMANDS[@]}"; do
    echo -e "  ${c}"
  done
)
EOF
    exit 100
  fi
}

function command.help.description () {
  echo "Displays the full usage information."
}

function command.help.help () {
  local usage="$(
    cat <<HELP

Usage: ${0} [GLOBAL_OPTIONS] COMMAND [ARGUMENTS]

GLOBAL_OPTIONS
  -v(vvv) | --verbose=#
    Sets the verbosity level. -v would set the level to 1, -vvvv would set it to 4. Can also be used as --verbosity=4 to set the level directly.

COMMAND
$(
  echo "$(
    for command in "${AVAILABLE_COMMANDS[@]}"; do
      echo -e "  ${command}\t$("command.${command}.description")"
    done
  )" | column -t -s $'\t' -x
)

HELP
)
"
  echo -e "${usage}"
}
