if [ -z ${__COMMANDS_VERSION_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../paths.sh

  AVAILABLE_COMMANDS+=('version')

  function command.version () {
    local command_or_package="${1:-all}"
    if [ "${command_or_package}" == "all" ] || [ "${command_or_package}" == "ansible" ] ; then
      echo "=========== ansible =========="
      ansible --version
    fi
    if [ "${command_or_package}" == "all" ] || [ "${command_or_package}" == "aws" ] ; then
      echo "=========== aws =========="
      aws --version
    fi
    if [ "${command_or_package}" == "all" ] || [ "${command_or_package}" == "jq" ] ; then
      echo "=========== jq =========="
      jq --version
    fi
    if [ "${command_or_package}" == "all" ] || [ "${command_or_package}" == "packer" ] ; then
      echo "=========== packer =========="
      packer --version
    fi
    if [ "${command_or_package}" == "all" ] || [ "${command_or_package}" == "terraform" ] ; then
      echo "=========== terraform =========="
      terraform --version
    fi
  }

  function command.version.description () {
    echo "Displays version information"
  }

   function command.version.help () {
    local usage="$(
      cat <<HELP
Usage: version [PACKAGE]

PACKAGE
$(
  echo "$(
    for package in ansible aws jq packer terraform; do
      echo -e "  ${package}\tDisplay version information for ${package}."
    done
    echo -e "  all\tDisplay version information for all packages."
  )" | column -t -s $'\t' -x
)

HELP
)
"
    echo -e "${usage}"
  }

  __COMMANDS_VERSION_SOURCED__=true
fi
