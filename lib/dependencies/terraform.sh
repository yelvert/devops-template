if [ -z ${__DEPENDENCIES_TERRAFORM_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../paths.sh
  . "${LIB_PATH}/config.sh"

  TERRAFORM_VERSION="0.12.26"
  TERRAFORM="${DEPENDENCY_DIR}/terraform"

  if
    [ -f "${TERRAFORM}" ] &&
    [[ "$(${TERRAFORM} --version)" != "Terraform v${TERRAFORM_VERSION}"* ]]
  then
    echo "Updating Terraform"
    rm "${TERRAFORM}"
  fi
  if [ ! -f "${TERRAFORM}" ] ; then
    echo "Fetching Terraform"
    function __install_terraform__ () {
      local base_url="https://releases.hashicorp.com/terraform/"
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
      local download_url="${base_url}${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${platform}_${arch}.zip"
      echo "Downloading terraform: ${download_url}"
      cd $DEPENDENCY_DIR \
        && curl -o terraform.zip $download_url \
        && unzip terraform.zip \
        && rm terraform.zip
    }
    __install_terraform__
    echo "Terraform installed to ${TERRAFORM}"
  fi

  function terraform_init () {
    (
      cd "${TERRAFORM_DIR}"
      local access_key=$(config '.access_key')
      local secret_key=$(config '.secret_key')
      $TERRAFORM \
        init \
        -backend-config="access_key=${access_key}" \
        -backend-config="secret_key=${secret_key}"
    )
  }

  function terraform_output () {
    (
      cd "${TERRAFORM_DIR}"
      local command="\"${TERRAFORM}\" output -json"
      for a in "$@" ; do
        command+=" \"${a}\""
      done
      eval $command
    )
  }

  function terraform () {
    (
      cd "${TERRAFORM_DIR}"
      local command="${TERRAFORM}"
      for a in "$@" ; do
        command+=" \"${a}\""
      done
      eval $command
    )
  }

  __DEPENDENCIES_TERRAFORM_SOURCED__=true
fi
