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

# Add $USERNAME user to group of jovyan (group 100)
# jovyan is the name for the running user
# see https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile)
usermod -a -G 100 $USERNAME

# Correct user to /work
sudo chown -R $USERNAME:$GROUPNAME /host/work
sudo chown -R $USERNAME:$GROUPNAME /host/texmf

# Link /host/texmf to the configured texmfhome
sudo -u math ln -s /host/texmf/ /home/math/texmf

# Init texmf directory
sudo -u math tlmgr init-usertree

# Start exec with user sage
# see https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile
exec gosu $USERNAME:$GROUPNAME "$@"
