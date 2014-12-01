### E2FSPROGS ###
_build_e2fsprogs() {
local VERSION="1.42.12"
local FOLDER="e2fsprogs-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/v${VERSION}/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd target/"${FOLDER}"
./configure --host="${HOST}" --prefix="${DEST}" --mandir="${DEST}/man" --disable-elf-shlibs
make
make install
popd
}

_build() {
  _build_e2fsprogs
  _package
}
