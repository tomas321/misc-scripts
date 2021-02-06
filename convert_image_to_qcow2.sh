#!/bin/bash
#
# converts the supported image format to qcow2 compatible with KVM libvirt
#
# usage:
#   $0 IMAGE_FILE DEST_FILE
#

fail() {
    echo -e "error: $*" && exit 1
}

usage="usage: $0 IMAGE_FILE DEST_FILE"

[[ $# -eq 2 ]] || fail "\n    $usage"

image="$1"
dest="$2"

qemu-img convert -O qcow2 "$image" "$dest"
