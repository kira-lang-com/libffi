#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 4 ]]; then
  echo "usage: $0 <output-root> <install-root> <package-name> <lib-pattern> [<lib-pattern> ...]" >&2
  exit 1
fi

output_root=$1
install_root=$2
package_name=$3
shift 3

package_dir="$output_root/$package_name"
rm -rf "$package_dir"
mkdir -p "$package_dir/include" "$package_dir/lib"

if [[ ! -d "$install_root/include" ]]; then
  echo "Missing include directory under '$install_root'." >&2
  exit 1
fi

cp -R "$install_root/include/." "$package_dir/include/"

shopt -s nullglob dotglob
matched=0
for pattern in "$@"; do
  for file in "$install_root"/lib/$pattern; do
    cp -P "$file" "$package_dir/lib/"
    matched=1
  done
done
shopt -u nullglob dotglob

if [[ $matched -eq 0 ]]; then
  echo "No libraries matched under '$install_root/lib'." >&2
  exit 1
fi
