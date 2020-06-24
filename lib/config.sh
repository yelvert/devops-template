if [ -z ${__CONFIG_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/paths.sh
  . "${DEPENDENCIES_LIB_PATH}/jq.sh"

  if [ ! -f $CONFIG_FILE ]; then
    echo "Missing config file, see ${CONFIG_FILE}.example"
    exit 127
  fi

  function config () {
    cat "${CONFIG_FILE}" | jq -r ".${1:-}"
  }

  __CONFIG_SOURCED__=true
fi
