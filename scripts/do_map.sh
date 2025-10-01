#!/bin/bash

WF="map" # name of the workflow

LATENCY_WAIT=60 # seconds to wait after rule for output files to appear
LOGFILE="$WF-`date -Is`.log"

# use the current directory as the working directory, but replace /fastshare/ with /share/
ORIGWD=`realpath .`
WD="${ORIGWD/#\/fastshare\//\/share\/}"
echo "WD: $WD " >&2
cd $WD >&2


# use the cluster config to set slurm arguments
SM_CLUSTER_CONFIG="$WF.cluster_config"
SM_PARAMS="ntasks partition time mail-user mail-type error output"
SM_ARGS="--cpus-per-task {threads} --mem {cluster.mem}"
#SM_ARGS="--chdir \"$WD\" --cpus-per-task {threads} --mem {cluster.mem}"
for P in ${SM_PARAMS}; do SM_ARGS="$SM_ARGS --$P {cluster.$P}"; done
echo "SM_ARGS: ${SM_ARGS}"


# slurm expect a slurm_logs/ subdir in cwd
mkdir -p slurm_logs

#
script --flush --return "$LOGFILE" --command "\
snakemake \
-s \"$WF.snake\" \
--rerun-incomplete \
-pr \
--keep-going \
--keep-target-files \
--latency-wait $LATENCY_WAIT \
-j 32 \
--jobname \"$WF-{rule}.{jobid}\" \
"
RV=$?


# return to the original working directory
cd $ORIGWD >&2

# email completion notification
if [ ! -z "$MAILDEST" ]; then # MAILDEST should be set in the environment to where mail should go
  # the sed part strips out color control sequences
  cat "$LOGFILE"  | sed -r "s/[[:cntrl:]]\[[0-9]{1,3}m//g" | mail -s "done: $WF ($RV)" $MAILDEST
fi
