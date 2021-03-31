#!/bin/bash
#SBATCH --job-name=OpenFPMBenchmark
#SBATCH --mem-per-cpu=2583
#SBATCH --partition=haswell
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --exclusive
#SBATCH --output=console/output/cores-01-node-%N-job-%j.out
#SBATCH --error=console/error/cores-01-node-%N-job-%j.err



if command -v sbatch &> /dev/null; then
    module load Python libxml2 bzip2 CMake OpenMPI GCCcore/9.1.0
    shopt -s expand_aliases
    alias pipenv=~/.local/bin/pipenv
fi

TASKNAME=${1}
TECHNIQUE=${2}
TIMELIMIT=${3}

if [ "$TECHNIQUE" == "model-predict" ]; then
    pipenv run ../dTuner/dTuner.py --working-dir runDir --shortcut-known-files --technique model-predict --additional-working-dir-extension $TASKNAME
elif [ "$TECHNIQUE" == "model-search" ]; then
    pipenv run ../dTuner/dTuner.py --working-dir runDir --shortcut-known-files --technique model-search --additional-working-dir-extension $TASKNAME
else
    pipenv run ../dTuner/dTuner.py --working-dir runDir --shortcut-known-files --technique opentuner --additional-working-dir-extension "${TASKNAME}_${TECHNIQUE}" --opentuner-args "--technique $TECHNIQUE --stop-after $TIMELIMIT"
fi
