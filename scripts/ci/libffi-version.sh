#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
repo_root=$(cd "$script_dir/../.." && pwd)

config_version=$(sed -nE "s/^AC_INIT\\(\\[libffi\\],[[:space:]]*\\[([^]]+)\\].*/\\1/p" "$repo_root/configure.ac")
if [[ -z "$config_version" ]]; then
  echo "Failed to parse the libffi version from configure.ac." >&2
  exit 1
fi

ref_name="${1:-${GITHUB_REF_NAME:-}}"
if [[ "$ref_name" == refs/tags/v* ]]; then
  ref_name="${ref_name##refs/tags/}"
fi

if [[ "$ref_name" == v* ]]; then
  tag_version="${ref_name#v}"
  if [[ "$tag_version" != "$config_version" ]]; then
    echo "Release tag version '$tag_version' does not match configure.ac version '$config_version'." >&2
    exit 1
  fi
  printf '%s\n' "$tag_version"
  exit 0
fi

printf '%s\n' "$config_version"
