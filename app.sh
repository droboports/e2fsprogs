### E2FSPROGS ###
_build_e2fsprogs() {
local VERSION="1.42.13"
local FOLDER="e2fsprogs-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="http://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/v${VERSION}/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
cp "src/${FOLDER}-dumpe2fs.patch" "target/${FOLDER}/"
pushd "target/${FOLDER}"
patch -p1 -i "${FOLDER}-dumpe2fs.patch"
./configure --host="${HOST}" --prefix="${DEST}" --mandir="${DEST}/man" --enable-symlink-install --enable-relative-symlinks --enable-symlink-build --enable-elf-shlibs --enable-threads=posix --disable-rpath
make
make install
find "${DEST}" -type f -executable -print | while read binfile; do
  if file "${binfile}" | grep -q "executable, ARM"; then
    echo "${binfile}"
    "${STRIP}" -s -R .comment -R .note -R .note.ABI-tag "${binfile}"
  fi
done
popd
}

_build_rootfs() {
# /bin/uuidgen
# /lib/e2initrd_helper
# /sbin/badblocks
# /sbin/dumpe2fs
# /sbin/e2freefrag
# /sbin/e2fsck
# /sbin/e4defrag
# /sbin/filefrag
# /sbin/fsck.ext3
# /sbin/fsck.ext4
# /sbin/mke2fs
# /sbin/mke2fs.ext3
# /sbin/mke2fs.ext4
# /sbin/uuidd
  return 0
}

_build() {
  _build_e2fsprogs
  _package
}
