#!/bin/bash
#
# Automate the annoying process of creating a vagrant VM and resizing it.
#
SIZE=${SIZE:-204800}
set -ex
vagrant up
vagrant halt
utils/grow-disk.sh -s $SIZE -d
vagrant up
