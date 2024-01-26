#!/usr/bin/env bash

# name of ensemble member and CMORized name - MAKE SURE THESE MATCH!!!
ensname="20191024.en1.LE_ens_1.ne30_oECv3_ICG.compy"
cmorname="r1i2p2f1"

# locations of files
basedir="/glade/derecho/scratch/samantha/E3SMv1LE/historical/"

# locations of output files
OUTPUT_DIR=/glade/derecho/scratch/samantha/E3SMv1LE/CMOR/

# files to split
list=`ls ${basedir[m]}/${ensname}/mpaso.hist.am.highFrequencyOutput*nc`

cd ${basedir[m]}/${ensname}/

for hf in ${list}
do

   # Get portion of filename associated with the year
   froot=${hf%.nc}
   fnam=${froot##*Output.}
   echo ${fnam}

   # Extract SSH, SST information
   echo ncks -v temperatureAtSurface ${hf} sst_${fnam}.nc
   ncks -v temperatureAtSurface ${hf} sst_${fnam}.nc

   echo ncks -v ssh ${hf} ssh_${fnam}.nc
   ncks -v ssh ${hf} ssh_${fnam}.nc

done

# Concatenate year files into a single file
ncrcat sst*.nc tos_day_E3SM-1-0_historical_${cmorname}_gr_18500101-20151231.nc
ncrcat ssh*.nc zos_day_E3SM-1-0_historical_${cmorname}_gr_18500101-20151231.nc

# Rename concatenated variables to CMORized names
ncrename -v temperatureAtSurface,tos tos_day_E3SM-1-0_historical_${cmorname}_gr_18500101-20151231.nc
ncrename -v ssh,zos zos_day_E3SM-1-0_historical_${cmorname}_gr_18500101-20151231.nc

# Make new directory if it doesn't already exist
mkdir -p /glade/campaign/cgd/ccr/E3SMv1-LE/CMOR/historical/${cmorname}/day/tos
mkdir -p /glade/campaign/cgd/ccr/E3SMv1-LE/CMOR/historical/${cmorname}/day/zos

# Copy the output into the new location
cp tos_day_E3SM-1-0_historical_${cmorname}_gr_18500101-20151231.nc /glade/campaign/cgd/ccr/E3SMv1-LE/CMOR/historical/${cmorname}/day/tos
cp zos_day_E3SM-1-0_historical_${cmorname}_gr_18500101-20151231.nc /glade/campaign/cgd/ccr/E3SMv1-LE/CMOR/historical/${cmorname}/day/zos

