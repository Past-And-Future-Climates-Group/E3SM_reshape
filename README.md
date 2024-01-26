# Script to post-process E3SM output

This repository contains some scripts to do manual CMORization of output from the E3SMv1 Large Ensemble (Stevenson et al. 2023). 

The raw output is located on the NERSC HPSS system, and should be transferred via Globus to the NCAR Glade system in order to run the scripts below.

Contents of the repository:
- extract_concat_var.sh
  Shell script to extract daily ocean variables from annual output files, concatenate into a single file, rename according to CMOR conventions, and move to main E3SMv1 storage area
