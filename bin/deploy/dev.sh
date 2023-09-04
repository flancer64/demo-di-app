#!/usr/bin/env bash
##
# Rebuild the JS project with modules placed in inner folders.
##
# Root directory (relative to the current shell script, not to the execution point)
DIR_ROOT=${DIR_ROOT:-$(cd "$(dirname "$0")/../../" && pwd)}
DIR_NODE="${DIR_ROOT}/node_modules"
DIR_OWN="${DIR_ROOT}/own_modules"

##
# Internal function to clone & link one GitHub repo
##
processRepo() {
  NAME="@${1}"
  REPO="https://github.com/${1}.git"
  if test ! -d "${DIR_OWN}/${NAME}"; then
    echo "Clone repo '${NAME}' to '${DIR_OWN}'."
    git clone "${REPO}" "${DIR_OWN}/${NAME}"
  fi
  echo "Link sources from '${NAME}' to '${DIR_NODE}'."
  rm -fr "${DIR_NODE:?}/${NAME}" && ln -s "${DIR_OWN}/${NAME}" "${DIR_NODE}/${NAME}"
}

##
# MAIN FUNCTIONALITY
##
echo "Remove installed dependencies and lock file."
rm -fr "${DIR_NODE}" "${DIR_ROOT}/package-lock.json"

echo "Re-install JS project."
cd "${DIR_ROOT}" || exit 255
npm install --omit=optional

if test ! -d "${DIR_NODE}/@flancer64"; then
  echo "Create folder '${DIR_NODE}/@flancer64'."
  mkdir -p "${DIR_NODE}/@flancer64"
fi

echo "Clone dependencies from github in inner folders."
mkdir -p "${DIR_OWN}/@flancer64/"

processRepo "flancer64/demo-di-lib"
processRepo "teqfw/di"

echo ""
echo "App deployment in 'dev' mode is done."
