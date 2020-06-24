if [ -z ${__DEPENDENCIES_SOURCED__+x} ]; then
  . $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/paths.sh

  [ -d "${DEPENDENCY_DIR}" ] || mkdir -p "${DEPENDENCY_DIR}"

  for file in $DEPENDENCIES_LIB_PATH/*.sh ; do . "${file}" ; done

  __DEPENDENCIES_SOURCED__=true
fi
