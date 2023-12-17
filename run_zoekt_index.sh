#! /bin/bash

# Copyright (C) 2020 Google Inc.
#
# This file has been licensed under Apache 2.0 license.  Please see the LICENSE
# file at the root of the repository.

# --- begin runfiles.bash initialization ---
#
# Copy-pasted from Bazel's Bash runfiles library (tools/bash/runfiles/runfiles.bash).
set -eo pipefail
if [[ ! -d "${RUNFILES_DIR:-/dev/null}" && ! -f "${RUNFILES_MANIFEST_FILE:-/dev/null}" ]]; then
  if [[ -f "$0.runfiles_manifest" ]]; then
    export RUNFILES_MANIFEST_FILE="$0.runfiles_manifest"
  elif [[ -f "$0.runfiles/MANIFEST" ]]; then
    export RUNFILES_MANIFEST_FILE="$0.runfiles/MANIFEST"
  elif [[ -f "$0.runfiles/bazel_tools/tools/bash/runfiles/runfiles.bash" ]]; then
    export RUNFILES_DIR="$0.runfiles"
  fi
fi
if [[ -f "${RUNFILES_DIR:-/dev/null}/bazel_tools/tools/bash/runfiles/runfiles.bash" ]]; then
  source "${RUNFILES_DIR}/bazel_tools/tools/bash/runfiles/runfiles.bash"
elif [[ -f "${RUNFILES_MANIFEST_FILE:-/dev/null}" ]]; then
  source "$(grep -m1 "^bazel_tools/tools/bash/runfiles/runfiles.bash " \
            "$RUNFILES_MANIFEST_FILE" | cut -d ' ' -f 2-)"
else
  echo >&2 "ERROR: cannot find @bazel_tools//tools/bash/runfiles:runfiles.bash"
  exit 1
fi
# --- end runfiles.bash initialization ---

# This is seriously weird: should I be guessing the OS and architecture to get
# at a binary that I want to use?
readonly _gotopt_binary="$(rlocation gotopt2/cmd/gotopt2/gotopt2_/gotopt2)"
readonly _zoekt_index_binary="$(rlocation com_github_google_zoekt/cmd/zoekt-index/zoekt-index_/zoekt-index)"
# Exit quickly if the binary isn't found. This may happen if the binary location
# moves internally in bazel.
if [ -x "$(command -v ${_gotopt2_binary})" ]; then
  echo "gotopt2 binary not found"
  exit 240
fi

GOTOPT2_OUTPUT=$($_gotopt_binary "${@}" <<EOF
flags:
- name: "top-dir"
  type: string
  help: "The name of the top level directory to index"
  default: "${BUILD_WORKSPACE_DIRECTORY}"
- name: "zoekt-index-binary"
  type: string
  help: "The path to the zoekt-index binary"
  default: "${_zoekt_index_binary}"
- name: "zoekt-index"
  type: string
  help: "The directory to store index."
  default: "$HOME/.cache/bazoekt"
EOF
)
if [[ "$?" == "11" ]]; then
  # When --help option is used, gotopt2 exits with code 11.
  exit 1
fi

# Evaluate the output of the call to gotopt2, shell vars assignment is here.
eval "${GOTOPT2_OUTPUT}"

if [[ "${gotopt2_top_dir}" == "" ]]; then
  echo "The flag --top-dir=... is required"
  exit 1
fi

if [[ "${gotopt2_zoekt_index_binary}" == "" ]]; then
  echo "Could not find zoekt-index binary; see --help for details"
  exit 1
fi

"${_zoekt_index_binary}" -index ${gotopt2_zoekt_index} "${gotopt2_top_dir}"
