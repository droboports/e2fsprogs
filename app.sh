### E2FSPROGS ###
_build_e2fsprogs() {
local BRANCH="master"
local FOLDER="e2fsprogs"
local URL="https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git"

_download_git "${BRANCH}" "${FOLDER}" "${URL}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEST}" --mandir="${DEST}/man" --disable-elf-shlibs
make
make install
popd
}

_build() {
  _build_e2fsprogs
  _package
}
