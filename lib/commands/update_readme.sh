if [ -z ${__COMMANDS_UPDATE_README_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../paths.sh

  AVAILABLE_COMMANDS+=('update_readme')
  README_PATH="${ROOT}/README"
  README_TEMPLATE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/readme.template"

  function command.update_readme () {
        local usage="$(
      cat <<HELP
$(command.help)

$(
  for command in "${AVAILABLE_COMMANDS[@]}"; do
    echo -e "\n\n\n\n----- ${command}\n$("command.${command}.help")"
  done
)

HELP
)
"
    sed -e "s/!!USAGE!!/$(printf '%s' "${usage}" | tr '\n' '\r' | sed 's/[\&/]/\\&/g')/g" "${README_TEMPLATE}" | tr '\r' '\n' > "${README_PATH}"
  }

  function command.update_readme.description () {
    echo "Updates the README with current usage information."
  }

  function command.update_readme.help () {
    echo -e "\nUsage: update_readme\n"
  }

  __COMMANDS_UPDATE_README_SOURCED__=true
fi
