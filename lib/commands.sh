if [ -z ${__COMMANDS_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/paths.sh

  AVAILABLE_COMMANDS=()

  for file in $COMMANDS_LIB_PATH/*.sh ; do . "${file}" ; done

  function available_command? () {
    array_contains AVAILABLE_COMMANDS "${1}"
  }

  __COMMANDS_SOURCED__=true
fi
