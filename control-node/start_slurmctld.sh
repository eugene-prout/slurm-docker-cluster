#!/bin/bash
set -e

echo "---> Starting the MUNGE Authentication service (munged) ..."
gosu munge /usr/sbin/munged

echo "---> Waiting for slurmdbd to become active before starting slurmctld ..."

until 2>/dev/null >/dev/tcp/slurmdbd/6819
do
    echo "---> slurmdbd is not available.  Sleeping ..."
    sleep 2
done
echo "---> slurmdbd is now active ..."

echo "---> Starting the Slurm Controller Daemon (slurmctld) ..."

if /usr/sbin/slurmctld -V | grep -q '17.02' ; then
    exec gosu slurm /usr/sbin/slurmctld -Dvvv
else
    exec gosu slurm /usr/sbin/slurmctld -i -Dvvv
fi
