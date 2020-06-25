[ -z ${__DEPENDENCIES_AWS_SOURCED__+x} ] && __DEPENDENCIES_AWS_SOURCED__=true || return 0

. $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../paths.sh
. "${LIB_PATH}/config.sh"

AWSCLI_SRC="${DEPENDENCY_DIR}/aws-cli"
AWSCLI="${DEPENDENCY_DIR}/aws"

if [ ! -f "${AWSCLI}" ] ; then
  echo "Fetching AWS CLI"
  (
    cd $DEPENDENCY_DIR
    curl -L -o awscli-bundle.zip "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip"
    unzip awscli-bundle.zip
    awscli-bundle/install -i "${AWSCLI_SRC}" -b "${AWSCLI}"
    rm "${AWSCLI}"
    ln -s aws-cli/bin/aws "${AWSCLI}"
    rm -rf awscli-bundle.zip awscli-bundle
    echo "AWS CLI installed to ${AWSCLI}"
  )
fi

function aws () {
  local access_key=$(config '.access_key')
  local secret_key=$(config '.secret_key')
  local region=$(config '.region')
  local command="AWS_ACCESS_KEY_ID=${access_key} AWS_SECRET_ACCESS_KEY=${secret_key} AWS_DEFAULT_REGION=${region} ${AWSCLI}"
  for a in "$@" ; do
    command+=" \"${a}\""
  done
  eval $command
}
