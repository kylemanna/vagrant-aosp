#!/bin/bash
#
# Usage: $0 [-s SIZE_MB] [-d]
#
set -e

while getopts ":s:d" opt; do
    case $opt in
        s)
            size="$OPTARG"
            echo "New size: $size" >&2
            ;;
        d)
            delete="true"
            echo "Deleting old image" >&2
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

vm_uuid=$(cat .vagrant/machines/default/virtualbox/id)

orig_disk=$(VBoxManage showvminfo --machinereadable $vm_uuid  | grep ^\"SATAController-0-0 | sed -e 's:^.*"\(.*\)"$:\1:')
new_disk=${orig_disk/%.vmdk/.vdi}

echo "Cloning \"$orig_disk\" -> \"$new_disk\""
VBoxManage clonehd "$orig_disk" "$new_disk" --format VDI

echo "Configuring VM to use new disk"
VBoxManage storageattach $vm_uuid --storagectl SATAController --port 0 --device 0 --type hdd --medium "$new_disk"

if [ -n "$size" ]; then
    echo "Resizing \"$new_disk\" to $size"
    VBoxManage modifyhd "$new_disk" --resize $size
fi

if [ -n "$delete" ]; then
    VBoxManage closemedium disk "$orig_disk"
    rm -i "$orig_disk"
fi
