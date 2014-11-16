#!/bin/bash
#
# Automate the annoying process of creating a vagrant VM and resizing it.
#

# Vagrant (net-ssh) blows up for people using ed25519 keys loaded into an
# ssh-agent, references:
# https://github.com/mitchellh/vagrant/issues/4367
# https://github.com/net-ssh/net-ssh/pull/162
#
# Workaround:
unset SSH_AUTH_SOCK

SIZE=${SIZE:-204800}
set -ex
vagrant up
vagrant halt
utils/grow-disk.sh -s $SIZE -d
vagrant up
