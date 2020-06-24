if [ -z ${__COMMON_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/paths.sh
  . "${LIB_PATH}/utils.sh"
  . "${LIB_PATH}/dependencies.sh"
  . "${LIB_PATH}/config.sh"

  __COMMON_SOURCED__=true
fi
