#!/bin/sh

GROUPNAME="math"
USERNAME="math"

LUID=${LOCAL_UID:-0}
LGID=${LOCAL_GID:-0}

# Step down from host root to well-known nobody/nogroup user

if [ $LUID -eq 0 ]
then
    LUID=65534
fi
if [ $LGID -eq 0 ]
then
    LGID=65534
fi

# Create user and group

groupadd -o -g $LGID $GROUPNAME #>/dev/null 2>&1 ||
groupmod -o -g $LGID $GROUPNAME #>/dev/null 2>&1
useradd -o -m -u $LUID -g $GROUPNAME -s /bin/false $USERNAME #>/dev/null 2>&1 ||
usermod -o -u $LUID -g $GROUPNAME -s /bin/false $USERNAME #>/dev/null 2>&1

# Add jovyan user to group $GROUPNAME
# jovyan is the name for the running user
# see https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile)
usermod -a -G $GROUPNAME jovyan

# Entry point of the base container
#sudo -u jovyan /home/jovyan/tini -g --
sudo -u jovyan tlmgr init-usertree

# Start exec with user sage
# see https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile
exec gosu jovyan:100 "$@"
