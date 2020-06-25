[ -z ${__PATHS_SOURCED__+x} ] && __PATHS_SOURCED__=true || return 0

LIB_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
COMMANDS_LIB_PATH="${LIB_PATH}/commands"
DEPENDENCIES_LIB_PATH="${LIB_PATH}/dependencies"
ROOT="$(realpath ${LIB_PATH}/..)"
DEPENDENCY_DIR="${ROOT}/.bin"
CONFIG_FILE="${ROOT}/config.json"
TERRAFORM_DIR="${ROOT}"
