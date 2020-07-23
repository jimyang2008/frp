#!/bin/bash

GIT_ROOT=$(git rev-parse --show-toplevel)

log() {
    echo "$(date): $@"
}

err() {
    log "ERROR: $@" >&2
}

# ----------------------------------------------------------------------------
# MAIN goes here
# ----------------------------------------------------------------------------

( cd $GIT_ROOT

log Build ...
#make
log Install binaries ...
sudo install -v bin/frpc /usr/local/bin/
sudo install -v bin/frps /usr/local/bin/
log Install config files ...
sudo rsync -rlptv files/ /
if [[ -d /etc/rc.d/ ]]; then
    sudo chkconfig --add frps
else
    sudo systemctl status frpc
    sudo systemctl status frps
fi
)
