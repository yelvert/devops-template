if [ -z ${__DEPENDENCIES_ANSIBLE_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../paths.sh

  ANSIBLE_VERSION="2.9.9"
  ANSIBLE="${DEPENDENCY_DIR}/ansible"
  ANSIBLE_BIN="${ANSIBLE}/bin"
  ANSIBLE_PYTHON="$(which python3)"
  ANSIBLE_PIP="$(which pip3)"
  ANSIBLE_PLUGIN_PATH="${ANSIBLE}/plugins/modules"
  ANSIBLE_PREFIX="PYTHONPATH=${ANSIBLE}/lib/python3.7/site-packages/:${ANSIBLE}/lib64/python3.7/site-packages ANSIBLE_LIBRARY=${ANSIBLE_PLUGIN_PATH}"
  ANSIBLE_EXEC="${ANSIBLE_PREFIX} ${ANSIBLE_BIN}"

  if
    [ -f "${ANSIBLE_EXEC}" ] &&
    [ "$(ansible --version)" != "ansible ${ANSIBLE_VERSION}*" ]
  then
    echo "Updating ANSIBLE"
    rm -rf "${ANSIBLE}"
  fi
  if [ ! -d "${ANSIBLE}" ]; then
    "${ANSIBLE_PIP}" install --install-option="--prefix=${ANSIBLE}" "ansible==${ANSIBLE_VERSION}" netaddr
  fi
  if [ ! -d "${ANSIBLE_PLUGIN_PATH}" ]; then
    mkdir -p "${ANSIBLE_PLUGIN_PATH}"
  fi

  for binary in ansible ansible-connection ansible-doc ansible-inventory ansible-pull ansible-vault ansible-config ansible-console ansible-galaxy ansible-playbook ansible-test; do
    eval "
      function ${binary} () {
        local command=\"\${ANSIBLE_EXEC}/${binary}\"
        for a in \"\$@\" ; do
          command+=\" \\\"\${a}\\\"\"
        done
        eval \$command
      }
    "
  done

  __DEPENDENCIES_ANSIBLE_SOURCED__=true
fi
