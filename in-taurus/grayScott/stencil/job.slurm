#!/bin/bash
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --time 00:05:00
#SBATCH --mem-per-cpu 1900
#SBATCH --partition haswell
#SBATCH --job-name grayScott_stencil
#SBATCH --output=output-node--job-%j.out
#SBATCH --error=error-01-node-%N-job-%j.err
module load Python libxml2 bzip2 CMake OpenMPI GCCcore/9.1.0
#srun -n 4 -N 1 --time=00:05:00  ./main
#mpirun -np 2 ./main

./main
