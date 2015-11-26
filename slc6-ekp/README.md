mschnepf/slc6-ekp
================
run as root setup.sh on the host system to install and configure docker and cvmfs 

$ docker run -it --rm -v /cvmfs/cms.cern.ch:/cvmfs/cms.cern.ch -v /local/scratch/docker/security:/etc/condor/security mschnepf/slc6-ekp /bin/bash


