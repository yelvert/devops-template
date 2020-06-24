if [ -z ${__COMMANDS_HELP_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../paths.sh

  AVAILABLE_COMMANDS+=('help')

  function command.help () {
    command.help.help
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

  __COMMANDS_HELP_SOURCED__=true
fi
