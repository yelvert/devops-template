[ -z ${__UTILS_SOURCED__+x} ] && __UTILS_SOURCED__=true || return 0

. $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/paths.sh

array_contains () { 
  local array="$1[@]"
  local seeking=$2
  local in=1
  for element in "${!array}"; do
      if [[ $element == "$seeking" ]]; then
          in=0
          break
      fi
  done
  return $in
}
