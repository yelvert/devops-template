[ -z ${__DEPENDENCIES_JQ_SOURCED__+x} ] && __DEPENDENCIES_JQ_SOURCED__=true || return 0

. $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../paths.sh

JQ_VERSION="1.6"
JQ="${DEPENDENCY_DIR}/jq"

if
  [ -f "${JQ}" ] &&
  [ "$(${JQ} --version)" != "jq-${JQ_VERSION}" ]
then
  echo "Updating JQ"
  rm "${JQ}"
fi
if [ ! -f "${JQ}" ] ; then
  function __install_jq__ () {
    echo "Fetching JQ"
    local base_url="https://github.com/stedolan/jq/releases/download/jq-"
    local platform=$(uname)
    local arch=$(uname -m)
    local is64="false"
    [ "${arch}" == "x86_64" ] && is64="true"
    $is64 || { echo "jq requires 64-bit"; exit 1; }
    local ismac="false"
    if [ "${platform}" == "Darwin" ]; then
      ismac="true"
      platform="osx-amd64"
    else
      platform="linux64"
    fi
    local download_url="${base_url}${JQ_VERSION}/jq-${platform}"
    cd $DEPENDENCY_DIR \
      && curl -L -o jq $download_url \
      && chmod u+x jq
  }
  __install_jq__
  echo "JQ installed to ${JQ}"
fi

function jq () {
  local command="${JQ}"
  for a in "$@" ; do
    command+=" \"${a}\""
  done
  eval $command
}
