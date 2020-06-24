if [ -z ${__DEPENDENCIES_PACKER_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../paths.sh
  . "${LIB_PATH}/config.sh"

  PACKER_VERSION="1.6.0"
  PACKER="${DEPENDENCY_DIR}/packer"

  if
    [ -f "${PACKER}" ] &&
    [ "$(${PACKER} --version)" != "${PACKER_VERSION}" ]
  then
    echo "Updating Packer"
    rm "${PACKER}"
  fi
  if [ ! -f "${PACKER}" ] ; then
    echo "Fetching Packer"
    function __install_packer__ () {
      local base_url="https://releases.hashicorp.com/packer/"
      local platform=$(uname)
      local ismac="false"
      if [ "${platform}" == "Darwin" ]; then
        ismac="true"
        platform="darwin"
      fi
      local arch=$(uname -m)
      local is64="false"
      [ "${arch}" == "x86_64" ] && is64="true"
      $ismac && platform="darwin" || platform="linux"
      $is64 && arch="amd64" || arch="386"
      local packer_url="${base_url}${PACKER_VERSION}/packer_${PACKER_VERSION}_${platform}_${arch}.zip"
      echo "Downloading packer: ${packer_url}"
      cd $DEPENDENCY_DIR \
        && curl -o packer.zip $packer_url \
        && unzip packer.zip \
        && rm packer.zip
    }
    __install_packer__
    echo "Packer installed to ${PACKER}"
  fi

  function packer () {
    local command="${PACKER} ${1}"
    shift
    command+=" -var-file ${CONFIG_FILE}"
    for a in "$@" ; do
      command+=" \"${a}\""
    done
    eval $command
  }

  __DEPENDENCIES_PACKER_SOURCED__=true
fi
