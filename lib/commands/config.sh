if [ -z ${__COMMANDS_CONFIG_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../paths.sh
  . "${LIB_PATH}/config.sh"

  AVAILABLE_COMMANDS+=('config')

  function command.config () {
    local command_or_path="${1:-all}"
    if [ "${command_or_path}" == "help" ] ; then
      command.config.help
    elif [ "${command_or_path}" == "all" ] ; then
      config
    else
      config "${command_or_path}"
    fi
  }

  function command.config.description () {
    echo "Displays config information"
  }

  function command.config.help () {
    local usage="$(
      cat <<HELP
Usage: config [PATH]

PATH can be a \`jq\` path to any variable in ${CONFIG_FILE}

HELP
)
"
    echo -e "${usage}"
  }

  __COMMANDS_CONFIG_SOURCED__=true
fi
