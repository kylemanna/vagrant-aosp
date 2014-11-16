Vagrant Development Environment for AOSP
========================================

Vagrant build for providing a dev and build environment for AOSP.

Heavily leverages [kylemanna/aosp](https://github.com/kylemanna/docker-aosp) to do the actual building which should be consistent with production build and test integration servers.

It makes no sense to use this on Linux machines, instead use [kylemanna/aosp](https://github.com/kylemanna/docker-aosp) directly for best performance.  The intent of this Vagrant machine is to help those poor fellow forced to work with Mac OS X or worse yet -- Windows!

Quickstart
----------

1. Fetch the repository:

        git clone https://github.com/kylemanna/vagrant-aosp.git
        cd vagrant-aosp

2. Configure the virtual machine's hardware:

        cp config.rb.sample config.rb
        vim config.rb

3. Employ a hack to grow the base Ubuntu disk image to something usable, wait 10 minutes:

        utils/init.sh

4. Login to the machine:

        vagrant ssh

5. Review [kylemanna/aosp](https://github.com/kylemanna/docker-aosp) for next steps.

