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

RLOC_gotopt2="${RLOC_gotopt2:-gotopt2/cmd/gotopt2/gotpt2_/gotopt2}"
RLOC_zoekt="${RLOC_zoekt:-com_github_google_zoekt/cmd/zoekt-index/zoekt-index_/zoekt-index}"
readonly _gotopt_binary="$(rlocation ${RLOC_gotopt2})"
readonly _zoekt_webserver_binary="$(rlocation ${RLOC_zoekt})"
# Exit quickly if the binary isn't found. This may happen if the binary location
# moves internally in bazel.
if [ -x "$(command -v ${_gotopt2_binary})" ]; then
  echo "gotopt2 binary not found"
  exit 240
fi

GOTOPT2_OUTPUT=$($_gotopt_binary "${@}" <<EOF
flags:
- name: "zoekt-webserver-binary"
  type: string
  help: "The path to the zoekt-webserver binary"
  default: "${_zoekt_webserver_binary}"
- name: "zoekt-index"
  type: string
  help: "The directory to store index."
  default: "$HOME/.cache/bazoekt"
- name: "hostport"
  type: string
  help: "The hostport to listen at"
  default: ":6070"
EOF
)
if [[ "$?" == "11" ]]; then
  # When --help option is used, gotopt2 exits with code 11.
  exit 1
fi

# Evaluate the output of the call to gotopt2, shell vars assignment is here.
eval "${GOTOPT2_OUTPUT}"

if [[ "${gotopt2_zoekt_webserver_binary}" == "" ]]; then
  echo "Could not find zoekt-webserver binary; see --help for details"
  exit 1
fi

"${gotopt2_zoekt_webserver_binary}" \
  -listen "${gotopt2_hostport}" \
  -index "${gotopt2_zoekt_index}"

